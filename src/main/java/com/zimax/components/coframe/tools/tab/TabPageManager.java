package com.zimax.components.coframe.tools.tab;

import java.util.*;

/**
 * Tab页管理
 *
 * @author 苏尚文
 * @date 2022/12/9 12:08
 */
public class TabPageManager {

    public static final TabPageManager INSTANCE = new TabPageManager();

    private Map<String, Map<String, TabPage>> tabPageMap = new HashMap<String, Map<String, TabPage>>();

    private TabPageManager() {
    }

    /**
     * 根据类型获取tab页模型
     *
     * @param type
     * @return
     */
    @SuppressWarnings("unchecked")
    public List<TabPage> getTabPageList(String type) {
        Map<String, TabPage> pageMap = tabPageMap.get(type);
        if (pageMap != null) {

            List<TabPage> pages = new ArrayList<TabPage>();
            for (TabPage page : pageMap.values()) {
                pages.add(page);
            }
            Collections.sort(pages, new Comparator<TabPage>() {

                public int compare(TabPage page1, TabPage page2) {
                    return page1.getOrder() - page2.getOrder();
                }
            });
            return pages;
        } else {
            return Collections.EMPTY_LIST;
        }
    }

    /**
     * 添加tab页模型
     *
     * @param type
     * @param page
     */
    public void addTabPage(String type, TabPage page) {
        Map<String, TabPage> pageMap = tabPageMap.get(type);
        if (pageMap == null) {
            pageMap = new HashMap<String, TabPage>();
            tabPageMap.put(type, pageMap);
        }
        pageMap.put(page.getId(), page);

    }

    public void unloadTabPage(String type, String groupName) {
        Map<String, TabPage> pageMap = tabPageMap.get(type);
        if (pageMap != null && pageMap.containsKey(groupName) == true) {
            pageMap.remove(groupName);
        }
    }

}