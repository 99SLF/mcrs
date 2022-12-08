package com.zimax.cap.management.resource.manager;

import com.zimax.cap.management.resource.IManagedResource;
import com.zimax.cap.management.resource.IResourceChangeEvent;
import com.zimax.cap.management.resource.IResourceChangeListener;
import com.zimax.cap.management.resource.IResourceChangeProvider;
import com.zimax.cap.management.resource.impl.DefaultResourceChangeEvent;
import com.zimax.cap.management.resource.impl.ResourceRuntimeException;
import com.zimax.cap.utility.StringUtil;

import java.util.ArrayList;
import java.util.List;

/**
 * @author 苏尚文
 * @date 2022/12/6 16:25
 */
public class ResourceRuntimeManager implements IResourceChangeProvider {

    private static ResourceRuntimeManager instance = null;

    private List<IResourceChangeListener> listenerList = new ArrayList();

    public static ResourceRuntimeManager getInstance() {
        if (instance == null) {
            instance = new ResourceRuntimeManager();
        }
        return instance;
    }

    public void registerManagedResource(IManagedResource managedResource) {
        if (managedResource != null) {
            ResourceManagerServiceLoader.getCurrentResourceManagerService()
                    .registerManagedResource(managedResource);

            IResourceChangeEvent resourceChangeEvent = new DefaultResourceChangeEvent(
                    1, null, managedResource);

            fireResourceChange(resourceChangeEvent);
        } else {
            throw new ResourceRuntimeException("CAP_04110010");
        }
    }

    public void unRegisterManagedResource(String resourceID, String resourceType) {
        if (StringUtil.isEmpty(resourceID)) {
            throw new ResourceRuntimeException("CAP_04110011");
        }
        if (StringUtil.isEmpty(resourceType)) {
            throw new ResourceRuntimeException("CAP_04110012");
        }
        IManagedResource oldManagedResource = ResourceManagerServiceLoader
                .getCurrentResourceManagerService().unRegisterManagedResource(
                        resourceID, resourceType);

        IResourceChangeEvent resourceChangeEvent = new DefaultResourceChangeEvent(
                2, oldManagedResource, null);

        fireResourceChange(resourceChangeEvent);
    }

    public void updateRegisteredManagedResource(IManagedResource managedResource) {
        if (managedResource != null) {
            IManagedResource oldManagedResource = ResourceManagerServiceLoader
                    .getCurrentResourceManagerService()
                    .unRegisterManagedResource(managedResource.getResourceID(),
                            managedResource.getResourceType());

            ResourceManagerServiceLoader.getCurrentResourceManagerService()
                    .registerManagedResource(managedResource);

            IResourceChangeEvent resourceChangeEvent = new DefaultResourceChangeEvent(
                    3, oldManagedResource, managedResource);

            fireResourceChange(resourceChangeEvent);
        } else {
            throw new ResourceRuntimeException("CAP_04110013");
        }
    }

    public IManagedResource getManagedResource(String[] resourceID,
                                               String[] resourceType) {
        return ResourceManagerServiceLoader.getCurrentResourceManagerService()
                .getManagedResource(resourceID, resourceType);
    }

    public IManagedResource getManagedResource(String resourceID,
                                               String resourceType) {
        String[] xpath = getManagedResourceXpath(resourceID, resourceType);
        if (xpath != null) {
            return getInstance().getManagedResource(xpath[0].split("/"),
                    xpath[1].split("/"));
        }
        return null;
    }

    public List<IManagedResource> getRootManagedResourceListByType(
            String resourceType) {
        return ResourceManagerServiceLoader.getCurrentResourceManagerService()
                .getRootManagedResourceListByType(resourceType);
    }

    public List<IManagedResource> getChildrenManagedResourceList(
            String[] resourceID, String[] resourceType) {
        return ResourceManagerServiceLoader.getCurrentResourceManagerService()
                .getChildrenManagedResourceList(resourceID, resourceType);
    }

    public List<IManagedResource> getChildrenManagedResourceOfTypeList(
            String[] resourceID, String[] resourceType) {
        return ResourceManagerServiceLoader.getCurrentResourceManagerService()
                .getChildrenManagedResourceOfTypeList(resourceID, resourceType);
    }

    public String[] getManagedResourceXpath(String resourceID,
                                            String resourceType) {
        return ResourceManagerServiceLoader.getCurrentResourceManagerService()
                .getManagedResourceXpath(resourceID, resourceType);
    }

    public void addResourceChangeListener(
            IResourceChangeListener resourceChangeListener) {
        this.listenerList.add(resourceChangeListener);
    }

    public void fireResourceChange(IResourceChangeEvent resourceChangeEvent) {
        for (IResourceChangeListener listener : this.listenerList) {
            listener.resourceChanged(resourceChangeEvent);
        }
    }

    public void removeResourceChangeListener(
            IResourceChangeListener resourceChangeListener) {
        this.listenerList.remove(resourceChangeListener);
    }
}
