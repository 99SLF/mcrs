package com.zimax.mcrs.update.javaBean;

/**
 * @author 李伟杰
 * @date 2023/1/12 11:06
 */

public class UploadJava {

    private String realPath;

    public void setRealPath(String realPath) {
        this.realPath = realPath;
    }

    public  void getRealPath(String realPath){
        this.realPath = realPath;
    }

    public String read () {
        return realPath ;

    }

}
