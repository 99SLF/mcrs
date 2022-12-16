package com.zimax.mcrs.update.service;

import com.zimax.mcrs.report.mapper.AbnProdPrcsReportMapper;
import com.zimax.mcrs.report.pojo.AbnProdPrcs;
import com.zimax.mcrs.update.mapper.UpdateUploadMapper;
import com.zimax.mcrs.update.pojo.UpdateUpload;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @author 李伟杰
 * @date 2022/12/16 10:46
 */
@Service
public class UpdateUploadService {

    /**
     * 更新包数据处理
     * @param
     * @return
     */
    @Autowired
    private UpdateUploadMapper updateUploadMapper;

    /**
     * 添加更新包信息
     * @param updateUpload 更新包信息
     */
    public void addUpdateUpload(UpdateUpload updateUpload){

        updateUploadMapper.addUpdateUpload(updateUpload);
    }
}
