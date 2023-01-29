package com.zimax.mcrs.basic.treeStructure.controller;

import com.zimax.components.coframe.tools.IconCls;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.pojo.FactoryInfo;
import com.zimax.mcrs.basic.matrixInfo.factoryInfoMaintain.service.FactoryService;
import com.zimax.mcrs.basic.matrixInfo.matrix.pojo.Matrix;
import com.zimax.mcrs.basic.matrixInfo.matrix.service.MatrixService;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.pojo.ProcessInfo;
import com.zimax.mcrs.basic.matrixInfo.processInfoMaintain.service.ProcessService;
import com.zimax.mcrs.basic.treeStructure.pojo.TreeTemplate;
import com.zimax.mcrs.basic.treeStructure.service.TreeService;
import com.zimax.mcrs.basic.treeStructure.service.TreeServiceNoTable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 *
 * 无树表的目录树
 * @author 李伟杰
 * @date 2023/1/16 13:59
 */
@RestController
@RequestMapping("/TreeInfoTr")
public class TreeInfoNoTable {


    @Autowired
    private TreeService treeService;

    @Autowired
    private TreeServiceNoTable treeServiceNoTable;

    @Autowired
    private FactoryService factoryService;

    @Autowired
    private MatrixService matrixService;

    @Autowired
    private ProcessService processService;

    /**
     * 根据节点查询构建分类树(二版使用)，有树表
     * @param nodeId 节点id
     * @return
     */
    @GetMapping("/queryCategoryTreeNodeTr")
    public List<Map<String, Object>>  queryCategoryTreeNodeTr(String nodeId){
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        List<Matrix> matrixList = matrixService.queryMatrixTree();
        List<FactoryInfo> factoryInfoList = factoryService.queryFactoryInfosTree();
        List<ProcessInfo> processInfoList = processService.queryProcessInfoTree();
        list =  treeServiceNoTable.getApplicationTree(matrixList,factoryInfoList,processInfoList);
        return list;
    }
}
