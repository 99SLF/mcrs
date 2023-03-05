package com.zimax.mcrs.report.mapper;

import com.zimax.mcrs.report.pojo.Feeding;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import java.util.List;
import java.util.Map;

/**
 * 上料报表
 * @author 李伟杰
 * @date 2022/12/8 16:29
 */
@Mapper
public interface FeedingReportMapper {

    /**
     * 添加报表信息
     * @param feeding 报表信息
     * @return
     */
    void addFeeding(Feeding feeding);

    /**
     * 查询所有上料报表信息
     * @param
     * @return
     */
    List<Feeding> queryFeedings(Map map);

    /**
     * 查询记录数
     * @param
     * @return
     */
    int count(@Param("resource") String resource, @Param("axis") String axis,
              @Param("sfcPre") String sfcPre, @Param("processLotPre") String processLotPre,
              @Param("startTime") String startTime,
              @Param("endTime") String endTime
    );






}
