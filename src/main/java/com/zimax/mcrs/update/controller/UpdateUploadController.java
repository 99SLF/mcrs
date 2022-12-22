package com.zimax.mcrs.update.controller;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.serialnumber.service.SerialnumberService;
import com.zimax.mcrs.update.mapper.UpdateUploadMapper;
import com.zimax.mcrs.update.pojo.UpdateUpload;
import com.zimax.mcrs.update.service.UpdateUploadService;
import org.springframework.beans.factory.annotation.Autowired;
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
            //将文件类型存到数据库里
            updateUpload.setUploadFileType(uploadFileType);

            //创建文件夹，存放文件
            String realPath = request.getSession().getServletContext().getRealPath("/upload");
            File dir = new File(realPath);
            if (!dir.exists()) {
                dir.mkdirs();
            }
//            System.out.println(dir);

            // 将上传的数据加上时间存到数据库里写到文件夹的文件中
            String uuid = String.valueOf(UUID.randomUUID());
            updateUpload.setUploadUuid(uuid);
            uploadFileName = uuid + uploadFileName;
            //保存uuid和文件名的拼接，方便下载查找原始文件名称
            updateUpload.setUuidFile(uploadFileName);
            // 1.创建空文件
            File newFile = new File(dir, uploadFileName);
            // 2.将参数file（上传文件）写入空文件中
            file.transferTo(newFile);
            //将文件uuid值保存到数据库
            //保存更新包存放文件夹路径位置
            updateUpload.setDownloadUrl(dir.getPath() + "/" + uploadFileName);


            //将更新时间保存到数据库信息中
            updateUpload.setVersionUploadTime(new Date());
            //获取当前用户信息
            IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
            //将当期的用户信息存储到数据库表里
            updateUpload.setUploader(usetObject.getUserName());

            //走编码规则，流水单号
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd");
            String format = simpleDateFormat.format(new Date());

            //编码规则，参数是编码规则表功能编码functionNum
            String coding = serialnumberService.getSerialNum("gxCod");
            updateUpload.setUploadNumber(coding);

            //调用存储添加功能
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
     * 显示更新包信息
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
    @GetMapping("/queryUpdateUpload/query")
    public Result<?> queryUpdateUpload(String page, String limit,
                                       String version, String deviceSoType,
                                       String order, String field) {
        List UpdateUpload = updateUploadService.queryUpdateUpload(page, limit, version, deviceSoType, order, field);
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

        //第一遍、变成参数的形式接受,

        // String filePath="C:\\Users\\HUAWEI\\IdeaProjects\\MCRS-JAVA\\target\\mcrs\\upload\\1fdce043-23b0-4f3c-a35a-de68e74869deuploadFile.rar";
        //sql做不了反斜杠查询（最开始没有uuidFile字段的，为了查询文件名创建），改用截取数据字符串+uuidFile查询
        String uuidFile = filePath.substring(filePath.lastIndexOf("/") + 1);
        //第一遍、要获取文件名
        //String fileName = "1fdce043-23b0-4f3c-a35a-de68e74869deuploadFile.rar";
        //Sql中用反斜杠查不到数据
        //String fileName = updateUploadMapper.getUploadFileName(downloadUrl);

        String fileName = updateUploadMapper.getUploadFileName(uuidFile);
        FileInputStream fileIn = null;
        ServletOutputStream out = null;
        try {
            //String fileName = new String(fileNameString.getBytes("ISO8859-1"), "UTF-8");
            response.setContentType("application/octet-stream");
            // URLEncoder.encode(fileNameString, "UTF-8") 下载文件名为中文的，文件名需要经过url编码
            response.setHeader("Content-Disposition", "attachment;filename=" + URLEncoder.encode(fileName, "UTF-8"));
            File file;
            String filePathString = filePath;
            file = new File(filePathString);
            fileIn = new FileInputStream(file);
            out = response.getOutputStream();

            byte[] outputByte = new byte[1024];
            int readTmp = 0;
            while ((readTmp = fileIn.read(outputByte)) != -1) {
                out.write(outputByte, 0, readTmp); //并不是每次都能读到1024个字节，所有用readTmp作为每次读取数据的长度，否则会出现文件损坏的错误
            }
        }
        catch (Exception e) {
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
