package com.zimax.mcrs.update.mapper;

import com.zimax.mcrs.report.pojo.AbnProdPrcs;
import com.zimax.mcrs.update.pojo.UpdateUpload;
import org.apache.ibatis.annotations.Mapper;


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
}
