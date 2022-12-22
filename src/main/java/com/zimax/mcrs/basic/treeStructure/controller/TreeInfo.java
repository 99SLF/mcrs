package com.zimax.mcrs.basic.treeStructure.controller;

import com.zimax.components.coframe.tools.IconCls;
import com.zimax.mcrs.basic.treeStructure.pojo.TreeTemplate;
import com.zimax.mcrs.basic.treeStructure.service.TreeService;
import com.zimax.mcrs.config.Result;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 树型信息
 * @author 李伟杰
 * @date 2022/12/21 9:25
 */
@RestController
@RequestMapping("/TreeInfo")
public class TreeInfo {

    private static final String CATEGORY_TREE_ROOT = "基础数据";

    private static final String TYPE_CATEGORY = "category";

    @Autowired
    private TreeService treeService;
    /**
     *  查询所有树信息
     * @param order       排序方式
     * @param field       排序字段
     * @return 树信息列表
     * @return total 总记录数
     * @return code 状态码
     * @return msg 返回信息
     */
    @GetMapping("/query")
    public Result<?> queryTreeInfo(String order, String field ,String infoId) {
        List TreeInfo = treeService.queryTreeInfo(order, field, infoId);
        return Result.success(TreeInfo, treeService.count());
    }



    /**
     * 根据节点查询构建分类树
     * @param nodeId 节点id
     * @return
     */
    @GetMapping("/queryCategoryTreeNode")
    public List<Map<String, Object>>  queryCategoryTreeNode(String nodeId){
        List<Map<String, Object>> list = new ArrayList<Map<String, Object>>();
        List<TreeTemplate> TreeInfos =
                treeService.queryTreeInfo("asc","display_order" ,null);
        list = getCategoryRoot(TreeInfos);
        return list;
    }

    /**
     * 编辑修改树节点
     * @param treeTemplate
     */
    @PostMapping("/update")
    public Result<?> updateTree(@RequestBody TreeTemplate treeTemplate){
        treeTemplate.setLogicStates(0);
        treeService.updateTreeTemplate(treeTemplate);
        return Result.success(treeTemplate);
    }

    /**
     * 新增树节点
     * @param treeTemplate
     */
    @PostMapping("/save")
    public Result<?> saveTree(@RequestBody TreeTemplate treeTemplate){
        //序号
        String seq = "";

        //没有父节点
        if (treeTemplate.getParentId() == null ) {
           // seq = "." + treeTemplate.getInfoId() + ".";
        }else {
            //有父节点
            List<TreeTemplate> TreeInfos =
                    treeService.queryTreeInfo(null, null, String.valueOf(treeTemplate.getParentId()));
            TreeTemplate  partTreeInfo = TreeInfos.get(0);
            //seq =  String.valueOf(partTreeInfo.getInfoSeq()) + treeTemplate.getInfoId() + ".";

            //父树计数+1
            partTreeInfo.setSubCount(partTreeInfo.getSubCount() + 1);

            //保存父树
            treeService.updateTreeTemplate(partTreeInfo);
        }

        //新增树序号和计数赋值
        //treeTemplate.setInfoSeq(seq);
        treeTemplate.setLogicStates(0);
        treeTemplate.setSubCount(0);

        //新增树
        treeService.addTreeTemplate(treeTemplate);
        return Result.success(treeTemplate);
    }


    /**
     * 逻辑删除树和此树的所有子类
     * @param treeTemplate
     */
    @PostMapping("/del")
    public Result<?>  deleteTree(@RequestBody TreeTemplate treeTemplate){
        //删除子类
        List<TreeTemplate> TreeInfos =
                treeService.queryTreeInfo("asc","display_order" ,String.valueOf(treeTemplate.getInfoId()));
        for(TreeTemplate TreeInfo : TreeInfos){
            TreeInfo.setLogicStates(1);
            treeService.updateTreeTemplate(TreeInfo);
            delSubTree(String.valueOf(TreeInfo.getInfoId()));
        }

        //更新父类计数
        List<TreeTemplate> partTreeInfos =
                treeService.queryTreeInfo("asc","display_order" ,String.valueOf(treeTemplate.getParentId()));
        TreeTemplate partTreeInfo = partTreeInfos.get(0);
        partTreeInfo.setSubCount(partTreeInfo.getSubCount() - 1);
        treeService.updateTreeTemplate(partTreeInfo);
        return Result.success();
    }

    /**
     * 删除父类id是参数的所有子类
     * @param partId
     */
    public void delSubTree(String partId){
        List<TreeTemplate> TreeInfos =
                treeService.querySubTreeInfo("asc","display_order" ,partId);
        for(TreeTemplate TreeInfo : TreeInfos){
            TreeInfo.setLogicStates(1);
            treeService.updateTreeTemplate(TreeInfo);
            this.delSubTree(String.valueOf(TreeInfo.getInfoId()));
        }
    }




    /**
     * 获取分类的根和一级节点
     *
     * @param categorys
     *            一级分类列表
     * @return 根和一级节点列表
     */
    public List<Map<String, Object>> getCategoryRoot(List<TreeTemplate> categorys) {
        List<Map<String, Object>> rootList = new ArrayList<Map<String, Object>>();
        Map<String, Object> rootMap = new HashMap<String, Object>();
        rootMap.put("id", "root");
        rootMap.put("text", CATEGORY_TREE_ROOT);
        rootMap.put("type", "root");
        rootMap.put("iconCls", IconCls.APPLICATION_HOME);
        rootMap.put("isLeaf", false);
        rootMap.put("expanded", true);
        rootMap.put("categorySeq", "root");
        rootList.add(rootMap);
        // 构造分类List
        for (TreeTemplate category : categorys) {
            Map<String, Object> map = new HashMap<String, Object>();
            if(category.getParentId() == null){
                map.put("id", category.getInfoId());
                map.put("text", category.getInfoName());
                map.put("type", TYPE_CATEGORY);
                map.put("iconCls", IconCls.MENU);
                map.put("isLeaf", false);
                map.put("expanded", false);
                map.put("pid", "root");
                map.put("categorySeq", category.getInfoSeq());
                rootList.add(map);
            }else{
                map.put("id", category.getInfoId());
                map.put("text", category.getInfoName());
                map.put("type", TYPE_CATEGORY);
                map.put("iconCls", IconCls.MENU);
                map.put("isLeaf", false);
                map.put("expanded", false);
                map.put("pid", category.getParentId());
                map.put("categorySeq", category.getInfoSeq());
                rootList.add(map);
            }

        }
        return rootList;
    }

    /**
     * 获取子分类节点列表
     *
     * @param categorys
     *            子分类列表
     * @return 子分类节点列表
     */
    public List<Map<String, Object>> getCategoryNode(List<TreeTemplate> categorys) {
        List<Map<String, Object>> nodeList = new ArrayList<Map<String, Object>>();
        for (TreeTemplate category : categorys) {
            Map<String, Object> map = new HashMap<String, Object>();
            map.put("id", category.getInfoId());
            map.put("text", category.getInfoName());
            map.put("type", TYPE_CATEGORY);
            map.put("iconCls", IconCls.MENU);
            map.put("isLeaf", false);
            map.put("expanded", false);
            // 如果parent为null，则父节点为root
            if (category.getParentId() == null) {
                map.put("pid", "root");
            } else {
                if ("".equals(category.getParentId())
                        || category.getParentId() == null) {
                    map.put("pid", "root");
                } else {
                    map.put("pid",
                            category.getParentId());
                }
            }
            nodeList.add(map);
        }
        return nodeList;
    }


}
