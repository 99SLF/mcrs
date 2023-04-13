package com.zimax.mcrs.log.controller;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.log.pojo.LogFile;
import com.zimax.mcrs.log.service.LogFileService;
import com.zimax.mcrs.update.javaBean.UploadJava;
import com.zimax.mcrs.update.pojo.ConfigurationFile;
import org.apache.log4j.lf5.util.StreamUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.bind.annotation.*;

import java.io.*;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.net.Socket;
import java.util.*;

/**
 * @Author 施林丰
 * @Date:2023/3/31 14:12
 * @Description
 */
@RestController
@ResponseBody
@RequestMapping("/logFile")
public class LogFileController {
    @Autowired
    private LogFileService logFileService;

    @GetMapping("/queryLogFile")
    public Result<?> queryLogFile(String limit, String page, String equipmentIp, String port,String logType, String equipmentId, String logTime, String order, String field) {
       int portNum =9000;
        if(port!=null){
            portNum = Integer.parseInt(port);
       }
        if (logFileService.count(logType, equipmentId, logTime) == 0) {
            int code = logFileService.addLogFile(logType,equipmentId,logTime,equipmentIp,portNum);
            if(code!=0){
                if(code==1){
                    return Result.error("1", "所选择日志文件终端暂未生成,请稍后查看。");
                }else if(code==2){
                    return Result.error("1", "终端升级程序处于关闭状态，请打开。");
                }
            }
        }
        return Result.success(logFileService.queryLogFile(limit, page, logType, equipmentId, logTime, order, field),1);
    }

    @PostMapping("/getFile")
    public Result<?> getFile(@RequestBody LogFile logFile ) throws Exception {
        String filePath = logFile.getFilePath();
        FileInputStream fileInputStream = null;
        InputStreamReader reader = null;
        String fileCont = "";
        try {
            fileInputStream = new FileInputStream(filePath);

            // 构建FileInputStream对象
            reader = new InputStreamReader(fileInputStream, "UTF-8");
            // 构建InputStreamReader对象,编码与写入相同

            StringBuffer sb = new StringBuffer();
            while (reader.ready()) {
                sb.append((char) reader.read());
                // 转成char加到StringBuffer对象中
            }
            fileCont = sb.toString();
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            fileInputStream.close();
            reader.close();
        }
        //System.out.print(fileCont);//将字节数组转换为字符串
        return Result.success(fileCont,"0","请求成功");
    }
    @PostMapping("/updateLogFile")
    public Result<?> updateLogFile(@RequestBody LogFile logFile) {
        int code = logFileService.updateLogFile(logFile);
        if(code!=0){
            if(code==1){
                return Result.error("1", "更新失败。");
            }else{
                return Result.error("1", "终端升级程序处于关闭状态，请打开。");
            }
        }else{
            return Result.success("0","更新成功");
        }
    }

    public static byte[] streamToByteArray(InputStream is) throws Exception {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();//创建输出流对象
        byte[] b = new byte[1024];
        int len;
        while ((len = is.read(b)) != -1) {
            bos.write(b, 0, len);
        }
        byte[] array = bos.toByteArray();
        bos.close();
        return array;
    }
}
