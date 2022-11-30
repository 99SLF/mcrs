package com.zimax.mcrs.framework.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import lombok.Data;

/*import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;*/

/**
 * @Author 李伟杰
 * @Date: 2022/11/29/ 14:38
 * @Description
 */
@Data
public class Menu {

    //菜单编号
    //主键
    @TableId(value = "menuId",type = IdType.AUTO)
    private String menuId;

    //菜单名称
    private String menuName;

    //菜单显示名称
    private String menuLabel;

    //菜单代码
    private String menuCode;

    //是否叶子菜单
    private String isLeaf;

    //菜单url
    private String menuAction;

    //菜单参数
    private String parameter;

    //uiEntry
    private String uiEntry;

    //菜单层次
    private String menuLevel;

    //rootId
    private String rootId;

    //父菜单id
    private String parentsId;

    //显示顺序
    private String displayOrder;

    //菜单闭合图片路径
    private String imagePath;

    //菜单展开图片路径
    private String expandPath;

    //菜单序号
    private String menuSeq;

    //打开方式
    private String openMode;

    //子菜单数
    private String subCount;

    //应用程序编号
    private String appId;

    //功能代码
    private String funcCode;

    //应用信息
    private String app_id;

    //租户信息
    private String tenant_id;

    /*@ManyToMany
    @JoinColumn(name = "menu_id")*/
    private Menu parentMenu;

}
