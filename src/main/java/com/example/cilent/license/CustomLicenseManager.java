package com.example.cilent.license;



import com.example.cilent.common.config.License;
import com.example.licese.entity.LicenseCheckModel;
import de.schlichtherle.license.*;
import de.schlichtherle.xml.GenericCertificate;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.beans.XMLDecoder;
import java.io.*;
import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 * 自定义LicenseManager，用于增加额外的服务器硬件信息校验
 */
@Slf4j
public class CustomLicenseManager extends LicenseManager {

    //XML编码
    private static final String XML_CHARSET = "UTF-8";
    //默认BUFSIZE
    private static final int DEFAULT_BUFSIZE = 8 * 1024;

    public CustomLicenseManager() {

    }

    public CustomLicenseManager(LicenseParam param) {
        super(param);
    }

    /**
     * 复写create方法
     *
     * @return byte[]
     */
    @Override
    protected synchronized byte[] create(
            LicenseContent content,
            LicenseNotary notary)
            throws Exception {
        initialize(content);
        this.validateCreate(content);
        final GenericCertificate certificate = notary.sign(content);
        return getPrivacyGuard().cert2key(certificate);
    }

    /**
     * 复写install方法，其中validate方法调用本类中的validate方法，校验IP地址、Mac地址等其他信息
     *
     * @param
     * @return de.schlichtherle.license.LicenseContent
     */
    @Override
    protected synchronized LicenseContent install(
            final byte[] key,
            final LicenseNotary notary)
            throws Exception {
        final GenericCertificate certificate = getPrivacyGuard().key2cert(key);
        log.info("key:{}", key);
        log.info("LicenseNotary:{}", notary);
        log.info("信息：{}", certificate);
        notary.verify(certificate);

        final LicenseContent content = (LicenseContent) this.load(certificate.getEncoded());
        log.info("certificate.getEncoded():{}",certificate.getEncoded());
       log.info("content证书名：{}",content.getSubject());
       log.info("content证书描述信息:{}",content.getInfo());
        log.info("content硬件信息:{}", content.getExtra());
        log.info("content基本信息:{}",content.getHolder());

        log.info("开始执行validate方法");
        this.validate(content);
        log.info("硬件信息{}", content.getExtra());
        log.info("日期：{}",content.getNotAfter());
        log.info("结束validate方法");
        setLicenseKey(key);
        setCertificate(certificate);
        log.info("install方法");
        return content;
    }

    /**
     * 复写verify方法，调用本类中的validate方法，校验IP地址、Mac地址等其他信息
     *
     * @param
     * @return de.schlichtherle.license.LicenseContent
     */
    @Override
    protected synchronized LicenseContent verify(final LicenseNotary notary)
            throws Exception {
        GenericCertificate certificate = getCertificate();

        // Load license key from preferences,
        final byte[] key = getLicenseKey();
        if (null == key) {
            throw new NoLicenseInstalledException(getLicenseParam().getSubject());
        }

        certificate = getPrivacyGuard().key2cert(key);
        notary.verify(certificate);
        final LicenseContent content = (LicenseContent) this.load(certificate.getEncoded());
        this.validate(content);
        setCertificate(certificate);

        return content;
    }

    /**
     * 校验生成证书的参数信息
     *
     * @param content 证书正文
     */
    protected synchronized void validateCreate(final LicenseContent content)
            throws LicenseContentException {
        final LicenseParam param = getLicenseParam();

        final Date now = new Date();
        final Date notBefore = content.getNotBefore();
        final Date notAfter = content.getNotAfter();
        if (null != notAfter && now.after(notAfter)) {
            throw new LicenseContentException("证书失效时间不能早于当前时间");
        }
        if (null != notBefore && null != notAfter && notAfter.before(notBefore)) {
            throw new LicenseContentException("证书生效时间不能晚于证书失效时间");
        }
        final String consumerType = content.getConsumerType();
        if (null == consumerType) {
            throw new LicenseContentException("用户类型不能为空");
        }
    }


