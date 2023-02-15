package com.zimax.mcrs.monitor.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.monitor.mapper.SoftwareRuntimeMapper;
import com.zimax.mcrs.monitor.pojo.vo.SoftwareRunStatusVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2023/1/3 15:57
 */
@Service
public class SoftwareRuntimeService {
    @Autowired
    private SoftwareRuntimeMapper softwareRuntimeMapper;

    /**
     * 查询软件运行状态信息
     */
    public List<SoftwareRunStatusVo> querySoRuntimes(String page, String limit,
                                                     String equipmentId,String equipmentName, String deviceName,
                                                     String deviceSoftwareType, String deviceSoftwareStatus,
                                                     String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "desc");
            map.put("field", "mdr.device_name");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipmentId", equipmentId);
        map.put("equipmentName", equipmentName);
        map.put("deviceName", deviceName);
        map.put("deviceSoftwareType", deviceSoftwareType);
        map.put("deviceSoftwareStatus", deviceSoftwareStatus);
        return softwareRuntimeMapper.querySoRuntimes(map);

    }

    public int countSO(String equipmentId,String equipmentName, String deviceName,
                       String deviceSoftwareType, String deviceSoftwareStatus) {
        return softwareRuntimeMapper.countSO(equipmentId, equipmentName ,deviceName, deviceSoftwareType, deviceSoftwareStatus);
    }

}
