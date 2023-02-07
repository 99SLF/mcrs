package com.zimax.mcrs.log.mapper;

import com.zimax.mcrs.log.pojo.InterfaceLog;
import com.zimax.mcrs.log.pojo.InterfaceLogVo;
import com.zimax.mcrs.log.pojo.LoginLog;
import com.zimax.mcrs.log.pojo.LoginLogVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.web.bind.annotation.RequestParam;

import java.util.List;
import java.util.Map;

/**
 * 登录日志操作
 * @author 林俊杰
 * @date 2023/1/11
 */
@Mapper
public interface LoginLogMapper {

    /**
     * 查询所有的登录日志日志
     * @return
     */
    List<LoginLogVo> queryAll(Map map);

    /**
     * 计数
     * @return
     */
    int count(@Param("equipmentId") String equipmentId,
              @Param("equipmentName") String equipmentName,
              @Param("source") String source,
              @Param("loginUserName") String loginUserName,
              @Param("loginTime") String loginTime);

    /**
     * 登录日志添加
     *
     * @return
     */
    void addLoginLog(LoginLog loginLog);

    /**
     * 查询登录日志日志到CS
     * @return
     */
    List<LoginLogVo> csQuery(@RequestParam("APPId") String APPId);

}
