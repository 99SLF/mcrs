package com.zimax.mcrs.log.mapper;

import com.zimax.mcrs.log.pojo.AbnLog;
import com.zimax.mcrs.log.pojo.AbnLogVo;
import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.log.pojo.InterfaceLogVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 异常日志操作
 * @author 林俊杰
 * @date 2023/1/4
 */
@Mapper
public interface AbnLogMapper {

    /**
     * 查询所有的异常日志
     * @return
     */
    List<AbnLogVo> queryAll(Map map);


    /**
     * 计数
     * @return
     */
    int count(@Param("equipmentId") String equipmentId);

    /**
     * 新建异常日志
     *
     * @return
     */
    void addAbnLog(AbnLog abnLog);

    /**
     * 检查设备是否存在
     */
    int checkEquipment(@Param("equipmentInt") int equipmentInt);

    /**
     * 删除功能
     */
    public void removeAbnLog(int abnLogId);


}
