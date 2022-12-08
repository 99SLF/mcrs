package com.zimax.mcrs.device.service;

import com.zimax.mcrs.device.mapper.StarSoftwareMapper;
import com.zimax.mcrs.device.pojo.StarSoftware;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * 软件自启动服务层
 * @author 林俊杰
 * @date 2022/12/1
 */
@Service
public class StarSoftwareService {

    /**
     * 角色数据操作
     */
    @Autowired
    private StarSoftwareMapper starSoftwareMapper;

    /**
     * 查询所有设备并检查设备当前状态
     * @return
     */
//    private List<StarSoftware> queryStarSoftware(int page, int limit){
//        System.out.println("success---");
//        System.out.println(starSoftwareMapper.findAll());
//        System.out.println("success");
//        return null;
//    }

}
