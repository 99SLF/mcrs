package com.zimax.mcrs.report.mapper;

import com.zimax.mcrs.report.pojo.CoilDiameterRecord;
import org.apache.ibatis.annotations.Mapper;

/**
 * @Author 施林丰
 * @Date:2023/3/4 13:24
 * @Description
 */
@Mapper
public interface CoilDiameterRecordMapper {
    void addCoilDiameterRecord(CoilDiameterRecord coilDiameterRecord);
}
