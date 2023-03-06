package com.example.cilent.license;

import com.alibaba.fastjson.JSON;
import com.example.licese.entity.LicenseVerifyParam;
import de.schlichtherle.license.*;
import lombok.extern.slf4j.Slf4j;

import java.io.File;
import java.text.DateFormat;
import java.text.MessageFormat;
import java.text.SimpleDateFormat;
import java.util.HashMap;
import java.util.Map;
import java.util.prefs.Preferences;

/**
 * License校验类
 */
@Slf4j
public class LicenseVerify {
    /**
     * 安装License证书
     */
    public synchronized LicenseContent install(LicenseVerifyParam param){
        LicenseContent result = null;
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        //1. 安装证书
        try{

           CustomLicenseManager licenseManager =  LicenseManagerHolder.getInstance(initLicenseParam(param));
           log.info("正在安装证书");
            licenseManager.uninstall();
            result = licenseManager.install(new File(param.getLicensePath()));
            log.info(MessageFormat.format("证书安装成功，证书有效期：{0} - {1}",format.format(result.getNotBefore()),format.format(result.getNotAfter())));
            log.info("content日期信息:{}",result.getNotBefore());
            log.info("content硬件信息:{}",result.getExtra());
        }catch (Exception e){
            log.error("证书安装失败！");
            System.exit(0);//全局的lincense配置 （之后到每个资源的时候就可以用局部的lincese配置）--只装一次（只有在换服务器的时候才会，进行证书的安装）
                                                                                //            LicenseVerify licenseVerify = new LicenseVerify();
                                                                                //
                                                                                //            //校验证书是否有效
                                                                                //            boolean verifyResult = licenseVerify.verify();
                                                                                //            if (!verifyResult) {
                                                                                //                logger.info("验证失败，证书无效");
                                                                                //                response.setCharacterEncoding("utf-8");
                                                                                //                Map<String,String> result = new HashMap<>(1);
                                                                                //                result.put("权限：","您的证书无效，请核查服务器是否取得授权或重新申请证书！");
                                                                                //
                                                                                //                response.getWriter().write(JSON.toJSONString(result));
                                                                                //                return;
                                                                                //            } else if
        }

        return result;
    }

    /**
     * 校验License证书
     * @return boolean
     */
    public boolean verify(){
        LicenseManager licenseManager = LicenseManagerHolder.getInstance(null);
        DateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

        //2. 校验证书
        try {
            LicenseContent licenseContent = licenseManager.verify();
//            System.out.println(licenseContent.getSubject());

            log.info(MessageFormat.format("证书校验通过，证书有效期：{0} - {1}",format.format(licenseContent.getNotBefore()),format.format(licenseContent.getNotAfter())));
            return true;
        }catch (Exception e){
            log.error("证书校验失败！",e);
            return false;
        }
    }

    /**
     * 初始化证书生成参数
     * @param param License校验类需要的参数
     * @return de.schlichtherle.license.LicenseParam
     */
    private LicenseParam initLicenseParam(LicenseVerifyParam param){
        Preferences preferences = Preferences.userNodeForPackage(LicenseVerify.class);

        CipherParam cipherParam = new DefaultCipherParam(param.getStorePass());

        KeyStoreParam publicStoreParam = new CustomKeyStoreParam(LicenseVerify.class
                ,param.getPublicKeysStorePath()
                ,param.getPublicAlias()
                ,param.getStorePass()
                ,null);

        return new DefaultLicenseParam(param.getSubject()
                ,preferences
                ,publicStoreParam
                ,cipherParam);
    }

}
