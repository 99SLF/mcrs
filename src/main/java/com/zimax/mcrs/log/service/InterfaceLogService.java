package com.zimax.mcrs.log.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.pojo.Equipment;
import com.zimax.mcrs.log.mapper.InterfaceLogMapper;
import com.zimax.mcrs.log.pojo.DeviceExchangeLogVo;
import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.log.pojo.InterfaceLogVo;
import org.apache.poi.ss.usermodel.DateUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.DateFormat;
import java.text.DecimalFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * 接口日志
 * @author 林俊杰
 * @date 2022/12/2
 */
@Service
public class InterfaceLogService {

    @Autowired
    private InterfaceLogMapper interfaceLogMapper;


    /**
     * 查询所有接口日志信息
     */
    public List<InterfaceLogVo> queryInterfaceLog(String limit, String page,  String source,String equipmentId,String equipmentName,String interfaceType,String result,
                                                  String invokerName,String disposeTime,String interfaceName,String createTime ,String order, String field){
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","ll.create_time");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("source",source);
        map.put("equipmentId",equipmentId);
        map.put("equipmentName",equipmentName);
        map.put("interfaceType",interfaceType);
        map.put("result",result);
        map.put("invokerName",invokerName);
        map.put("disposeTime",disposeTime);
        map.put("interfaceName",interfaceName);
        map.put("createTime",createTime);
        return interfaceLogMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count( String source,String equipmentId,String equipmentName,String interfaceType,String result,
                      String invokerName,String disposeTime,String interfaceName,String createTime) {
        return interfaceLogMapper.count(source, equipmentId,equipmentName ,interfaceType,result,invokerName,disposeTime,interfaceName,createTime);
    }


    /**
     * 检测设备是否存在
     *
     * @param equipmentInt 设备资源号
     */
    public int  checkEquipment(int equipmentInt) {
        return interfaceLogMapper.checkEquipment(equipmentInt);
    }

    /**
     * 添加接口日志
     * @param interfaceLog
     */
    public void addInterfaceLog(InterfaceLog interfaceLog) throws ParseException {
        //在添加时声明日志类型
        interfaceLog.setLogType("102");
        //设置日志创建时间
        interfaceLog.setCreateTime(new Date());

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String dateStr1 = sdf.format(Date.parse(interfaceLog.getDisposeStartTime()+""));
        String dateStr2 = sdf.format(Date.parse(interfaceLog.getDisposeEndTime()+""));

        DateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date firstTime = df.parse(dateStr1);
        Date currentTime = df.parse(dateStr2);
        DecimalFormat decimalFormat = new DecimalFormat("00");
        long diff = currentTime.getTime() - firstTime.getTime();//得到的差值
        long hours = diff / (1000 * 60 * 60); //获取时
        long minutes = (diff - hours * (1000 * 60 * 60)) / (1000 * 60);  //获取分钟
        long s = (diff / 1000 - hours * 60 * 60 - minutes * 60);//获取秒
        String countTime = "" + decimalFormat.format(hours) + ":" + decimalFormat.format(minutes) + ":" + decimalFormat.format(s);

        interfaceLog.setDisposeTime(countTime);
        interfaceLogMapper.addInterfaceLog(interfaceLog);
    }

    /**
     * 查询终端对应的接口日志给终端
     */
    public List<InterfaceLogVo> csQuery(String APPId){
        return interfaceLogMapper.csQuery(APPId);
    }
}
