package com.zimax.mcrs.basic.accPointResMaintain.mapper;

import com.zimax.mcrs.basic.accPointResMaintain.pojo.AccPointRes;
import com.zimax.mcrs.basic.accPointResMaintain.pojo.AccPointResVo;
import com.zimax.mcrs.warn.pojo.AlarmEvent;
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
     * 计数
     *
     * @return
     */
    int countAll(@Param("accPointResCode") String accPointResCode,
              @Param("accPointResName") String accPointResName,
              @Param("isEnable") String isEnable,
              @Param("matrixCode") String matrixCode,
              @Param("factoryCode") String factoryCode,
              @Param("accCreatorName") String accCreatorName,
              @Param("createTime") String createTime,
              @Param("accUpdaterName") String accUpdaterName,
              @Param("updateTime") String updateTime,
              @Param("matrixName") String matrixName

    );

    int count(@Param("accPointResCode") String accPointResCode,
                 @Param("accPointResName") String accPointResName,
                 @Param("accCreatorName") String accCreatorName,
                 @Param("createTime") String createTime
    );

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
     * 批量删除
     *
     * @param accPointResIds
     */
    void batchDelete(List<Integer> accPointResIds);


    /**
     * 弃用了
     *
     * @param
     * @return
     */
    void changeEnable(List<AccPointRes> accPointRess);


    /**
     * 批量启用
     */
    int enable(AccPointRes accPointRes);
}


