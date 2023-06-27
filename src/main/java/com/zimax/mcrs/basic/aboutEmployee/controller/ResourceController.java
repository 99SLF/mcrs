package com.zimax.mcrs.basic.aboutEmployee.controller;
import com.zimax.mcrs.basic.aboutEmployee.pojo.ResourceTree;
import com.zimax.mcrs.basic.aboutEmployee.service.ResourceService;
import com.zimax.mcrs.basic.accPointResMaintain.pojo.AccPointResVo;
import com.zimax.mcrs.basic.accPointResMaintain.service.AccPointResService;
import com.zimax.mcrs.config.Result;
import com.zimax.mcrs.device.pojo.EquipmentVo;
import com.zimax.mcrs.device.service.EquipmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/ResourceController")
public class ResourceController {

    @Autowired
    private ResourceService resourceService;
    @Autowired
    private AccPointResService accPointResService;

    @Autowired
    private EquipmentService equipmentService;

    /**
     * 获取资源授权树
     *
     * @param roleId 角色编号
     * @return 功能授权树
     */
    @GetMapping("/tree")
    public Result<?> getResourceTree(@RequestParam("roleId") int roleId) {
        List<AccPointResVo> accPoints = accPointResService.queryAllAccPointRes();
        List<EquipmentVo> equipments = equipmentService.queryAllEquipments();
        List<Map<String, Object>> resourcePointTree = resourceService.getResourcePointTree(accPoints, equipments,roleId);
        return Result.success(resourcePointTree);
    }

    /**
     * 添加资源授权
     * @param roleId 角色id
     * @param resourceTree 资源树
     * @return
     */
    @PostMapping("/tree/save")
    public Result<?> saveResource(@RequestParam("roleId") int roleId,
                                  @RequestBody List<ResourceTree> resourceTree){
        return Result.success(resourceService.saveResource(roleId,resourceTree));
    }

}
