package com.zimax.components.coframe.org.pojo.vo;

import com.zimax.components.coframe.org.pojo.Organization;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @Author 施林丰
 * @Date:2023/2/9 11:54
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class OrganizationDelVo {
    Organization organization[];
    String parentId;
    String parentType;
    String isDeleteCascade;
}
