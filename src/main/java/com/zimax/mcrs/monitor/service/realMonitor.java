package com.zimax.mcrs.monitor.service;


import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.zimax.components.websocket.WebSocket;
import com.zimax.mcrs.log.mapper.DeleteLogsMapper;
import com.zimax.mcrs.monitor.mapper.AccessMonitorMapper;
import com.zimax.mcrs.monitor.pojo.monDeviceStatus.MonitorDeviceStatus;
import com.zimax.mcrs.update.javaBean.UploadJava;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Configuration;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.scheduling.annotation.Async;
import org.springframework.scheduling.annotation.EnableAsync;
import org.springframework.scheduling.annotation.Scheduled;

import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

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
    @Autowired
    private DeleteLogsMapper deleteLogsMapper;
    private UploadJava uploadJava = (UploadJava)new ClassPathXmlApplicationContext(
            "applicationContext.xml").getBean("UploadJava");
    @Async("taskExecutor")
    @Scheduled(fixedDelay = 420000) // 7分钟执行一次
    public void changeStatus() {
        Date current = new Date();
        List<MonitorDeviceStatus> monitorDeviceStatusList = accessMonitorMapper.queryMonReals();
        if(monitorDeviceStatusList.size()==0){
            return;
        }
        for(int i=0;i<monitorDeviceStatusList.size();i++){
           //判断是否有实时心跳值
            MonitorDeviceStatus monitorDeviceStatus = new MonitorDeviceStatus();
            if(timeCmp(current,monitorDeviceStatusList.get(i).getSoftMonitorTime())){
                monitorDeviceStatus.setAppId(monitorDeviceStatusList.get(i).getAppId());
                monitorDeviceStatus.setDeviceSoftwareStatus("100");
                monitorDeviceStatus.setPlcStatus("100");
                monitorDeviceStatus.setRfidStatus("100");
                monitorDeviceStatus.setSoftMonitorTime(current);
                monitorDeviceStatus.setPlcMonitorTime(current);
                monitorDeviceStatus.setRfidMonitorTime(current);
                monitorDeviceStatus.setWarnTime(current);
                monitorDeviceStatus.setWarnType("102");
                monitorDeviceStatus.setWarnGrade("error");
                monitorDeviceStatus.setWarningContent("机台rfid软件程序已关闭");
                monitorDeviceStatus.setResource(monitorDeviceStatusList.get(i).getResource());
                int x =accessMonitorMapper.updateMonitorDeviceStatus(monitorDeviceStatus);
                ObjectMapper mapper = new ObjectMapper();
                String json = null;
                try {
                    json = mapper.writeValueAsString(monitorDeviceStatus);
                } catch (JsonProcessingException e) {
                    e.printStackTrace();
                }
                //将所有信息打包发到终端状态
                WebSocket.push("device_status",json);
                WebSocket.push("software_runtime_status",json);
                WebSocket.push("plc",json);
                WebSocket.push("rfid",json);
                WebSocket.push("device_abnormal_warn",json);
            }
        }

    }
    //是否掉线
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
    @Async("taskExecutor")
    @Scheduled(cron = "0 0 0 * * ?") // 每天凌晨执行任务
    public void deleteLog() {
        Date dNow = new Date();   //当前时间
        Date dBefore = new Date();
        Calendar calendar = Calendar.getInstance(); //得到日历
        calendar.setTime(dNow);//把当前时间赋给日历
        calendar.add(Calendar.MONTH, uploadJava.getDelRule());  //设置为前3月
        dBefore = calendar.getTime();   //得到前3月的时间
        SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"); //设置时间格式
        String defaultStartDate = sdf.format(dBefore);    //格式化前3月的时间
        deleteLogsMapper.deleteRepBlanking(defaultStartDate);
        deleteLogsMapper.deleteRepfeeding(defaultStartDate);
        deleteLogsMapper.deleteRepCoilDiameterRecord(defaultStartDate);
        deleteLogsMapper.deleteRepVerifyUnusual(defaultStartDate);
        deleteLogsMapper.deleteMonAlarm(defaultStartDate);
        deleteLogsMapper.deleteLoglog(defaultStartDate);
    }
}
