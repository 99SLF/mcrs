package com.zimax.mcrs.log.service;

import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.log.mapper.InterfaceLogMapper;
import com.zimax.mcrs.log.mapper.LoginLogMapper;
import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.log.pojo.InterfaceLogVo;
import com.zimax.mcrs.log.pojo.LoginLog;
import com.zimax.mcrs.log.pojo.LoginLogVo;
import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * 登录日志
 * @author 林俊杰
 * @date 2023/1/11
 */
@Service
public class LoginLogService {

    @Autowired
    private LoginLogMapper loginLogMapper;


    /**
     * 查询所有接口日志信息
     */
    public List<LoginLogVo> queryLoginLogLog(String limit, String page, String equipmentId, String source, String loginUserName, String loginTime, String order, String field){
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","ll.login_time");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("equipmentId",equipmentId);
        map.put("source",source);
        map.put("loginUserName",loginUserName);
        map.put("loginTime",loginTime);
        return loginLogMapper.queryAll(map);
    }

    /**
     * 查询记录
     */
    public int count(String equipmentId,String source,  String loginUserName,String loginTime) {
        return loginLogMapper.count(equipmentId,source,loginUserName,loginTime);
    }

    /**
     * 添加登录日志
     * @param loginLog
     */
    public void addLoginLog(LoginLog loginLog) {
        loginLog.setLogType("101");
        loginLog.setCreateTime(new Date());
        loginLogMapper.addLoginLog(loginLog);
    }

}
