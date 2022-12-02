package com.zimax.cap.auth;

import java.io.Serializable;
import java.util.ArrayList;
import java.util.List;

/**
 * 菜单树
 *
 * @author 苏尚文
 * @date 2022/12/2 15:24
 */
public class MenuTree implements Serializable {

    private static final long serialVersionUID = -753501687176168110L;

    private List<MenuTreeNode> menuTreeRootNodeList;

    public MenuTree() {
        this.menuTreeRootNodeList = new ArrayList();
    }

    public void addMenuTreeRootNode(MenuTreeNode menuTreeNode) {
        this.menuTreeRootNodeList.add(menuTreeNode);
    }

    public List<MenuTreeNode> getMenuTreeRootNodeList() {
        return this.menuTreeRootNodeList;
    }

    /**
     * 菜单树节点
     *
     * @author 苏尚文
     * @date 2022/12/2 15:24
     */
    public static class MenuTreeNode implements Serializable {

        private static final long serialVersionUID = 7820591315402994494L;

        private List<MenuTreeNode> childrenMenuTreeNodeList = null;

        private transient MenuTreeNode parentMenuTreeNode;

        private long menuId;

        private String menuName;

        private String menuCode;

        private String imagePath;

        private String openMode;

        private String expandPath;

        private String linkType;

        private String linkResId;

        private String linkAction;

        public MenuTreeNode() {
        }

        public MenuTreeNode(long menuId, MenuTreeNode parentMenuTreeNode) {
            this.menuId = menuId;
            this.parentMenuTreeNode = parentMenuTreeNode;
            if (this.parentMenuTreeNode != null) {
                this.parentMenuTreeNode.addChildMenuTreeNode(this);
            }
        }

        public MenuTreeNode(long menuId, String menuName, String menuCode,
                            String imagePath, String openMode, String expandPath,
                            String linkType, String linkResId, String linkAction,
                            MenuTreeNode parentMenuTreeNode) {
            this(menuId, parentMenuTreeNode);
            this.menuName = menuName;
            this.menuCode = menuCode;
            this.imagePath = imagePath;
            this.openMode = openMode;
            this.expandPath = expandPath;
            this.linkType = linkType;
            this.linkResId = linkResId;
            this.linkAction = linkAction;
        }

        public void addChildMenuTreeNode(MenuTreeNode menuTreeNode) {
            if (this.childrenMenuTreeNodeList == null) {
                this.childrenMenuTreeNodeList = new ArrayList();
            }
            this.childrenMenuTreeNodeList.add(menuTreeNode);
        }

        public List<MenuTreeNode> getChildrenMenuTreeNodeList() {
            return this.childrenMenuTreeNodeList;
        }

        public String getExpandPath() {
            return this.expandPath;
        }

        public void setExpandPath(String expandPath) {
            this.expandPath = expandPath;
        }

        public String getImagePath() {
            return this.imagePath;
        }

        public void setImagePath(String imagePath) {
            this.imagePath = imagePath;
        }

        public String getLinkAction() {
            return this.linkAction;
        }

        public void setLinkAction(String linkAction) {
            this.linkAction = linkAction;
        }

        public String getLinkResId() {
            return this.linkResId;
        }

        public void setLinkResId(String linkResId) {
            this.linkResId = linkResId;
        }

        public String getLinkType() {
            return this.linkType;
        }

        public void setLinkType(String linkType) {
            this.linkType = linkType;
        }

        public String getMenuCode() {
            return this.menuCode;
        }

        public void setMenuCode(String menuCode) {
            this.menuCode = menuCode;
        }

        public long getMenuId() {
            return this.menuId;
        }

        public void setMenuId(long menuId) {
            this.menuId = menuId;
        }

        public String getMenuName() {
            return this.menuName;
        }

        public void setMenuName(String menuName) {
            this.menuName = menuName;
        }

        public String getOpenMode() {
            return this.openMode;
        }

        public void setOpenMode(String openMode) {
            this.openMode = openMode;
        }

        public MenuTreeNode getParentMenuTreeNode() {
            return this.parentMenuTreeNode;
        }

        public void setParentMenuTreeNode(MenuTreeNode parentMenuTreeNode) {
            this.parentMenuTreeNode = parentMenuTreeNode;
        }
    }
}
