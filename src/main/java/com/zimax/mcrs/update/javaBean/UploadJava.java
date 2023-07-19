package com.zimax.mcrs.update.javaBean;

/**
 * @author 李伟杰
 * @date 2023/1/12 11:06
 */

public class UploadJava {

    private String UploadpackagePath;
    private String ConfigPath;
    private String SystemFilePath;
    private String logFilePath;
    private  int delRule;
    public String getLogFilePath() {
        return logFilePath;
    }

    public void setLogFilePath(String logFilePath) {
        this.logFilePath = logFilePath;
    }


    public String getUploadpackagePath() {
        return UploadpackagePath;
    }

    public void setUploadpackagePath(String uploadpackagePath) {
        UploadpackagePath = uploadpackagePath;
    }

    public String getConfigPath() {
        return ConfigPath;
    }

    public void setConfigPath(String configPath) {
        ConfigPath = configPath;
    }

    public String getSystemFilePath() {
        return SystemFilePath;
    }

    public void setSystemFilePath(String systemFilePath) {
        SystemFilePath = systemFilePath;
    }

    public int getDelRule() {
        return delRule;
    }

    public void setDelRule(int delRule) {
        this.delRule = delRule;
    }
}
