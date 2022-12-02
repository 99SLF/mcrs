package com.zimax.cap.party;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

/**
 * 参与者类型
 *
 * @author 苏尚文
 * @date 2022-12-02
 */
public class PartyType implements Serializable {

    private static final long serialVersionUID = -2166247623601619519L;

    /**
     * 类型编号
     */
    private String typeId;

    /**
     * 名称
     */
    private String name;

    /**
     * 描述
     */
    private String description;

    /**
     * 优先级
     */
    private int priority;

    /**
     * 16位图标
     */
    private String icon16path;

    /**
     * 32位图标
     */
    private String icon32path;

    /**
     * 显示根目录
     */
    private boolean showAtRoot;

    /**
     * 是否为叶子
     */
    private boolean isLeaf;

    /**
     * 是否为角色
     */
    private boolean isRole;

    /**
     * 在树中显示
     */
    private boolean showInTree;

    /**
     * 扩展属性
     */
    private Map<String, String> extAttributes = new HashMap();

    public void putExtAttribute(String key, String value) {
        this.extAttributes.put(key, value);
    }

    public String getExtAttribute(String key) {
        return (String) this.extAttributes.get(key);
    }

    public String getDescription() {
        return this.description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getIcon16path() {
        return this.icon16path;
    }

    public void setIcon16path(String icon16path) {
        this.icon16path = icon16path;
    }

    public String getIcon32path() {
        return this.icon32path;
    }

    public void setIcon32path(String icon32path) {
        this.icon32path = icon32path;
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getPriority() {
        return this.priority;
    }

    public void setPriority(int priority) {
        this.priority = priority;
    }

    public String getTypeId() {
        return this.typeId;
    }

    public void setTypeId(String typeId) {
        this.typeId = typeId;
    }

    public boolean isLeaf() {
        return this.isLeaf;
    }

    public void setLeaf(boolean isLeaf) {
        this.isLeaf = isLeaf;
    }

    public boolean isRole() {
        return this.isRole;
    }

    public void setRole(boolean isRole) {
        this.isRole = isRole;
    }

    public boolean isShowAtRoot() {
        return this.showAtRoot;
    }

    public void setShowAtRoot(boolean showAtRoot) {
        this.showAtRoot = showAtRoot;
    }

    public boolean isShowInTree() {
        return this.showInTree;
    }

    public void setShowInTree(boolean showInTree) {
        this.showInTree = showInTree;
    }
}
