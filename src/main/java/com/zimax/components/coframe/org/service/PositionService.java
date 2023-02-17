package com.zimax.components.coframe.org.service;

import com.baomidou.mybatisplus.core.toolkit.StringUtils;
import com.zimax.components.coframe.org.interfaces.IEmpPositionService;
import com.zimax.components.coframe.org.interfaces.IPositionService;
import com.zimax.components.coframe.org.mapper.PositionMapper;
import com.zimax.components.coframe.org.pojo.Organization;
import com.zimax.components.coframe.org.pojo.Position;
import com.zimax.components.coframe.org.pojo.vo.OrgResponse;
import com.zimax.components.coframe.org.pojo.vo.QueryPositionEmp;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 * @Author 施林丰
 * @Date:2023/2/13 11:17
 * @Description
 */
@Service
public class PositionService implements IPositionService {

    @Autowired
    private PositionMapper positionMapper;

    private IEmpPositionService empPositionService = null;

    /**
     * 获取岗位下的所有子岗位
     *
     * @param manaPosi
     * @return
     */
    public Position[] querySubPositions(Integer manaPosi) {
        if (manaPosi==null) {
            return new Position[0];
        }
        Position[] positions = positionMapper.querySubPositions(manaPosi);

        return positions;
    }


    /**
     * 获取岗位下的所有员工
     *
     * @param positionid
     * @return
     */
    public QueryPositionEmp[] queryEmployeesOfPosition(Integer positionid) {
        if (positionid==null) {
            return new QueryPositionEmp[0];
        }
        QueryPositionEmp[] emps = positionMapper.queryEmployeesOfPosition(positionid);
        return emps;
    }
    public OrgResponse addPosition(Position orgPosition) {
        return null;
    }

    public void deletePosition(Position[] orgPositions) {

    }

    public void getPosition(Position orgPosition) {

    }

    @Override
    public OrgResponse updatePosition(Position orgPosition) {
        return null;
    }

    private Position getPositionWithDetail(Position position) {
        return null;
    }








    /**
     * 获取子岗位的同时获取父岗位信息
     *
     * @param position
     */
    public Position getPositionWithParent(Position position) {
        return  null;
    }

    /*
     * (non-Javadoc)
     *
     * @see
     * com.zimax.components.coframe.org.IPositionService#deletePositionCascade
     * (com.zimax.components.coframe.org.dataset.OrgOrganization)
     */
    public void deletePositionCascadeByParentOrg(Organization parentOrg) {

    }

    /**
     * 根据父机构查询所有子岗位
     *
     * @param parentOrg
     *            父机构
     * @return 子岗位列表
     */
    public Position[] querySubPositionsByOrg(Organization parentOrg) {

        return new Position[0];
    }



    public void deletePosition(String positionid, String parentPositionid,
                               String parentType) {

    }

    public void deletePosition(String positionid) {

    }

    public void setEmpPositionService(IEmpPositionService empPositionService) {
        this.empPositionService = empPositionService;
    }
}
