package com.zimax.mcrs.basic.accPointResMaintain.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.components.coframe.rights.DefaultUserManager;
import com.zimax.components.coframe.rights.pojo.User;
import com.zimax.mcrs.basic.accPointResMaintain.mapper.AccPointResMapper;
import com.zimax.mcrs.basic.accPointResMaintain.pojo.AccPointRes;
import com.zimax.mcrs.basic.accPointResMaintain.pojo.AccPointResVo;
import com.zimax.mcrs.config.ChangeString;
import com.zimax.mcrs.serialnumber.service.SerialnumberService;
import com.zimax.mcrs.warn.pojo.AlarmEvent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/24 16:47
 */
@Service
public class AccPointResService {

    @Autowired
    private AccPointResMapper accPointResMapper;
    @Autowired
    private SerialnumberService serialnumberService;



    /**
     * 查询所有接入点信息
     * @return
     */
    public List<AccPointResVo> queryAccPointRes(String page, String limit, String accPointResCode, String accPointResName, String creator, String createTime, String order, String field) {
        ChangeString changeString = new ChangeString();
        Map<String,Object> map= new HashMap<>();
        if(order==null){
            map.put("order","asc");
            map.put("field","acc_point_res_code");
        }else{
            map.put("order",order);
            map.put("field",changeString.camelUnderline(field));
        }
        if (limit != null) {
            map.put("begin", Integer.parseInt(limit) * (Integer.parseInt(page) - 1));
            map.put("limit", Integer.parseInt(limit));
        }
        map.put("accPointResCode",accPointResCode);
        map.put("accPointResName",accPointResName);
        map.put("creator",creator);
        map.put("createTime",createTime);
        return accPointResMapper.queryAccPointRes(map);
    }

    /**
     * 查询记录
     */
    public int count(String accPointResCode, String accPointResName, String creator, String createTime){
        return accPointResMapper.count(accPointResCode,accPointResName,creator,createTime);
    }


    /**
     * 新增
     * @param accPointRes 接入点信息
     */
    public void addAccPointRes(AccPointRes accPointRes) {
        String coding = serialnumberService.getSerialNum("jrdCod").replace("_", "");
        accPointRes.setAccPointResCode(coding);
        accPointResMapper.addAccPointRes(accPointRes);
    }

    /**
     * 删除
     * @param accPointResId 依据Id来删除
     */
    public void deleteAccPointRes(int accPointResId) {
        accPointResMapper.deleteAccPointRes(accPointResId);
    }

    /**
     * 更新
     */
    public void updateAccPointRes(AccPointRes accPointRes) {
        //域名要一致才可以，127.0.0.1和localhost不一样
        IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
        accPointRes.setUpdater(usetObject.getUserName());
        accPointRes.setUpdateTime(new Date());
        accPointResMapper.updateAccPointRes(accPointRes);
    }





    /**
     * 批量删除
     */
    public void batchDelete(List<Integer> accPointResIds) {
        accPointResMapper.batchDelete(accPointResIds);
    }


    /**
     * 批量启用（弃用了）
     *
     * @param accPointRess
     */
    public void changeEnable(List<AccPointRes> accPointRess) {
        String isEnable = "101";
        for (AccPointRes accPointRes : accPointRess) {
            accPointRes.setIsEnable(isEnable);
        }
        accPointResMapper.changeEnable(accPointRess);

    }


    /**
     * 批量启用告警事件
     */
    public void enable(List<Integer> accPointResIds) {
        AccPointRes accPointRes = new AccPointRes();
        IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
        for (Integer integer:accPointResIds){
            accPointRes.setAccPointResId(integer);
            accPointRes.setIsEnable("101");
            accPointRes.setUpdater(usetObject.getUserName());
            accPointRes.setUpdateTime(new Date());
            accPointResMapper.enable(accPointRes);
        }
    }

}
