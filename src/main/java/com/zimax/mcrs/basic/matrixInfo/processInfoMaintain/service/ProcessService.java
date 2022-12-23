package com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfo;
import com.zimax.mcrs.basic.equipTypeMaintain.pojo.EquipTypeInfoVo;
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
     * 添加监控信息
     * @param processInfo 监控信息
     */
    public void addProcessInfo(ProcessInfo processInfo){
        String coding = serialnumberService.getSerialNum("gxpCod").replace("_", "");
        processInfo.setProcessCode(coding);
        processMapper.addProcessInfo(processInfo);
    }

    /**
     * 编辑
     */
    public void updateProcessInfo(ProcessInfo processInfo) {
        IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
        processInfo.setUpdater(usetObject.getUserName());
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
     * 查询所有信息
     */
    public List<ProcessInfoVo> queryProcessInfo(String page, String limit, String infoId, String order, String field) {
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
        return processMapper.queryProcessInfo(map);

    }

    /**
     * 记录条数
     *
     * @param
     * @return
     */
    public int count(String infoId) {
        return processMapper.count(infoId);
    }

}
