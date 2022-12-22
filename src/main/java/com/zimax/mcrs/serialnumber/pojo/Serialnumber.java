package com.zimax.mcrs.serialnumber.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.apache.poi.hpsf.Decimal;

/**
 * @Author 施林丰
 * @Date:2022/12/19 15:33
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("base_coding_serialnumber")
public class Serialnumber {
    @TableId(type = IdType.AUTO)
    int id;
    String ruleName;
    Integer digit;
    Integer startvalue;
    Integer currentvalue;
    String note;
    String functionNum;
    String functionName;
    String numberRule;
    String numBasis;
    String titleRule;
}
