package com.zimax.mcrs.systemFile.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.Date;

/**
 * @Author 施林丰
 * @Date:2023/1/13 16:33
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("system_file")
public class SystemFile {
    int fileId;
    String fileName;
    String version;
    String remark;
    String downloadPath;
    String creator;
    Date createTime;
}
