package com.zimax.mcrs.monitor.service;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.zimax.components.websocket.WebSocket;
import com.zimax.mcrs.monitor.mapper.AccessMonitorMapper;
import com.zimax.mcrs.monitor.pojo.monDeviceStatus.MonitorDeviceStatus;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.AsyncConfigurer;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.scheduling.concurrent.ThreadPoolTaskExecutor;

import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.concurrent.Executor;

/**
 * @Author 施林丰
 * @Date:2023/5/22 17:09
 * @Description
 */
@Configuration
@EnableAsync
public class realMonitor {
    @Autowired
    private AccessMonitorMapper accessMonitorMapper;
    @Async("taskExecutor")
    @Scheduled(fixedDelay = 600000) // 7分钟执行一次
    public void changeStatus() {
//        Date current = new Date();
//        MonitorDeviceStatus monitorDeviceStatus = new MonitorDeviceStatus();
//        List<MonitorDeviceStatus> monitorDeviceStatusList = accessMonitorMapper.queryMonReals();
//        for(int i=0;i<monitorDeviceStatusList.size();i++){
//           //判断是否有实时心跳值
//            if(timeCmp(current,monitorDeviceStatusList.get(i).getSoftMonitorTime())){
//                monitorDeviceStatus.setAppId(monitorDeviceStatusList.get(i).getAppId());
//                monitorDeviceStatus.setDeviceSoftwareStatus("100");
//                monitorDeviceStatus.setPlcStatus("100");
//                monitorDeviceStatus.setRfidStatus("100");
//                monitorDeviceStatus.setSoftMonitorTime(current);
//                monitorDeviceStatus.setPlcMonitorTime(current);
//                monitorDeviceStatus.setRfidMonitorTime(current);
//                monitorDeviceStatus.setWarnTime(current);
//                monitorDeviceStatus.setWarnType("102");
//                monitorDeviceStatus.setWarnGrade("error");
//                monitorDeviceStatus.setWarningContent("rfid软件异常关闭");
//                int x =accessMonitorMapper.updateMonitorDeviceStatus(monitorDeviceStatus);
//                ObjectMapper mapper = new ObjectMapper();
//                String json = null;
//                try {
//                    json = mapper.writeValueAsString(monitorDeviceStatus);
//                } catch (JsonProcessingException e) {
//                    e.printStackTrace();
//                }
//                //将所有信息打包发到终端状态
//                WebSocket.push("device_status",json);
//                WebSocket.push("software_runtime_status",json);
//                WebSocket.push("plc",json);
//                WebSocket.push("rfid",json);
//                WebSocket.push("device_abnormal_warn",json);
//            }
//        }

    }
    public boolean timeCmp(Date current,Date ago){
        long time = 420000;
        Calendar cal1 = Calendar.getInstance();
        Calendar cal2 = Calendar.getInstance();
        cal1.setTime(current);
        cal2.setTime(ago);
        long timeSubtract = cal1.getTimeInMillis()-cal2.getTimeInMillis();
        if(timeSubtract>time){
            return true;
        }else{
            return  false;
        }
    }
}
