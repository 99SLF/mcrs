package com.zimax.components.coframe.framework.controller;

import com.alibaba.excel.util.StringUtils;
import com.zimax.components.coframe.framework.service.ApplicationService;
import com.zimax.mcrs.config.Result;
import com.zimax.components.coframe.framework.pojo.Application;
import net.bytebuddy.implementation.bind.annotation.BindingPriority;
import org.apache.commons.compress.utils.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

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
 * 应用管理
 *
 * @Author 施林丰
 * @Date: 2022-12-1 15:21
 * @Description
 */
@RestController
@ResponseBody
@RequestMapping("/framework")
public class ApplicationController {

    @Autowired
    ApplicationService applicationService;
    @PostMapping("/application/upload")
    public String upload(String picName, MultipartFile uploadFile, HttpServletRequest request) {
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
        return "success";
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


    /**
     * 新增应用
     *
     * @param application 应用信息
     */
    @PostMapping("/application/add")
    public Result<?> addApplication(@RequestBody Application application) {
        applicationService.addApplication(application);
        return Result.success();
    }

    /**
     * 更新应用
     *
     * @param application 应用信息
     */
    @PutMapping("/application/update")
    public Result<?> updateApplication(@RequestBody Application application) {
        applicationService.updateApplication(application);
        return Result.success();
    }

    /**
     * 删除应用
     *
     * @param appId 应用信息编号
     */
    @DeleteMapping("/application/delete/{appId}")
    public Result<?> deleteApplication(@PathVariable int appId) {
        applicationService.deleteApplication(appId);
        return Result.success();
    }

    /**
     * 查询应用
     *
     * @param appName 应用名称
     * @param appType 应用类型
     * @param limit   记录数
     * @param page    页码
     * @param field   排序字段
     * @param order   排序方式
     * @return 应用列表
     */
    @GetMapping("/application/query")
    public Result<?> queryApplications(String limit, String page, String appName, String appType, String order, String field) {
        List applications = applicationService.queryApplications(page, limit, appName, appType, order, field);
        return Result.success(applications, applicationService.count(appName, appType));
    }

    /**
     * 获取应用信息
     *
     * @param appId 应用编号
     * @return 应用信息
     */
    @GetMapping("/application/find/{appId}")
    public Result<?> getApplication(@PathVariable("appId") int appId) {
        return Result.success(applicationService.getApplication(appId));
    }

    /**
     * 批量删除应用信息
     *
     * @param appIds 应用编号
     * @return 应用信息
     */
    @DeleteMapping("/application/batchDelete")
    public Result<?> batchDelete(@RequestBody List<Integer> appIds) {
        applicationService.deleteApplications(appIds);
        return Result.success();
    }

}
