package com.zimax.mcrs.systemFile.controller;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.monitor.controller.SystemMonitorAlarm;
import com.zimax.mcrs.systemFile.pojo.SystemFile;
import com.zimax.mcrs.systemFile.service.SystemFileService;
import com.zimax.mcrs.update.javaBean.UploadJava;
import com.zimax.mcrs.update.pojo.UpdateUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @Author 施林丰
 * @Date:2023/1/13 16:30
 * @Description
 */
@RestController
@RequestMapping("/systemFile")
public class SystemFileController {
    @Autowired
    private SystemFileService systemFileService;
    @PostMapping("/upload")
    public Result<?> updateSystemFile(MultipartFile file, SystemFile systemFile, HttpServletRequest request) throws
            Exception {
        if (file != null) {
            // 1.获取原始文件名
            String uploadFileName = file.getOriginalFilename();
            //保存文件原始名到数据库
            systemFile.setFileName(uploadFileName);

            // 2.截取文件扩展名
            String extendName = uploadFileName.substring(uploadFileName.lastIndexOf(".") + 1);
            // 3.把文件加上随机数，防止文件重复
            //String uuid = UUID.randomUUID().toString().replace("-", "").toUpperCase();
            //5.获取文件类型
            ApplicationContext context = new ClassPathXmlApplicationContext(
                    "applicationContext.xml");

            UploadJava uploadJava = (UploadJava) context.getBean("UploadJava");
            //9.调用方法
            String realPath = uploadJava.getSystemFilePath();
            File dir = new File(realPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
            // 13.创建空文件，写入上传文件包
            File newFile = new File(dir, uploadFileName);

            // 14.将参数file（上传文件）写入空文件中
            file.transferTo(newFile);

            //15.保存更新包存放文件夹路径位置
            systemFile.setDownloadPath(dir.getPath() + "/" + uploadFileName);

            //16.将更新时间保存到数据库信息中
            systemFile.setCreateTime(new Date());

            //17.获取当前用户信息
            IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();

            //18.将当期的用户信息存储到数据库表里
            systemFile.setCreator(usetObject.getUserId());

            //19.走编码规则，流水单号，编码规则，参数是编码规则表功能编码functionNum
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String format = simpleDateFormat.format(new Date());

            //20.调用存储数据添加功能
            systemFileService.updateSystemFile(systemFile);
        } else {
            return Result.error("1", "上传失败");

        }
        return Result.success();

    }
    @RequestMapping("/download")
    public void download(String filePath, HttpServletRequest request, HttpServletResponse response) {

     /*   方法一：
        第一遍、变成参数的形式接受,
         String filePath="C:\\Users\\HUAWEI\\IdeaProjects\\MCRS-JAVA\\target\\mcrs\\upload\\1fdce043-23b0-4f3c-a35a-de68e74869deuploadFile.rar";
        sql做不了反斜杠查询（最开始没有uuidFile字段的，为了查询文件名创建），改用截取数据字符串+uuidFile查询*/
        //要获取文件名
        //String fileName = "1fdce043-23b0-4f3c-a35a-de68e74869deuploadFile.rar";
        //Sql中用反斜杠查不到数据
        //String fileName = updateUploadMapper.getUploadFileName(downloadUrl);
        /*方法二：通过配置文件直接获取文件存储位置*/

        //1.从下载路径获取uuid+文件名+后缀名（更新包表字段）
        String uuidFile = filePath.substring(filePath.lastIndexOf("/") + 1);

        //2.通过uuidFile获取存储的文件名
       // String fileName = updateUploadMapper.getUploadFileName(uuidFile);

        //3、流定义
        FileInputStream fileIn = null;
        ServletOutputStream out = null;
        try {
            //String fileName = new String(fileNameString.getBytes("ISO8859-1"), "UTF-8");
            response.setContentType("application/octet-stream");
            // URLEncoder.encode(fileNameString, "UTF-8") //下载文件名为中文的，文件名需要经过url编码

            //4.设置相应头
           // response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));

            //5.文件定义
            File file;

            //6.文件路径
            String filePathString = filePath;

            //7.获取文件存储
            file = new File(filePathString);
            fileIn = new FileInputStream(file);
            out = response.getOutputStream();

            //8.文件写入
            byte[] outputByte = new byte[1024];

            //9.定义读取长度变量
            int readTmp = 0;
            while ((readTmp = fileIn.read(outputByte)) != -1) {
                out.write(outputByte, 0, readTmp); //并不是每次都能读到1024个字节，所有用readTmp作为每次读取数据的长度，否则会出现文件损坏的错误
            }
        }
        catch (Exception e) {//10.关闭流对象
            //log.error(e.getMessage());
            e.printStackTrace();
        }
        finally {
            try {
                fileIn.close();
                out.flush();
                out.close();
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }

    @GetMapping("/querySystemFile")
    public  Result<?> querySystemFile() {
        return Result.success(systemFileService.querySystemFile());
    }

}
