package com.zimax.mcrs.basic.treeStructure.mapper;

import com.zimax.mcrs.basic.treeStructure.pojo.TreeTemplate;
import com.zimax.mcrs.report.pojo.AbnProdPrcs;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/21 9:33
 */
@Mapper
public interface TreeMapper {

    /**
     * 查询树信息
     * @param
     * @return
     */
    List<TreeTemplate> queryTreeInfo(Map map);

    /**
     * 查询树信息
     * @param
     * @return
     */
    List<TreeTemplate> querySubTreeInfo(Map map);

    /**
     * 查询记录数
     * @param
     * @return
     */
    int count();

    /**
     * 修改树
     * @param treeTemplate
     */
    void updateTreeTemplate(TreeTemplate treeTemplate);

    /**
     * 新增树
     * @param treeTemplate
     */
    void addTreeTemplate(TreeTemplate treeTemplate);
}
