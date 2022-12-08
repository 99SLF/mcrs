package com.zimax.cap.management.resource;

/**
 * @author 苏尚文
 * @date 2022/12/6 16:26
 */
public interface IResourceChangeProvider {

    void addResourceChangeListener(IResourceChangeListener paramIResourceChangeListener);

    void removeResourceChangeListener(IResourceChangeListener paramIResourceChangeListener);

    void fireResourceChange(IResourceChangeEvent paramIResourceChangeEvent);

}
