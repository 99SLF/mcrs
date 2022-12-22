package com.zimax.mcrs.basic.treeStructure.service;

import com.zimax.mcrs.basic.treeStructure.mapper.TreeMapper;
import com.zimax.mcrs.basic.treeStructure.pojo.TreeTemplate;
import com.zimax.mcrs.config.ChangeString;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/21 9:29
 */
@Service
public class TreeService {

    /**
     * 树的数据操作
     * @param
     * @return
     */
    @Autowired private TreeMapper treeMapper;

    /**
     * 查询树信息
     */
    public List<TreeTemplate> queryTreeInfo(String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String, Object> map = new HashMap<>();
        if (order == null) {
            map.put("order", "asc");
            map.put("field", "display_order");
        } else {
            map.put("order", order);
            map.put("field", changeString.camelUnderline(field));
        }
        return treeMapper.queryTreeInfo(map);

    }
    public int count() {
        return treeMapper.count();
    }
}
