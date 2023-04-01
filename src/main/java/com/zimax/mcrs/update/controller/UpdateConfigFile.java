package com.zimax.mcrs.update.controller;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.Device;
import com.zimax.mcrs.device.pojo.DeviceRollback;
import com.zimax.mcrs.device.pojo.DeviceUpgrade;
import com.zimax.mcrs.update.pojo.*;
import com.zimax.mcrs.update.service.UpdateConfigService;
import com.zimax.mcrs.update.service.UpdatePackageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.InetAddress;
import java.net.URLEncoder;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 *@author 王广玉
 *@date 2023/1/3 0:38
 */

@RestController
@RequestMapping("/updateConfig")
public class UpdateConfigFile {

    @Autowired
    private UpdateConfigService updateConfigService;

    @GetMapping("/query")
    public Result<?> queryConfigurationFile(String page, String limit, String appId, String order, String field) {
        return Result.success(updateConfigService.queryConfigurationFile(page, limit, appId, order, field),updateConfigService.count(appId));
    }

    @PostMapping("/add")
    public Result<?> addConfigurationFile(@RequestBody ConfigurationFile configurationFile) {
        try {
            updateConfigService.addConfigurationFile(configurationFile);
        }catch (Exception e){
            return Result.error("1","请求失败");
        }
        return Result.success("0","请求成功");
    }


    /**
     * s删除编码规则
     */
    @DeleteMapping("/del")
    public Result<?> delConfigurationFile(@RequestBody ConfigurationFile configurationFile){
        try{
            updateConfigService.delConfigurationFile(configurationFile);
        } catch (Exception e){
            return Result.error("1","请求失败");
        }
        return Result.success("0","请求成功");
    }


    /**
     * s删除编码规则
     */
    @PostMapping("/getfile")
    public Result<?> getFile(@RequestBody ConfigurationFile configurationFile) throws Exception {
        String filePath = configurationFile.getFilePath();
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

    /**
     * s删除编码规则
     */
    @PostMapping("/updatefile")
    public Result<?> updateFile(@RequestBody ConfigurationFile configurationFile) throws Exception {
        File txt;
        FileOutputStream fos;
        String fileCont = configurationFile.getFileCont();
        try {
            txt = new File(configurationFile.getFilePath());
            if(!txt.exists()) {
                boolean newFile = txt.createNewFile();
                if (!newFile) {
                    System.out.println("fail to create new file, please check!");
                    return  Result.success("1","请求失败");
                }
            }
            byte[] bytes = fileCont.getBytes();
            int b = bytes.length;   //是字节的长度，不是字符串的长度
            fos = new FileOutputStream(txt); // 如果已存在，以覆盖的方式写文件
            // fos = new FileOutputStream(txt, true); // 如果已存在，以追加的方式写文件
            fos.write(bytes,0, b); // 写指定长度的内容
            // fos.write(bytes); // 写全文
            fos.flush();
            fos.close();
        } catch (IOException e) {
            e.printStackTrace();
        }

        Date date= new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateString = formatter.format(date);
        configurationFile.setFileStatus("101");
        configurationFile.setWebTime(dateString);
        updateConfigService.updateConfigurationFile(configurationFile);
        return Result.success("0","请求成功");
    }

}
