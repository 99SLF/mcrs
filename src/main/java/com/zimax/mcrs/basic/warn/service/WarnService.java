package com.zimax.mcrs.basic.warn.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.basic.warn.mapper.WarnMapper;
import com.zimax.mcrs.basic.warn.pojo.WarnDealWith;
import com.zimax.mcrs.basic.warn.pojo.WarnManager;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.device.pojo.DeviceRollback;
import com.zimax.mcrs.device.pojo.DeviceRollbackVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @Author 施林丰
 * @Date:2023/3/20 17:17
 * @Description
 */
@Service
public class WarnService {
    @Autowired
    private WarnMapper warnMapper;

    /**
     * 查询预警等级
     * @param page
     * @param limit
     * @param warnGrade
     * @param order
     * @param field
     * @return
     */
    public List<WarnManager> queryWarn(String page, String limit, String warnGrade,String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        List<WarnManager> warnManagers = new ArrayList<>();
        if(order==null){
            map.put("order","desc");
            map.put("field","create_time");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("warnGrade", warnGrade);
        warnManagers = warnMapper.queryWarn(map);
        for(WarnManager warnManager: warnManagers){
            warnManager.setWarnToUser(warnMapper.queryWarnToUser(warnManager.getId()));
        }
        return warnManagers;
    }

    /**
     * 计数
     * @param warnGrade
     * @return
     */
    public int count(String warnGrade) {
        return warnMapper.count(warnGrade);
    }

    /**
     * 新增预警等级
     * @param
     * @return
     */
    public void addWarn(WarnManager warnManager){
        IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
        //18.将当期的用户信息存储到数据库表里
        warnManager.setCreator(usetObject.getUserId());
        warnManager.setCreateTime(new Date());
        warnMapper.addWarn(warnManager);
        int id = warnManager.getId();
        if(warnManager.getWarnToUser()!=null){
            if(warnManager.getWarnToUser().size()!=0){
                for(WarnDealWith warnDealWith: warnManager.getWarnToUser()){
                    warnDealWith.setWarnId(id);
                    warnMapper.addWarnToUser(warnDealWith);
                }
            }
        }
    }
    /**
     * 新增预警等级
     * @param
     * @return
     */
    public void updateWarnToUser(WarnManager warnManager){
        warnMapper.updateWarn(warnManager);
        warnMapper.delWarnToUser(warnManager.getId());
        if(warnManager.getWarnToUser()!=null){
            if(warnManager.getWarnToUser().size()!=0){
                for(WarnDealWith warnDealWith: warnManager.getWarnToUser()){
                    warnDealWith.setWarnId(warnManager.getId());
                    warnMapper.addWarnToUser(warnDealWith);
                }
            }
        }
    }


    /**
     * 检测预警等级是否存在
     * @param
     * @return
     */
    public int isExist(String warnGrade){
       return warnMapper.isExist(warnGrade);
    }

    /**
     * 删除预警等级推送人
     * @param
     * @return
     */
    public void delWarnToUser(int warnId){
        warnMapper.delWarnToUser(warnId);
    }
}
