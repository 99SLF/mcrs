package com.zimax.mcrs.basic.accPointResMaintain.mapper;

import com.zimax.mcrs.basic.accPointResMaintain.pojo.AccPointRes;
import com.zimax.mcrs.basic.accPointResMaintain.pojo.AccPointResVo;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * @author 李伟杰
 * @date 2022/12/24 16:47
 */
@Mapper
public interface AccPointResMapper {


    /**
     * 查询全部信息
     *
     * @return
     */
    List<AccPointResVo> queryAccPointRes(Map map);

    /**
     * 新增信息
     *
     * @return
     */
    void addAccPointRes(AccPointRes accPointRes);

    /**
     * @return
     */
    void deleteAccPointRes(int accPointResId);

    /**
     * 修改终端
     *
     * @return
     */
    void updateAccPointRes(AccPointRes accPointRes);


    /**
     * 计数
     *
     * @return
     */
    int count(@Param("accPointResCode") String accPointResCode, @Param("accPointResName") String accPointResName, @Param("creator") String creator, @Param("createTime") String createTime);


    /**
     * 批量删除
     *
     * @param accPointResIds
     */
    void batchDelete(List<Integer> accPointResIds);
}


