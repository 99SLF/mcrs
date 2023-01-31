package com.zimax.mcrs.update.mapper;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo.ProcessInfoVo;
import com.zimax.mcrs.update.pojo.UpdateUpload;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * @author 李伟杰
 * @date 2022/12/16 10:47
 */
@Mapper
public interface UpdateUploadMapper {

    /**
     * 添加更新包数据
     *
     * @param updateUpload 更新包信息数据处理
     * @return
     */
    void addUpdateUpload(UpdateUpload updateUpload);

    List<UpdateUpload> queryUpdateUploadAll(Map map);

    List<UpdateUpload> queryUpdateUpload(Map map);

    List<UpdateUpload> queryUpdateUploadRo(Map map);

    /**
     * 更新包上传管理，计数
     * @param
     * @return
     */
    int countAll(@Param("uploadNumber") String uploadNumber, @Param("version") String version,
              @Param("deviceSoType") String deviceSoType, @Param("uploadStrategy") String uploadStrategy,
              @Param("uploader") String uploader, @Param("versionUploadTime") String versionUploadTime);

    /**
     *
     * @param
     * @return
     */
    int count(@Param("version") String version, @Param("deviceSoType") String deviceSoType);


    /**
     * 通过设备类型编号获取更新包信息
     *
     * @param
     * @return
     */
    List<UpdateUpload> getUpdateUpload(Map map);

    /**
     * 通过更新包编号获取更新包信息
     *
     * @param
     * @return
     */
    UpdateUpload getUpdateUploadRecord(int uploadId);

    /**
     * 批量删除更新包数据
     *
     * @param
     * @return
     */
    void deleteUpload(List<Integer> uploadIds);

    /**
     * 通过主键获取符合的uuid号
     *
     * @param
     * @return
     */
    List<UpdateUpload> getUpload(List<Integer> uploadIds);

    /**
     * 通过文件路径获取文件名
     *
     * @param
     * @return
     */
    String getUploadFileName(String uuidFile);


    List<UpdateUpload>getLastVersion(@Param("deviceSoType") String deviceSoType);

    /**
     * 更新更新包上传的更新策略和备注
     * @param
     * @return
     */
     void updateUpload(UpdateUpload updateUpload) ;



}
