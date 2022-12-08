package com.zimax.components.coframe.auth.menu;

import com.zimax.cap.auth.MenuTree.MenuTreeNode;

/**
 * 层次菜单树节点
 *
 * @author 苏尚文
 * @date 2022/12/6 15:09
 */
public class LevelMenuTreeNode extends MenuTreeNode {

    private static final long serialVersionUID = 1L;

    private int level;

    private String menuSeq;

    private String menuPrimeKey;

    private String functionCode;

    private int displayOrder;

    public String getFunctionCode() {
        return functionCode;
    }

    public void setFunctionCode(String functionCode) {
        this.functionCode = functionCode;
    }

    public int getLevel() {
        return level;
    }

    public void setLevel(int level) {
        this.level = level;
    }

    public String getMenuPrimeKey() {
        return menuPrimeKey;
    }

    public void setMenuPrimeKey(String menuPrimeKey) {
        this.menuPrimeKey = menuPrimeKey;
    }

    public String getMenuSeq() {
        return menuSeq;
    }

    public void setMenuSeq(String menuSeq) {
        this.menuSeq = menuSeq;
    }

    public int getDisplayOrder() {
        return displayOrder;
    }

    public void setDisplayOrder(int displayOrder) {
        this.displayOrder = displayOrder;
    }

}
