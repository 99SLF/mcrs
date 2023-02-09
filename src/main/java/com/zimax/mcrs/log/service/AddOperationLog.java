package com.zimax.mcrs.log.service;

import com.zimax.cap.datacontext.DataContextManager;
import com.zimax.cap.party.IUserObject;
import com.zimax.mcrs.log.pojo.OperationLog;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.Date;

/**
 * 当日志发生查询操作，添加一条信息到操作日志中
 * 八个日志生成操作日志的公共类
 * @author 林俊杰
 * @date 2023/2/9
 */
@Service
public class AddOperationLog {

    @Autowired
    private OperationLogService operationLogService;

    /**
     * 日志删除规则生成操作日志
     * 但由于日志删除规则不能新增和删除，故只能生成查询与修改操作日志
     */
    public void addOperationLog(int a) {
        //获取当前用户信息
        IUserObject userObject = DataContextManager.current().getMUODataContext().getUserObject();
        //创建操作日志对象
        OperationLog operationLog = new OperationLog();
        operationLog.setLogStatus("101");
        operationLog.setResult("101");
        operationLog.setUser(userObject.getUserId());
        operationLog.setOperationTime(new Date());
        operationLog.setOperationType("104");

        switch (a){
            case 1:
                operationLog.setOperationContent("查询异常日志");
                break;
            case 2:
                operationLog.setOperationContent("查询设备交互日志");
                break;
            case 3:
                operationLog.setOperationContent("查询接口日志");
                break;
            case 4:
                operationLog.setOperationContent("查询登录日志");
                break;
            case 5:
                operationLog.setOperationContent("查询MES交互日志");
                break;
            case 6:
                operationLog.setOperationContent("查询操作日志");
                break;
            case 7:
                operationLog.setOperationContent("查询PLC交互日志");
                break;
            case 8:
                operationLog.setOperationContent("查询RFID交互日志");
                break;
        }

        operationLogService.addOperationLog(operationLog);
    }

}
