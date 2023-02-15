package com.zimax.components.coframe.org.interfaces;

import com.zimax.components.coframe.org.pojo.Organization;
import com.zimax.components.coframe.org.pojo.Position;
import com.zimax.components.coframe.org.pojo.vo.OrgResponse;
import com.zimax.components.coframe.org.pojo.vo.QueryPositionEmp;

/**
 * @Author 施林丰
 * @Date:2023/2/13 11:56
 * @Description
 */
public interface IPositionService {
    /**
     * 添加岗位
     *
     * @param orgPosition
     * @return 添加状态返回对象
     */
    OrgResponse addPosition(Position orgPosition);

    /**
     *
     * @param orgPositions
     *            Position[]
     */
    void deletePosition(Position[] orgPositions);

    /**
     * 根据id,父节点删除岗位
     *
     * @param id
     * @param parentId
     * @param parentType
     */
    void deletePosition(String id, String parentId, String parentType);

    /**
     *
     * @param orgPosition
     *            Position[]
     */
    void getPosition(Position orgPosition);

    /**
     *
     * @param criteria
     *            CriteriaType
     * @param page
     *            PageCond
     * @return Position[]
     */
    //Position[] queryPositions(CriteriaType criteriaType, PageCond pageCond);

    /**
     * 更新岗位
     *
     * @param orgPosition
     * @return 更新状态返回对象
     */
    OrgResponse updatePosition(Position orgPosition);

    /**
     * 获取岗位下的所有子岗位
     *
     * @param positionid
     * @return
     */
    Position[] querySubPositions(Integer positionid);

    /**
     * 获取岗位下的所有员工
     *
     * @param positionid
     * @return
     */
    QueryPositionEmp[] queryEmployeesOfPosition(Integer positionid);

    /**
     * 岗位的总记录
     *
     * @param criteria
     * @return 总记录
     */
    //int countPositions(CriteriaType criteria);

    /**
     * 获取子岗位的同时获取父岗位信息
     *
     * @param position
     * @return 岗位
     */
    Position getPositionWithParent(Position position);

    /**
     * 根据父机构级联删除子岗位；删除子岗位之前，需要维护子岗位和人员的关系
     *
     * @param parentOrg
     */
    void deletePositionCascadeByParentOrg(Organization parentOrg);

    /**
     * 根据机构查询出所有的子岗位
     *
     * @param org
     * @return 子岗位列表
     */
    Position[] querySubPositionsByOrg(Organization org);
}
