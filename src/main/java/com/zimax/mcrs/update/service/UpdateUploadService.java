package com.zimax.mcrs.update.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.components.coframe.framework.pojo.Menu;
import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo.ProcessInfo;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.report.mapper.AbnProdPrcsReportMapper;
import com.zimax.mcrs.report.pojo.AbnProdPrcs;
import com.zimax.mcrs.update.mapper.UpdateUploadMapper;
import com.zimax.mcrs.update.pojo.UpdateUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/16 10:46
 */
@Service
public class UpdateUploadService {

    /**
     * 更新包数据处理
     *
     * @param
     * @return
     */
    @Autowired
    private UpdateUploadMapper updateUploadMapper;

    /**
     * 添加更新包信息
     *
     * @param updateUpload 更新包信息
     */
    public void addUpdateUpload(UpdateUpload updateUpload) {

        updateUploadMapper.addUpdateUpload(updateUpload);
    }


    /**
     * 通过查询记录条数（更新包上传管理）
     *
     * @param
     * @return
     */
    public int countAll(String uploadNumber,
                     String version, String deviceSoType,
                     String uploadStrategy, String uploader, String versionUploadTime) {

        return updateUploadMapper.countAll(uploadNumber,version, deviceSoType,uploadStrategy,uploader,versionUploadTime);
    }
    /**
     * 查询所有更新包信息(更新包上传管理)
     */
    public List<UpdateUpload> queryUpdateUploadAll(String page, String limit,
                                                   String uploadNumber,
                                                   String version, String deviceSoType,
                                                   String uploadStrategy, String uploader, String versionUploadTime,
                                                   String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "upload_number");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("uploadNumber", uploadNumber);
        map.put("version", version);
        map.put("deviceSoType", deviceSoType);
        map.put("uploadStrategy", uploadStrategy);
        map.put("uploader", uploader);
        map.put("versionUploadTime", versionUploadTime);
        return updateUploadMapper.queryUpdateUploadAll(map);

    }

    /**
     * 通过查询记录条数
     *
     * @param
     * @return
     */
    public int count(String version, String deviceSoType) {

        return updateUploadMapper.count(version, deviceSoType);
    }
    /**
     * 查询所有升级更新包信息
     */
    public List<UpdateUpload> queryUpdateUpload(String page, String limit, String version, String deviceSoType, String order, String field ,String maxVersion , String deviceSoftwareType) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "upload_number");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("version", version);
        map.put("deviceSoType", deviceSoType);
        map.put("maxVersion", maxVersion);
        map.put("deviceSoftwareType", deviceSoftwareType);
        return updateUploadMapper.queryUpdateUpload(map);

    }

    /**
     * 查询所有回退更新包信息
     */
    public List<UpdateUpload> queryUpdateUploadRo(String page, String limit, String version, String deviceSoType, String order, String field ,String minVersion,String deviceSoftwareType) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "upload_number");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("version", version);
        map.put("deviceSoType", deviceSoType);
        map.put("minVersion", minVersion);
        map.put("deviceSoftwareType", deviceSoftwareType);
        return updateUploadMapper.queryUpdateUploadRo(map);

    }


    /**
     * 删除更新包数据
     *
     * @param
     * @return
     */
    public void deleteUpload(List<Integer> uploadIds) {


        List<UpdateUpload> uploadDatas = updateUploadMapper.getUpload(uploadIds);
        String imgpaths = "";
        for (UpdateUpload uploadData:
                uploadDatas) {
            imgpaths += uploadData.getDownloadUrl() + ",";
        }
        try {
            UpdateUploadService.deleteFile(imgpaths);
        } catch (IOException e) {
            e.printStackTrace();
        }
        updateUploadMapper.deleteUpload(uploadIds);

    }

    /**
     * 通过uuid(对应的文件名)删除文件资料
     *
     * @param
     * @return
     */
    public static boolean deleteFile(String imgPath) throws IOException {
        boolean flag = false;
        if (imgPath == null) {
            return flag;
        }
        String[] imgSrc = imgPath.split(",");
        for (String src : imgSrc) {
            File file = new File(src);
            if (file.exists()) {
                if (file.delete()) {
                    flag = true;
                }
            }
        }
        return flag;
    }




    /**
     * 通过终端软件类型获取
     * 查询所有更新包信息
     */
    public List<UpdateUpload> getUpdateUpload(String deviceSoType) {
        Map<String, Object> map = new HashMap<>();
        map.put("deviceSoType", deviceSoType);
        return updateUploadMapper.getUpdateUpload(map);

    }

    /**
     * 通过更新包id获取更新包信息
     * @param
     * @return
     */
    public UpdateUpload getUpdateUploadRecord(int uploadId) {

        return updateUploadMapper.getUpdateUploadRecord(uploadId);
    }



    /**
     * (更新包上传管理——编辑)
     * 获取当前软件更新包的最新的版本
     * @param
     * @return
     */
    public List<UpdateUpload> getLastVersion(String deviceSoType) {
        return updateUploadMapper.getLastVersion(deviceSoType);

    }


    /**
     * 更新更新包上传的更新策略和备注
     * @param
     * @return
     */
    public void updateUpload(UpdateUpload updateUpload) {
        IUserObject useObject = DataContextManager.current().getMUODataContext().getUserObject();
        updateUpload.setUpdater(useObject.getUserId());
        updateUpload.setVersionUpdateTime(new Date());
        updateUploadMapper.updateUpload(updateUpload);
    }




}
