package com.zimax.components.coframe.framework.pojo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/*import javax.persistence.JoinColumn;
import javax.persistence.ManyToMany;*/

/**
 * @Author 李伟杰
 * @Date: 2022/11/29/ 14:38
 * @Description
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
@TableName("app_menu")
public class Menu {

    /**
     * 菜单编号
     * 主键
     */
    @TableId(value = "menuId", type = IdType.AUTO)
    private String menuId;

    /**
     * 父菜单编号
     */
    private String parentMenuId;

    /**
     * 菜单名称
     */
    private String menuName;


    /**
     * 菜单显示名称
     */
    private String menuLabel;


    /**
     * 菜单代码
     */
    private String menuCode;


    /**
     * 是否叶子菜单
     */
    private String isLeaf;


    /**
     * 菜单url
     */
                    private String menuAction;


    /**
     * 菜单参数
     */
    private String parameter;


    /**
     * 菜单层次
     */
    private int  menuLevel;


    /**
     * 显示顺序
     */
    private int displayOrder;


    /**
     * 菜单闭合图片路径
     */
    private String imagePath;


    /**
     * 菜单展开图片路径
     */
    private String expandPath;


    /**
     * 菜单序号
     */
    private String menuSeq;


    /**
     * 打开方式
     */
    private String openMode;


    /**
     * 子菜单数
     */
    private int subCount;


    /**
     * 应用程序编号
     */
    private int appId;


    /**
     * 功能代码
     */
    private String funcCode;


    /**
     * 应用信息
     */
    private String appInfo;


    /**
     * 租户信息
     */
    private String tenantId;

//    /*@ManyToMany
//    @JoinColumn(name = "menu_id")*/
//    private Menu parentMenu;

}
