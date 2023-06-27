package com.zimax.mcrs.basic.aboutEmployee.service;

import com.zimax.components.coframe.tools.IconCls;
import com.zimax.mcrs.basic.aboutEmployee.mapper.EmpRoleMapper;
import com.zimax.mcrs.basic.aboutEmployee.pojo.ResourceTree;
import com.zimax.mcrs.basic.accPointResMaintain.pojo.AccPointResVo;
import com.zimax.mcrs.device.pojo.EquipmentVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class ResourceService {
    @Autowired
    private EmpRoleMapper empRoleMapper;
    /**
     * 基础部分权限授权的树数据
     * @param accPoints
     * @param equipments
     * @return
     */
    public List<Map<String, Object>> getResourcePointTree(List<AccPointResVo> accPoints,List<EquipmentVo> equipments, int roleId){
        List<Map<String, Object>> treeList = new ArrayList<Map<String, Object>>();

        // 一级节点 资源接入点
        for (AccPointResVo accPoint : accPoints) {
            Map map = new HashMap();
            map.put("id", "parentAccPoint"+"_" + accPoint.getAccPointResId());
            map.put("realId", accPoint.getAccPointResId());
            map.put("text", accPoint.getAccPointResName());
            map.put("type", "parentAccPoint");
            map.put("iconCls", IconCls.APPLICATION);
            treeList.add(map);
        }

        // 二级节点 设备资源
        for (EquipmentVo equipment : equipments) {
            Map map = new HashMap();
            map.put("id", "equipment" + "_" + equipment.getEquipmentInt());
            map.put("realId", equipment.getEquipmentInt());
            map.put("text", equipment.getEquipmentName());
            map.put("type", "equipment");
            map.put("pid", "parentAccPoint"+"_" + equipment.getAccPointResId());
            map.put("iconCls", IconCls.MENU_ROOT);
            int equId = equipment.getEquipmentInt();
            // 使用roleId和equId从关联表中查询是否有此条数据
            int checkedState = empRoleMapper.getCheckedState(roleId,equId);
            if (checkedState>0){
                map.put("checked", true);
            }
            treeList.add(map);
        }
        return treeList;
    }

    /**
     * 添加资源授权
     * @param roleId 角色id
     * @param resourceTree 选中的树数据
     */
    public boolean saveResource(int roleId, List<ResourceTree> resourceTree ){
        if (resourceTree != null) {
            // 先删除角色已有的资源
            empRoleMapper.deleteResources(roleId);
            for (ResourceTree equipment : resourceTree) {
                int equipmentId = equipment.getRealId();
                empRoleMapper.addResource(roleId, equipmentId);
            }
            return true;
        } else {
            return false;
        }
    }
}
