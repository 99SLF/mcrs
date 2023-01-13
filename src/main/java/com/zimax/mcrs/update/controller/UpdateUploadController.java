package com.zimax.mcrs.update.controller;


import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.serialnumber.service.SerialnumberService;
import com.zimax.mcrs.update.javaBean.UploadJava;
import com.zimax.mcrs.update.mapper.UpdateUploadMapper;
import com.zimax.mcrs.update.pojo.UpdateUpload;
import com.zimax.mcrs.update.service.UpdateUploadService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.util.ClassUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Arrays;
import java.util.Date;
import java.util.List;
import java.util.UUID;

/**
 * @author 李伟杰
 * @date 2022/12/16 10:44
 */
@RestController
@RequestMapping("/upload")
public class UpdateUploadController {
    /**
     * 更新包上传服务
     *
     * @param
     * @return
     */
    @Autowired
    private UpdateUploadService updateUploadService;

    @Autowired
    private UpdateUploadMapper updateUploadMapper;

    @Autowired
    private SerialnumberService serialnumberService;
    /**
     * 记录更新包上传记录
     *
     * @param updateUpload 更新包信息
     */
    @PostMapping("/package/upload")
    public Result<?> addUpdateUpload(MultipartFile file, UpdateUpload updateUpload, HttpServletRequest request) throws
            Exception {
        if (file != null) {
            // 1.获取原始文件名
            String uploadFileName = file.getOriginalFilename();
            //保存文件原始名到数据库
            updateUpload.setFileName(uploadFileName);

            // 2.截取文件扩展名
            String extendName = uploadFileName.substring(uploadFileName.lastIndexOf(".") + 1);

            // 3.把文件加上随机数，防止文件重复
            //String uuid = UUID.randomUUID().toString().replace("-", "").toUpperCase();


            //4.文件大小
            double uploadFileSize = file.getSize();
            //将文件大小存到数据库
            updateUpload.setUploadFileSize(uploadFileSize);

            //5.获取文件类型
            String uploadFileType = file.getContentType();

            //6.将文件类型存到数据库里
            updateUpload.setUploadFileType(uploadFileType);

//            方法1：
//            创建文件夹，存放文件在编译文件中的
//            String realPath = request.getSession().getServletContext().getRealPath("/upload");//上传到编译路径下（target）文件可能会自动消失

//            方法2：
//            //获取文件名字，存放自定义文件位置
//            String fileName = file.getOriginalFilename();
//            //设置编译后文件存在路径
//            String path = ClassUtils.getDefaultClassLoader().getResource("").getPath()+"static/images/tx/";
//            //获取项目路径
//            File directory = new File("src/main/resources/static/images/tx");
//            String paths = directory.getCanonicalPath();
//
//            File dest = new File(paths+'/' + fileName);
//            System.out.println(dest.getAbsoluteFile());


            //方法三：用javabean存放更新包文件到本地路径
            //7.创建Spring容器
            ApplicationContext context = new ClassPathXmlApplicationContext(
                    "applicationContext.xml");

            //8.获取bean
            UploadJava uploadJava = (UploadJava) context.getBean("UploadJava");

            //9.调用方法
           String realPath = uploadJava.read();

            File dir = new File(realPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }

            //10. 将上传的数据加上uuid存到数据库里写到文件夹的文件中
            String uuid = String.valueOf(UUID.randomUUID());

            //11.设置uploadUuid存储
            updateUpload.setUploadUuid(uuid);
            uploadFileName = uuid + uploadFileName;

            //12.保存uuid和文件名的拼接，方便下载查找原始文件名称
            updateUpload.setUuidFile(uploadFileName);

            // 13.创建空文件，写入上传文件包
            File newFile = new File(dir, uploadFileName);

            // 14.将参数file（上传文件）写入空文件中
            file.transferTo(newFile);


            //15.保存更新包存放文件夹路径位置
            updateUpload.setDownloadUrl(dir.getPath() + "/" + uploadFileName);

            //16.将更新时间保存到数据库信息中
            updateUpload.setVersionUploadTime(new Date());

            //17.获取当前用户信息
            IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();

            //18.将当期的用户信息存储到数据库表里
            updateUpload.setUploader(usetObject.getUserName());

            //19.走编码规则，流水单号，编码规则，参数是编码规则表功能编码functionNum
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String format = simpleDateFormat.format(new Date());
            String coding = serialnumberService.getSerialNum("gxCod");
            updateUpload.setUploadNumber(coding);

            //20.调用存储数据添加功能
            updateUploadService.addUpdateUpload(updateUpload);
        } else {
            return Result.error("1", "上传失败");

        }
        return Result.success();

    }



