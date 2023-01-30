package com.zimax.mcrs.report.mapper;

import com.zimax.mcrs.report.pojo.AbnProdPrcs;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * 生产过程异常报表
 *
 * @author 李伟杰
 * @date 2022/12/8 19:28
 */
@Mapper
public interface AbnProdPrcsReportMapper {

    /**
     * 添加报表信息
     *
     * @param abnProdPrcs 生产过程异常报表
     * @return
     */
    void addAbnProdPrcs(AbnProdPrcs abnProdPrcs);

    /**
     * 查询所有生产过程异常报表
     *
     * @param
     * @return
     */
    List<AbnProdPrcs> queryAbnProdPrcses(Map map);

    /**
     * 查询记录数
     *
     * @param
     * @return
     */
    int count(@Param("siteId") String siteId, @Param("rollId") String rollId,
              @Param("equipmentId") String equipmentId, @Param("axisName") String axisName,
              @Param("vehicleCode") String vehicleCode, @Param("prodSFCId") String prodSFCId,
              @Param("endEANumber") String endEANumber, @Param("isEnd") String isEnd,
              @Param("performStep") String performStep, @Param("createTime") String createTime,
              @Param("updateTime") String updateTime
    );

}