    /**
     * 复写validate方法，增加IP地址、Mac地址等其他信息校验
     *
     * @param content LicenseContent
     */
    @Override
    protected synchronized void validate(final LicenseContent content)
            throws LicenseContentException {
        //1. 首先调用父类的validate方法
        log.info("开始调用父类validate方法");
        super.validate(content);
        log.info("结束调用父类validate方法");
        //2. 然后校验自定义的License参数
        //License中可被允许的参数信息
        LicenseCheckModel expectedCheckModel = (LicenseCheckModel) content.getExtra();

        log.info("许可证中的参数信息:{}", content.getExtra());
        LicenseCheckModel serverCheckModel = getServerInfos();

        log.info("本机硬件信息:{}",serverCheckModel);
        if (expectedCheckModel != null) {
            //当前服务器真实的参数信息

            if (serverCheckModel != null) {
                //校验IP地址
                if (!checkIpAddress(expectedCheckModel.getIpAddress(), serverCheckModel.getIpAddress())) {
                    throw new LicenseContentException("当前服务器的IP没在授权范围内");
                }

                //校验Mac地址
                if (!checkIpAddress(expectedCheckModel.getMacAddress(), serverCheckModel.getMacAddress())) {
                    throw new LicenseContentException("当前服务器的Mac地址没在授权范围内");
                }

                //校验主板序列号
                if (!checkSerial(expectedCheckModel.getMainBoardSerial(), serverCheckModel.getMainBoardSerial())) {
                    throw new LicenseContentException("当前服务器的主板序列号没在授权范围内");
                }

                //校验CPU序列号
                if (!checkSerial(expectedCheckModel.getCpuSerial(), serverCheckModel.getCpuSerial())) {
                    throw new LicenseContentException("当前服务器的CPU序列号没在授权范围内");
                }
            } else {
                throw new LicenseContentException("不能获取服务器硬件信息");
            }
        }
        else {
            new LicenseContentException("获取许可证机器码错误");
        }
    }


    /**
     * 重写XMLDecoder解析XML
     *
     * @param encoded XML类型字符串
     * @return java.lang.Object
     */



    private Object load(String encoded) {

        License license = (License) new ClassPathXmlApplicationContext(
                "applicationContext.xml").getBean("License");
        String xmlDecoderPath = license.getXMLDecoderPath();
        PrintWriter printWriter = null;
        String textToBeWritten =encoded;
        {
            try {
//                printWriter = new PrintWriter("D:/test/content.xml");
                printWriter = new PrintWriter(xmlDecoderPath);
            } catch (FileNotFoundException e) {
                System.out.println("Unable to locate the fileName: " + e.getMessage());
            }
            Objects.requireNonNull(printWriter).println(textToBeWritten);
            printWriter.close();
        }


        BufferedInputStream inputStream = null;
        XMLDecoder decoder = null;
        try {
            inputStream = new BufferedInputStream(new ByteArrayInputStream(encoded.getBytes(XML_CHARSET)));
            decoder = new XMLDecoder(new BufferedInputStream(inputStream, DEFAULT_BUFSIZE),null,null);
            Object object=decoder.readObject();
            LicenseContent content=(LicenseContent)object;
            log.info("subject:{}",content.getExtra());
            return object;
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        } finally {
            try {
                if (decoder != null) {

                    decoder.close();
                }
                if (inputStream != null) {
                    inputStream.close();
                }
            } catch (Exception e) {
                log.error("XMLDecoder解析XML失败", e);
            }
        }

        return null;
    }




    /**
     * 获取当前服务器需要额外校验的License参数
     *
     * @return demo.LicenseCheckModel
     */
    private LicenseCheckModel getServerInfos() {
        //操作系统类型
        String osName = System.getProperty("os.name").toLowerCase();
        AbstractServerInfos abstractServerInfos = null;

        //根据不同操作系统类型选择不同的数据获取方法
        if (osName.startsWith("windows")) {
            abstractServerInfos = new WindowsServerInfos();
        } else if (osName.startsWith("linux")) {
            abstractServerInfos = new LinuxServerInfos();
        } else {//其他服务器类型
            abstractServerInfos = new LinuxServerInfos();
        }

        return abstractServerInfos.getServerInfos();
    }

    /**
     * 校验当前服务器的IP/Mac地址是否在可被允许的IP范围内<br/>
     * 如果存在IP在可被允许的IP/Mac地址范围内，则返回true
     *
     * @return boolean
     */
    private boolean checkIpAddress(List<String> expectedList, List<String> serverList) {
        if (expectedList != null && expectedList.size() > 0) {
            if (serverList != null && serverList.size() > 0) {
                for (String expected : expectedList) {
                    if (serverList.contains(expected.trim())) {
                        return true;
                    }
                }
            }

            return false;
        } else {
            return true;
        }
    }

    /**
     * 校验当前服务器硬件（主板、CPU等）序列号是否在可允许范围内
     *
     * @param
     * @return boolean
     */
    private boolean checkSerial(String expectedSerial, String serverSerial) {
        if (StringUtils.isNotBlank(expectedSerial)) {
            if (StringUtils.isNotBlank(serverSerial)) {
                if (expectedSerial.equals(serverSerial)) {
                    return true;
                }
            }
            return false;
        } else {
            return true;
        }
    }

}