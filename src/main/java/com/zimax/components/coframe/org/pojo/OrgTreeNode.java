package com.zimax.components.coframe.org.pojo;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author 施林丰
 * @Date:2023/2/11 17:28
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrgTreeNode {
    String nodeId;
    String nodeType;
    String nodeName;
    String iconCls;
}
