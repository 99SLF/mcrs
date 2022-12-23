package com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfoVo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.mapper.FactoryMapper;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfoVo;
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
 * @date 2022/12/19 14:16
 */
@Service
public class FactoryService {
    @Autowired
    private FactoryMapper factoryMapper;
    @Autowired
    private SerialnumberService serialnumberService;

    /**
     * 添加工厂维护信息
     * @param factoryInfo 监控信息
     */
    public void addFactoryInfo(FactoryInfo factoryInfo){
        String coding = serialnumberService.getSerialNum("gcCod").replace("_", "");
        factoryInfo.setFactoryCode(coding);

        factoryMapper.addFactoryInfo(factoryInfo);
    }

//    /**
//     *主键删除一条工厂信息
//     */
//    public void deleteFactory(int factoryId) {
//        factoryMapper.deleteFactory(factoryId);
//    }


    /**
     * 编辑
     */
    public void updateFactoryInfo(FactoryInfo factoryInfo) {

        IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
        factoryInfo.setUpdater(usetObject.getUserName());
        factoryInfo.setUpdateTime(new Date());
        factoryMapper.updateFactoryInfo(factoryInfo);
    }

    /**
     * 查询所有信息
     */
    public List<FactoryInfoVo> queryFactoryInfos(String page, String limit, String infoId, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "create_time");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("infoId", infoId);
        return factoryMapper.queryFactoryInfos(map);

    }

    /**
     * 记录条数
     *
     * @param
     * @return
     */
    public int count(String infoId) {
        return factoryMapper.count(infoId);
    }

}
