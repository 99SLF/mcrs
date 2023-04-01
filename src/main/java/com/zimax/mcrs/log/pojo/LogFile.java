package com.zimax.mcrs.log.pojo;

import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Author 施林丰
 * @Date:2023/3/31 14:13
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("log_file")
public class LogFile {
  int id;
  //设备资源号
  String equipmentId;
  //日志生成日期
  String logTime;
  //日志类型
  String logType;
  //日志文件名字
  String logFileName;
  //文件保存在服务器路径
    String filePath;
    //uuid唯一识别号
    String  fileUuid;
    //文件尺寸
    double fileSize;
    Date createTime;
    @TableField(exist = false)
    String equipmentName;
  @TableField(exist = false)
  String equipmentIp;
  @TableField(exist = false)
  int port;
}
