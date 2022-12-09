package com.zimax.components.coframe.tools.tab;

/**
 * 授权管理Tab页
 *
 * @author 苏尚文
 * @date 2022/12/9 12:10
 */
public class TabPage {

    private String id;

    private String title;

    private String url;

    private int order;

    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public int getOrder() {
        return order;
    }

    public void setOrder(int order) {
        this.order = order;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }
}