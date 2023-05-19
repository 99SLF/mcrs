package com.zimax.mcrs.device.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.components.coframe.rights.DefaultUserManager;
import com.zimax.components.coframe.rights.pojo.Role;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.mapper.DeviceMapper;
import com.zimax.mcrs.device.pojo.*;
import com.zimax.mcrs.log.pojo.OperationLog;
import com.zimax.mcrs.log.service.OperationLogService;
import com.zimax.mcrs.monitor.mapper.AccessMonitorMapper;
import com.zimax.mcrs.update.mapper.ConfigurationFileMapper;
import com.zimax.mcrs.update.pojo.UpdateUpload;
import com.zimax.mcrs.update.service.UpdateConfigService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 设备终端服务
 * @author 林俊杰,李伟杰
 * @date 2022/11/30
 */
@Service
public class DeviceService {

    @Autowired
    private DeviceMapper deviceMapper;

    @Autowired
    private DeviceUpgradeService deviceUpgradeService;
    @Autowired
    private AccessMonitorMapper accessMonitorMapper;

    @Autowired
    private OperationLogService operationLogService;
    @Autowired
    private UpdateConfigService updateConfigService;

    /**
     * 查询所有终端信息
     * @return
     */
    public List<DeviceVo> queryDevices(String  page, String limit, String equipmentId, String equipmentIp,String deviceSoftwareType,String enable,String deviceName, String processName, String factoryName,
                                       String version,String needUpdate,String registerStatus,String programInstallationPath,String createTime, String order, String field) {
        //如果条件不为null(为null的情况为不点击查询按钮),将本次操作插入到操作日志中
        if (equipmentId != null ||equipmentIp != null ||deviceSoftwareType != null || enable != null || deviceName != null || processName != null || factoryName != null || version != null || needUpdate != null || registerStatus != null || programInstallationPath != null || createTime != null) {
            Device device = new Device();
            addOperationLog(device, 1);
        }
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","vo.create_time");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipmentId",equipmentId);
        map.put("equipmentIp",equipmentIp);
        map.put("deviceSoftwareType",deviceSoftwareType);
        map.put("enable",enable);
        map.put("deviceName",deviceName);
        map.put("processName",processName);
        map.put("factoryName",factoryName);
        map.put("version",version);
        map.put("needUpdate",needUpdate);
        map.put("registerStatus",registerStatus);
        map.put("programInstallationPath",programInstallationPath);
        map.put("createTime",createTime);
        return deviceMapper.queryAll(map);
    }

    /**
     * 终端主页查询记录
     */
    public int counts(String equipmentId, String equipmentIp,String deviceSoftwareType,String enable, String deviceName, String processName, String factoryName,String version,String needUpdate,String registerStatus,String programInstallationPath,String createTime){
        return deviceMapper.counts(equipmentId,equipmentIp,deviceSoftwareType,enable, deviceName,processName,factoryName,version,needUpdate,registerStatus,programInstallationPath,createTime);
    }




    /**
     * 查询记录
     */
    public int count(String equipmentId, String APPId){
        return deviceMapper.count(equipmentId,APPId);
    }

    /**
     * 查询记录
     */
    public DeviceNum countReg(){
        DeviceNum deviceNum =  deviceMapper.countReg();
        deviceNum.setDeviceEnumber(deviceNum.getDeviceNumber()-deviceNum.getDeviceOnumber());
        return deviceNum;
    }
    /**
     * 注册终端
     * @param device 终端
     */
    public void registrationDevice(Device device) {
        //调用方法加密，不使用，使用数据库MD5加密
//        device.setAPPId(encrypt(device.getAPPId()));
        deviceMapper.registrationDevice(device);
        //注册完成后将本次注册的信息添加至升级信息
        if("102".equals(device.getIsUpdate())){
            DeviceUpgrade deviceUpgrade = new DeviceUpgrade();
            IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
            deviceUpgrade.setDeviceId(device.getDeviceId());
            deviceUpgrade.setEquipmentInt(device.getEquipmentInt());
            deviceUpgrade.setUploadId(deviceMapper.getUpgradeId(device.getVersion(),device.getDeviceSoftwareType()));
            deviceUpgrade.setUpgradeStatus("100");
            deviceUpgrade.setUpgradeBeforeVersion(device.getVersion());
            deviceUpgrade.setVersionUpdater(userObject.getUserName());
            deviceUpgrade.setVersionUpdateTime(new Date());
            deviceUpgradeService.addDeviceUpgrade(deviceUpgrade);
        }
        //调用方法生成接口日志
        addOperationLog(device, 2);
    }

    /**
     * 注销终端
     * @param deviceId 依据deviceId来注销终端
     */
    public void logoutDevice(int deviceId) {

        //新建终端对象存储被删除的终端信息
        Device device = selectDevice(deviceId);
        //生成操作日志
        addOperationLog(device, 3);
        deviceMapper.logoutDevice(deviceId);
    }

    /**
     * 修改终端
     */
    public void updateDevice(Device device) {
        Device device1 = selectDevice(device.getDeviceId());
        if (device1.getDeviceName().equals(device.getDeviceName())) {
            addOperationLog(device1, 4);
        } else {
            addOperationLog(device1, device);
        }
        deviceMapper.updateDevice(device);
    }

    /**
     * 提供数据给监控
     */
    public List<Device> toMonitor(){
        Map<String,Object> map= new HashMap<>();
        return deviceMapper.toMonitor(map);
    }

    /**
     * 加密
     * @param
     * @return
     * @throws Exception
     */
    private static String encrypt(String APPId) throws Exception {
        return DefaultUserManager.INSTANCE.encodeString(APPId);
    }

    /**
     * 批量删除终端
     */
    public void deleteDevices(List<Integer> deviceId) {
        for (Integer a:deviceId){
            //根据终端主键获取终端信息（名称）
            String appId= deviceMapper.getDeviceName(a).getAPPId();
            //通过终端名称修改实时终端监控表
            accessMonitorMapper.deleteDeviceStatus(appId);
            updateConfigService.delConfigurationFileByAppId(appId);
            Device device = selectDevice(a);
            addOperationLog(device, 3);
        }
        deviceMapper.deleteDevices(deviceId);
    }

    /**
     * 检测APPId是否存在
     *
     * @param APPId 设备资源号
     */
    public int checkAPPId(String APPId) {
        return deviceMapper.checkAPPId(APPId);
    }



    /**
     * 通过终端主键id获取设备信息信息
     * @param
     * @return
     */
    public DeviceEquipmentVo getEquipment(int deviceId) {

        return deviceMapper.getEquipment(deviceId);
    }


    /**
     * 检测是否存在与终端软件类型对应更新包是否存在
     *
     * @param deviceSoftwareType 终端软件类型
     */
    public int checkDeviceSoftwareType(String deviceSoftwareType) {
        return deviceMapper.checkDeviceSoftwareType(deviceSoftwareType);
    }

    /**
     * 判断当前选择设备是否已被注册
     * @param equipmentInt
     * @return
     */
    public int checkEquipment(int equipmentInt){
        return  deviceMapper.checkEquipment(equipmentInt);
    }


    public Device selectDevice(int deviceId){
        return deviceMapper.selectDevice(deviceId);
    }



    /**
     * 终端生成操作日志
     * 此处生成增，删，部分改，查询日志操作日志
     */
    public void addOperationLog(Device device, int a) {
        //获取当前用户信息
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        //创建操作日志对象
        OperationLog operationLog = new OperationLog();
        operationLog.setLogStatus("101");
        operationLog.setResult("101");
        operationLog.setUser(userObject.getUserId());
        operationLog.setOperationTime(new Date());
        switch (a) {
            case 1:
                operationLog.setOperationType("104");
                operationLog.setOperationContent("查询终端");
                break;
            case 2:
                operationLog.setOperationType("101");
                operationLog.setOperationContent("注册终端:" + device.getDeviceName());
                break;
            case 3:
                operationLog.setOperationType("103");
                operationLog.setOperationContent("删除终端:" + device.getDeviceName());
                break;
            case 4:
                operationLog.setOperationType("102");
                operationLog.setOperationContent("修改终端:" + device.getDeviceName());
                break;
        }
        operationLogService.addOperationLog(operationLog);
    }

    /**
     * 生成操作日志
     * 如果修改终端名称，需要指明修改前的终端，故重写此方法
     */
    public void addOperationLog(Device device1, Device device2) {
        //获取当前用户信息
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        //创建操作日志对象
        OperationLog operationLog = new OperationLog();
        operationLog.setLogStatus("101");
        operationLog.setResult("101");
        operationLog.setOperationType("102");
        operationLog.setOperationContent("修改终端:将终端" + device1.getDeviceName() + "的名称修改为" + device2.getDeviceName());
        operationLog.setUser(userObject.getUserId());
        operationLog.setOperationTime(new Date());
        operationLogService.addOperationLog(operationLog);
    }

    /**
     * 通过终端主键获取终端名称
     */
    public Device getDeviceName(int deviceId){
        return deviceMapper.getDeviceName(deviceId);
    }
}
