package com.zimax.mcrs.update.controller;

import com.alibaba.excel.util.StringUtils;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.update.pojo.UpdateUpload;
import com.zimax.mcrs.update.service.UpdateUploadService;
import org.apache.commons.compress.utils.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletContext;
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

    /**
     * 记录更新包上传记录
     *
     * @param updateUpload 更新包信息
     */
    @PostMapping("/addUpdateUpload/add")
    public Result<?> addUpdateUpload(@RequestBody UpdateUpload updateUpload) {
        updateUploadService.addUpdateUpload(updateUpload);
        return Result.success();
    }


    /**
     * 显示更新包信息
     *
     * @param
     * @param page        页记录数
     * @param limit       页码
     * @param version      版本号
     * @param deviceSoType 终端软件类型
     * @param order       排序方式
     * @param field       排序字段
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


//    /**
//     * 通过更新包管理编号批量删除文件，和数据库数据
//     * @param
//     * @return
//     */
//    @DeleteMapping("/delete/{id}")
//    public boolean deleteFile(@PathVariable Integer uploadId) {
//        //获取要删除的文件信息
//        WenJian wenJian=wenJianService.getById(id);
//        //获取文件存储路径
//        String realpath=wenJian.getSavePath();
//        //删除文件
//        File file=new File(realpath,wenJian.getNewFileName());
//        //如果文件存在就立即删除
//        if(file.exists()){
//            file.delete();
//        }
//        return wenJianService.dalete(id);
//    }

    /*通过更新包编号删除数据库数据*/

    /*更新包上传*/
    @PostMapping("/upload")
    public Result<?> upload(String picName, MultipartFile uploadFile, HttpServletRequest request) {
        // 一、定义文件名
        String fileName = "";
        // 1.获取原始文件名
        String uploadFileName = uploadFile.getOriginalFilename();
        // 2.截取文件扩展名
        String extendName = uploadFileName.substring(uploadFileName.lastIndexOf(".") + 1);
        // 3.把文件加上随机数，防止文件重复
        String uuid = UUID.randomUUID().toString().replace("-", "").toUpperCase();
        // 4.判断是否输入了文件名
        if (!StringUtils.isEmpty(picName)) {
            fileName = uuid + "_" + picName + "." + extendName;
        } else {
            fileName = uuid + "_" + uploadFileName;
        }
        System.out.println(fileName);
        // 二、使用request获取文件路径
        ServletContext context = request.getServletContext();
        String basePath = context.getRealPath("/uploads");
        // 三、解决同一文件夹中文件过多问题
        String datePath = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        // 四、判断路径是否存在
        File file = new File(basePath + "/" + datePath);
        if (!file.exists()) {
            file.mkdirs();
        }
        // 五、使用 MulitpartFile 接口中方法，把上传的文件写到指定位置
        try {
            uploadFile.transferTo(new File(file, fileName));
        } catch (IOException e) {
            e.printStackTrace();
        }
//       file.transferTo(fileName);

        return Result.success();
    }

    @GetMapping("/application/download")
    public  String download(String fileName, HttpServletRequest request, HttpServletResponse response) throws IOException {
        //获取下载服务器上文件的绝对路径
        String realPath = request.getSession().getServletContext().getRealPath("fileBag");
        //根据文件名获取服务上指定文件
        FileInputStream is = new FileInputStream(new java.io.File(realPath, fileName));
        //获取响应对象设置响应头信息
        response.setHeader("content-disposition","attachment;fileName="+ URLEncoder.encode(fileName,"UTF-8"));
        ServletOutputStream os = response.getOutputStream();
        IOUtils.copy(is,os);
        IOUtils.closeQuietly(is);
        IOUtils.closeQuietly(os);
        return null;
    }
}
