package com.zimax.mcrs.update.mapper;

import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.update.pojo.UpdateUpload;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

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
     * @param updateUpload 更新包信息数据处理
     * @return
     */
    void addUpdateUpload(UpdateUpload updateUpload);

    List<UpdateUpload> queryUpdateUpload(Map map);

    int count(@Param("version") String version, @Param("deviceSoType") String deviceSoType);

    /**
     * 批量删除更新包数据
     * @param
     * @return
     */
    void deleteUpload(List<Integer> uploadIds);

    /**
     * 通过主键获取符合的uuid号
     * @param
     * @return
     */
    List<UpdateUpload> getUpload(List<Integer> uploadIds);

    /**
     * 通过文件路径获取文件名
     * @param
     * @return
     */
     String getUploadFileName(String uuidFile);
}
