package com.LicenseAuthorization.license.entity;

/**
 * @author 李伟杰
 * @date 2023/3/17 15:30
 */
public class License {
    /**
     * 证书subject
     */
    private String subject;

    /**
     * 公钥别称
     */
    private String publicAlias;

    /**
     * 访问公钥库的密码
     */
    private String storePass;

    /**
     * 证书生成路径
     */
    private String licensePath;

    /**
     * 密钥库存储路径
     */

    private String publicKeysStorePath;

    /**
     * 重写XMLDecoder解析XML
     *
     * @param encoded XML类型字符串
     * @return java.lang.Object
     */
    private String XMLDecoderPath;


    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getPublicAlias() {
        return publicAlias;
    }

    public void setPublicAlias(String publicAlias) {
        this.publicAlias = publicAlias;
    }

    public String getStorePass() {
        return storePass;
    }

    public void setStorePass(String storePass) {
        this.storePass = storePass;
    }

    public String getLicensePath() {
        return licensePath;
    }

    public void setLicensePath(String licensePath) {
        this.licensePath = licensePath;
    }

    public String getPublicKeysStorePath() {
        return publicKeysStorePath;
    }

    public void setPublicKeysStorePath(String publicKeysStorePath) {
        this.publicKeysStorePath = publicKeysStorePath;
    }

    public String getXMLDecoderPath() {
        return XMLDecoderPath;
    }

    public void setXMLDecoderPath(String XMLDecoderPath) {
        this.XMLDecoderPath = XMLDecoderPath;
    }
}
