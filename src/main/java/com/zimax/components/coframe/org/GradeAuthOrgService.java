package com.zimax.components.coframe.org;

import com.zimax.cap.party.Party;
import com.zimax.components.coframe.auth.party.manager.DefaultRoleManager;
import com.zimax.components.coframe.rights.gradeauth.GradeAuthService;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @Author 施林丰
 * @Date:2023/2/13 15:21
 * @Description
 */
@Service
public class GradeAuthOrgService {
    private GradeAuthService gradeAuthService;
    public void setGradeAuthService(GradeAuthService gradeAuthService) {
        this.gradeAuthService = gradeAuthService;
    }
    public GradeAuthService getGradeAuthService() {
        return gradeAuthService;
    }
    /**
     * 获取可管理机构列表
     * @return
     */
    public List<Party> getManagedOrgList() {
        return getGradeAuthService().getManagedOrgList();
    }
}
