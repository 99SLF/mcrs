package com.zimax.mcrs.basic.equipTypeMaintain.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.basic.accPointResMaintain.pojo.AccPointRes;
import com.zimax.mcrs.basic.equipTypeMaintain.mapper.EquipMapper;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfoVo;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.serialnumber.service.SerialnumberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/19 14:18
 */
@Service
public class EquipService {
    @Autowired
    private EquipMapper equipMapper;

    @Autowired
    private SerialnumberService serialnumberService;


    /**
     * 添加设备维护信息
     *
     * @param equipTypeInfo 设备信息
     */
    public void addEquipInfo(EquipTypeInfo equipTypeInfo) {
//        try {
//            String creator = DataContextManager.current().getMUODataContext().getUserObject().getUserId();
//            equipTypeInfo.setCreator(creator);
//            equipTypeInfo.setCreateTime(new Date());
//            if (equipTypeInfo.getUpdateTime() == null) {
//                equipTypeInfo.setUpdateTime(new Date());
//            }
//            if (equipTypeInfo.getUpdater() == null) {
//                equipTypeInfo.setUpdater(creator);
//            }
//        } catch (Exception e) {
//            throw new RuntimeException(e);
//        }

        //编码规则，参数是编码规则表功能编码functionNum,title_rule 不能为空,function_name 唯一编码  currentvalue 当前流水号 number_rule {流水规则} 接受方式，num_basis
        String coding = serialnumberService.getSerialNum("sbCod").replace("_", "");
        equipTypeInfo.setEquipTypeCode(coding);
        String creator = DataContextManager.current().getMUODataContext().getUserObject().getUserId();
        equipTypeInfo.setCreator(creator);
        equipTypeInfo.setCreateTime(new Date());
        equipMapper.addEquipInfo(equipTypeInfo);

    }

    /**
     * 查询所有信息
     */
    public List<EquipTypeInfoVo> queryEquipInfos(String page, String limit,
                                                 String equipTypeCode,
                                                 String equipTypeName,
                                                 String equipTypeEnable,
                                                 String manufacturer,
                                                 String equipControllerModel,
                                                 String protocolCommunication,
                                                 String mesIpAddress,
                                                 String equipCreatorName,
                                                 String createTime,
                                                 String equipUpdaterName,
                                                 String updateTime, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "a.equip_type_name");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipTypeCode", equipTypeCode);
        map.put("equipTypeName", equipTypeName);
        map.put("equipTypeEnable", equipTypeEnable);
        map.put("manufacturer", manufacturer);
        map.put("equipControllerModel", equipControllerModel);
        map.put("protocolCommunication", protocolCommunication);
        map.put("mesIpAddress", mesIpAddress);
        map.put("equipCreatorName", equipCreatorName);
        map.put("createTime", createTime);
        map.put("equipUpdaterName", equipUpdaterName);
        map.put("updateTime", updateTime);
        return equipMapper.queryEquipInfos(map);

    }

    /**
     * 记录条数
     *
     * @param
     * @return
     */
    public int count(String equipTypeCode,
                     String equipTypeName,
                     String equipTypeEnable,
                     String manufacturer,
                     String equipControllerModel,
                     String protocolCommunication,
                     String mesIpAddress,
                     String equipCreatorName,
                     String createTime,
                     String equipUpdaterName,
                     String updateTime) {
        return equipMapper.count(equipTypeCode,equipTypeName, equipTypeEnable, manufacturer, equipControllerModel, protocolCommunication, mesIpAddress, equipCreatorName, createTime, equipUpdaterName, updateTime);
    }

    /**
     * 编辑
     */
    public void updateEquipInfo(EquipTypeInfo equipTypeInfo) {
        String creator = DataContextManager.current().getMUODataContext().getUserObject().getUserId();
        equipTypeInfo.setUpdater(creator);
        equipTypeInfo.setUpdateTime(new Date());
        equipMapper.updateEquipInfo(equipTypeInfo);
    }

    /**
     * 批量删除
     *
     * @param equipTypeIds 编号
     */
    public void deleteEquipInfos(List<Integer> equipTypeIds) {
        equipMapper.deleteEquipInfos(equipTypeIds);
    }



    /**
     * 批量启用
     */
    public void enable(List<Integer> equipTypeIds) {
        EquipTypeInfo equipTypeInfo = new EquipTypeInfo();
        IUserObject useObject = DataContextManager.current().getMUODataContext().getUserObject();
        for (Integer integer:equipTypeIds){
            equipTypeInfo.setEquipTypeId(integer);
            equipTypeInfo.setEquipTypeEnable("101");
            equipTypeInfo.setUpdater(useObject.getUserName());
            equipTypeInfo.setUpdateTime(new Date());
            equipMapper.enable(equipTypeInfo);
        }
    }


    /**
     * 查询设备类型名称作为设备管理的高级查询的下拉选项
     */
    public List<EquipTypeInfo> getEquipTypeName(){
        return equipMapper.getEquipTypeName();
    }
}
