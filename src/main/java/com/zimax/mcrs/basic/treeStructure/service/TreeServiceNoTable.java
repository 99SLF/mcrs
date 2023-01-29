package com.zimax.mcrs.basic.treeStructure.service;

import com.zimax.components.coframe.tools.IconCls;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfo;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.Matrix;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo.ProcessInfo;
import com.zimax.mcrs.basic.treeStructure.mapper.TreeMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2023/1/16 14:05
 */
@Service
public class TreeServiceNoTable {

    /**
     * 树的数据操作
     * @param
     * @return
     */
    @Autowired
    private TreeMapper treeMapper;

    private static final String CATEGORY_TREE_ROOT = "基础数据";

    private static final String TYPE_CATEGORY = "category";



    public List<Map<String, Object>>getApplicationTree(List<Matrix> matrixList,
                                        List<FactoryInfo> factoryInfoList, List<ProcessInfo> processInfoList) {
        List<Map<String, Object>> treeList = new ArrayList<>();
        Map<String, Object> rootMap = new HashMap<String, Object>();
        rootMap.put("id", "root");
        rootMap.put("realId","0"); //真实id
        rootMap.put("text", CATEGORY_TREE_ROOT);
        rootMap.put("detail", "root"); //内容
        rootMap.put("type", "root");
        rootMap.put("iconCls", IconCls.APPLICATION_HOME);
        rootMap.put("isLeaf", false);
        rootMap.put("expanded", true);
        rootMap.put("categorySeq", "root");
        rootMap.put("infoType", "root");
        treeList.add(rootMap);

        //基地功能树
        Map<Integer, String> matrixTreeMap = new HashMap<Integer, String>();
        for (Matrix matrix : matrixList) {
            matrixTreeMap.put(matrix.getMatrixId(), "matrix_" + matrix.getMatrixId());

        }
        Map<Integer, String> factoryTreeMap = new HashMap<Integer, String>();
        for (FactoryInfo factory : factoryInfoList) {
            factoryTreeMap.put(
                    factory.getFactoryId(), "factory_" + factory.getFactoryId());
        }

        // 构造基地树
        for (Matrix matrix : matrixList) {
            Map map = new HashMap();
            map.put("id", "matrix_" + matrix.getMatrixId()); //id
            map.put("realId", matrix.getMatrixId()); //真实id
            map.put("text", matrix.getMatrixName()); //内容
            map.put("detail", matrix.getMatrixAddress());
            map.put("infoType", "matrix"); //类型
            map.put("isLeaf", false);
            map.put("expanded", false);
            map.put("iconCls", IconCls.APPLICATION);
            map.put("pid", "root");
            treeList.add(map);
        }
        // 构造工厂树
        for (FactoryInfo factory : factoryInfoList) {
            Map map = new HashMap();
            map.put("id", "factory_" + factory.getFactoryId());
            map.put("realId", factory.getFactoryId());
            map.put("text", factory.getFactoryName());
            map.put("detail", factory.getFactoryAddress());
            map.put("infoType", "factory");
            map.put("isLeaf", false);
            map.put("expanded", false);
            map.put("pid", matrixTreeMap.get(factory.getMatrixId()));
//            map.put("pid", matrixTreeMap.get(String.valueOf(factory.getParentId())));
//            map.put("pid", matrixTreeMap.get(factory.getParentId()));
            map.put("iconCls", IconCls.FUNCTION_GROUP_CLOSE);
            treeList.add(map);
        }
        // 构造工序树
        for (ProcessInfo process : processInfoList) {
            Map map = new HashMap();
            map.put("id", "process_" + process.getProcessId());
            map.put("realId", process.getProcessId());
            map.put("text", process.getProcessName());
            map.put("detail", process.getProcessRemarks());
            map.put("infoType", "process");
            map.put("isLeaf", false);
            map.put("expanded", false);
//            map.put("pid", factoryTreeMap.get(String.valueOf(process.getParentId())));
//            map.put("pid", factoryTreeMap.get(process.getParentId()));
            map.put("pid", factoryTreeMap.get(process.getFactoryId()));
            map.put("iconCls", IconCls.MENU_ROOT);
            treeList.add(map);
        }
        return treeList;
    }
}
