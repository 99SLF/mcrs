package com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfoVo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfoVo;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.Matrix;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.MatrixVo;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.mapper.ProcessMapper;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo.ProcessInfo;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo.ProcessInfoVo;
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
 * @date 2022/12/19 14:17
 */
@Service
public class ProcessService {

    @Autowired
    private ProcessMapper processMapper;

    @Autowired
    private SerialnumberService serialnumberService;
    /**
     * 添加工序信息
     * @param processInfo 工序信息
     */
    public void addProcessInfo(ProcessInfo processInfo){
        String coding = serialnumberService.getSerialNum("gxpCod").replace("_", "");
        processInfo.setProcessCode(coding);
        IUserObject useObject = DataContextManager.current().getMUODataContext().getUserObject();
        processInfo.setCreator(useObject.getUserId());
        processInfo.setCreateTime(new Date());
        processMapper.addProcessInfo(processInfo);
    }

    /**
     * 编辑
     */
    public void updateProcessInfo(ProcessInfo processInfo) {
        IUserObject useObject = DataContextManager.current().getMUODataContext().getUserObject();
        processInfo.setUpdater(useObject.getUserId());
        processInfo.setUpdateTime(new Date());
        processMapper.updateProcessInfo(processInfo);
    }

//    /**
//     *主键删除一条工序信息
//     */
//    public void deleteProcess(int processId) {
//        processMapper.deleteProcess(processId);
//    }

    /**
     * 查询所有信息（树表）
     */
    public List<ProcessInfoVo> queryProcessInfo(String page, String limit, String infoId, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "process_code");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("infoId", infoId);
        return processMapper.queryProcessInfo(map);

    }

    /**
     * 记录条数（树表）
     *
     * @param
     * @return
     */
    public int count(String infoId) {
        return processMapper.count(infoId);
    }

    /**
     * 查询所有信息工序信息(无树表)
     */
    public List<ProcessInfoVo> queryProcessInfoNode(String page, String limit, String nodeId, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "process_code");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("nodeId", nodeId);
        return processMapper.queryProcessInfoNode(map);

    }

    /**
     * 记录条数（无树表）
     *
     * @param
     * @return
     */
    public int countNode(String nodeId) {
        return processMapper.countNode(nodeId);
    }


    /**
     * 查询所有信息
     */
    public List<ProcessInfo> queryProcessInfoTree() {
        Map<String, Object> map = new HashMap<>();
        return processMapper.queryProcessInfoTree(map);
    }

    /**
     * （接入点编辑）
     * 初始化下拉框，获取全部获取工序代码
     */
    public List<ProcessInfoVo> selectListInit(String factoryCode) {
        return processMapper.selectListInit(factoryCode);

    }
    public int countProcess(String factoryCode) {
        return processMapper.countProcess(factoryCode);
    }




    /**
     * 接入点新增 通过工厂代码
     * 查询所有工序信息（工序代码和工序名称）
     */
    public List<ProcessInfo> selectList(String factoryId) {
        return processMapper.selectList(factoryId);

    }

    /**
     * 通过工序代码获取
     * 查询所有工序信息（工厂名称）
     * 不能用vo映射
     * 工序名称和工序描述
     */
    public List<ProcessInfo> getProcessNameDe(String processCode) {
        Map<String, Object> map = new HashMap<>();
        map.put("processCode", processCode);
        return processMapper.getProcessNameDe(map);

    }

    public void removeProcess(int processId) {
        processMapper.removeProcess(processId);
    }


    /**
     * 通过工序id查询该工序被接入点引用
     * @param
     */
    public int countProcessAccess(int processId){
        return processMapper.countProcessAccess(processId);
    }

    /**
     * （基础数据目录树）
     * 查询出当前树节点的详工序信息
     * @param
     * @return
     */
    public List<ProcessInfo> queryProcessNode(int nodeId) {
        return processMapper.queryProcessNode(nodeId);

    }
    /**
     * （基础数据目录树）
     * 检测相同父节点下的工序名称是否存在
     *
     * @param parentId 上级节点的id
     */
    public int  checkProcessNameAdd(String parentId,String processName) {
        return processMapper.checkProcessNameAdd(parentId,processName) ;
    }

    /**
     * （基础数据目录树）
     * 检测相同父节点下的工序名称是否存在
     *
     * @param parentId 上级节点的id
     */
    public int  checkProcessNameEdit(String parentId,String processName,String factoryId) {
        return processMapper.checkProcessNameEdit(parentId,processName,factoryId) ;
    }

    /**
     * 根据工序id获取一条工厂信息
     * @param
     * @return
     */
    public ProcessInfo getProcess(int processId){

        return processMapper.getProcess(processId);
    }
}
