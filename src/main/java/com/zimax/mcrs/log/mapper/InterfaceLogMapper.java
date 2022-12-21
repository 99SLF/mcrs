package com.zimax.mcrs.log.mapper;

import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.log.pojo.InterfaceLogVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 接口日志操作
 * @author 林俊杰
 * @date 2022/12/2
 */
@Mapper
public interface InterfaceLogMapper {

    /**
     * 查询所有的接口日志
     * @return
     */
    List<InterfaceLogVo> queryAll(Map map);

    /**
     * 定时删除
     */
//    List<InterfaceLog> removeTime();


    /**
     * 计数
     * @return
     */
    int count(@Param("source") String source);

    /**
     * 新建接口日志
     *
     * @return
     */
    void addInterfaceLog(InterfaceLog interfaceLog);

    /**
     * 检查设备是否存在
     */
    int checkEquipment(@Param("equipmentInt") int equipmentInt);


}