    @PostMapping("/add")
    public Result<?> addUpdateUpload(@RequestBody UpdateUpload updateUpload) {
        updateUploadService.addUpdateUpload(updateUpload);
        return Result.success();
    }
    /**
     * 显示升级更新包信息
     *
     * @param
     * @param page         页记录数
     * @param limit        页码
     * @param version      版本号
     * @param deviceSoType 终端软件类型
     * @param order        排序方式
     * @param field        排序字段
     * @return
     * @return 更新包信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/queryUpdateUploadAll/query")
    public Result<?> queryUpdateUploadAll(String page, String limit,
                                       String version, String deviceSoType,
                                       String order, String field) {
        List UpdateUpload = updateUploadService.queryUpdateUploadAll(page, limit, version, deviceSoType, order, field);
        return Result.success(UpdateUpload, updateUploadService.count(version, deviceSoType));
    }

    /**
     * 显示升级更新包信息
     *
     * @param
     * @param page         页记录数
     * @param limit        页码
     * @param maxVersion   最大版本号
     * @param version      版本号
     * @param deviceSoType 终端软件类型
     * @param order        排序方式
     * @param field        排序字段
     * @return
     * @return 更新包信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/queryUpdateUpload/query")
    public Result<?> queryUpdateUpload(String page, String limit,
                                       String version, String deviceSoType,
                                       String order, String field,String maxVersion, String deviceSoftwareType) {
        List UpdateUpload = updateUploadService.queryUpdateUpload(page, limit, version, deviceSoType, order, field ,maxVersion ,deviceSoftwareType);
        return Result.success(UpdateUpload, updateUploadService.count(version, deviceSoType));
    }

    /**
     * 显示回退更新包信息
     * @param
     * @param page         页记录数
     * @param limit        页码
     * @param minVersion   最小版本号
     * @param version      版本号
     * @param deviceSoType 终端软件类型
     * @param order        排序方式
     * @param field        排序字段
     * @return
     * @return 更新包信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/queryUpdateUploadRo/query")
    public Result<?> queryUpdateUploadRo(String page, String limit,
                                       String version, String deviceSoType,
                                       String order, String field,String minVersion ,String deviceSoftwareType) {
        List UpdateUpload = updateUploadService.queryUpdateUploadRo(page, limit, version, deviceSoType, order, field ,minVersion,deviceSoftwareType);
        return Result.success(UpdateUpload, updateUploadService.count(version, deviceSoType));
    }

    /**
     * 删除更新包数据库记录
     * 更新包编号
     *
     * @param
     * @return
     */
    @DeleteMapping("/batchDelete")
    public Result<?> deleteUpload(@RequestBody Integer[] uploadIds) {
        updateUploadService.deleteUpload(Arrays.asList(uploadIds));
        return Result.success();

    }

    /**
     * 通过终端软件类型查询出相应的最新的一条数据获取其相应的版本号是什么
     *
     * @param
     * @return
     */
    @GetMapping("/getUpdateUpload")
    public Result<?> getUpdateUpload(String deviceSoType){
        List UpdateUpload = updateUploadService.getUpdateUpload(deviceSoType);
        return Result.success(UpdateUpload);

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
        String fileName = updateUploadMapper.getUploadFileName(uuidFile);

        //3、流定义
        FileInputStream fileIn = null;
        ServletOutputStream out = null;
        try {
            //String fileName = new String(fileNameString.getBytes("ISO8859-1"), "UTF-8");
            response.setContentType("application/octet-stream");
            // URLEncoder.encode(fileNameString, "UTF-8") //下载文件名为中文的，文件名需要经过url编码

            //4.设置相应头
            response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));

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


}
