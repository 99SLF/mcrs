package com.zimax.mcrs.report.service;

import com.zimax.mcrs.report.mapper.CoilDiameterRecordMapper;
import com.zimax.mcrs.report.pojo.CoilDiameterRecord;
import com.zimax.mcrs.report.pojo.Feeding;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author 施林丰
 * @Date:2023/3/4 13:29
 * @Description
 */
@Service
public class CoilDiameterRecordService {
    @Autowired
    CoilDiameterRecordMapper coilDiameterRecordMapper;
    /**
     * 添加报表记录信息
     *
     * @param coilDiameterRecord 记录报表
     */
    public void addCoilDiameterRecord(CoilDiameterRecord coilDiameterRecord) {
        coilDiameterRecordMapper.addCoilDiameterRecord(coilDiameterRecord);
    }
}
