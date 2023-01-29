package com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.mapper.FactoryMapper;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfoVo;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.Matrix;
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
     * （接入点编辑）
     * 初始化下拉框，获取全部的工厂代码
     */
    public List<FactoryInfoVo> selectListInit(String matrixCode) {
        return factoryMapper.selectListInit(matrixCode);

    }
    public int countFactory(String matrixCode) {
        return factoryMapper.countFactory(matrixCode);
    }



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
     * 查询所有信息工厂信息(树表，废弃)
     */
    public List<FactoryInfoVo> queryFactoryInfos(String page, String limit, String infoId, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "factory_code");
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
     * 记录条数（树表）
     *
     * @param
     * @return
     */
    public int count(String infoId) {
        return factoryMapper.count(infoId);
    }

    /**
     * 查询所有信息工厂信息(无树表)
     */
    public List<FactoryInfoVo> queryFactoryInfosNode(String page, String limit, String nodeId, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "factory_code");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("nodeId", nodeId);
        return factoryMapper.queryFactoryInfosNode(map);

    }

    /**
     * 记录条数（无树表）
     *
     * @param
     * @return
     */
    public int countNode(String nodeId) {
        return factoryMapper.countNode(nodeId);
    }

    /**
     * 查询工厂信息
     */
    public List<FactoryInfo> queryFactoryInfosTree() {
        Map<String, Object> map = new HashMap<>();
        return factoryMapper.queryFactoryInfosTree(map);

    }





    /**
     * 查询所有工厂信息（工厂代码和工厂名称）
     * 代码
     */
    public List<FactoryInfo> selectList(String matrixId) {
        return factoryMapper.selectList(matrixId);

    }

    /**
     * 接入点新增
     * 通过工厂代码获取
     * 查询所有工厂信息（工厂名称）
     * 不能用vo映射
     * 名称
     */
    public List<FactoryInfo> getFactoryName(String factoryCode) {
        Map<String, Object> map = new HashMap<>();
        map.put("factoryCode", factoryCode);
        return factoryMapper.getFactoryName(map);

    }
//    public int countFactory(String infoId) {
//
//        return factoryMapper.countFactory(infoId);
//    }

    public void removeFactory(int realId) {
        factoryMapper.removeFactory(realId);
    }


    /**
     * 通过工厂id查询底下的工序数
     * @param
     */
    public int countFactoryProcess(int factoryId){
       return factoryMapper.countFactoryProcess(factoryId);
    }

    /**
     * （基础数据目录树）
     * 查询出当前树节点的详细工厂信息
     * @param
     * @return
     */
    public List<FactoryInfo> queryFactoryNode(int nodeId) {
        return factoryMapper.queryFactoryNode(nodeId);

    }
}
