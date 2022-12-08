package com.zimax.cap.management.resource.manager;

import com.zimax.cap.management.resource.IResourceManagerService;
import com.zimax.cap.management.resource.impl.DefaultResourceManagerService;
import com.zimax.cap.utility.ServiceLoader;

import java.util.Iterator;

/**
 * @author 苏尚文
 * @date 2022/12/6 16:29
 */
public class ResourceManagerServiceLoader {

    private static IResourceManagerService currentResourceManagerService = null;

    public static IResourceManagerService getCurrentResourceManagerService() {
        if (currentResourceManagerService == null) {
            loadResourceManagerService();
        }
        if (currentResourceManagerService == null) {
            currentResourceManagerService = new DefaultResourceManagerService();
        }
        return currentResourceManagerService;
    }

    private static void loadResourceManagerService() {
        ServiceLoader<IResourceManagerService> loader = ServiceLoader
                .load(IResourceManagerService.class);

        Iterator<IResourceManagerService> it = loader.iterator();
        while (it.hasNext()) {
            IResourceManagerService resourceManagerService = (IResourceManagerService) it
                    .next();
            if ((currentResourceManagerService == null)
                    || (resourceManagerService.getOrder() < currentResourceManagerService
                    .getOrder())) {
                currentResourceManagerService = resourceManagerService;
            }
        }
    }
}
