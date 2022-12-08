package com.zimax.cap.management.resource.util;

import com.zimax.cap.management.resource.IManagedResource;

import java.util.Comparator;

/**
 * @author 苏尚文
 * @date 2022/12/6 16:37
 */
public class ManagedResourceUtil {

    private static Comparator<IManagedResource> comparator = null;

    public static Comparator<IManagedResource> getComparator() {
        if (comparator == null) {
            comparator = new Comparator<IManagedResource>() {
                public int compare(IManagedResource o1, IManagedResource o2) {
                    int order1 = o1.getOrder();
                    int order2 = o2.getOrder();
                    if (order1 > order2) {
                        return 1;
                    }
                    if (order1 < order2) {
                        return -1;
                    }
                    return 0;
                }
            };
        }
        return comparator;
    }
}
