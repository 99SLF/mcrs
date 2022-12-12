package com.zimax.cap.utility;

import java.util.Arrays;
import java.util.Collection;
import java.util.Iterator;
import java.util.Objects;

import com.baomidou.mybatisplus.core.toolkit.ArrayUtils;

/**
 * @author 苏尚文
 * @date 2022/12/10 14:41
 */
public final class ArrayUtil {
    public static String[] NULL_STRINGS = new String[0];
    public static Object[] NULL_OBJECTS = new Object[0];
    public static Class[] NULL_CLASSES = new Class[0];

    public static void copyArray(Object[] sourceObjects, Object[] targetObjects)
            throws IllegalArgumentException {
        if ((ArrayUtils.isEmpty(sourceObjects)) || (ArrayUtils.isEmpty(targetObjects))) {
            return;
        }
        if (sourceObjects.length != targetObjects.length) {
            throw new IllegalArgumentException("The length of the two arrays must be equal");
        }
        System.arraycopy(sourceObjects, 0, targetObjects, 0, targetObjects.length);
    }

    public static String[] getStringArrayValues(Object value) {
        if ((value instanceof Collection)) {
            String[] stringArray = new String[((Collection) value).size()];
            Iterator iterator = ((Collection) value).iterator();
            int index = 0;
            while (iterator.hasNext()) {
                Object t_Object = iterator.next();
                stringArray[index] = Objects.toString(t_Object, null);
                index++;
            }
            return stringArray;
        }
        if ((value instanceof Object[])) {
            Object[] objects = (Object[]) value;
            return getStringArrayValues(objects);
        }
        return NULL_STRINGS;
    }

    public static String[] getStringArrayValues(Object[] value) {
        if (ArrayUtils.isEmpty(value)) {
            return NULL_STRINGS;
        }
        String[] stringArray = new String[value.length];
        for (int i = 0; i < value.length; i++) {
            Object object = value[i];
            stringArray[i] = Objects.toString(object, null);
        }
        return stringArray;
    }

    public static Object[] getArrayValues(Object value) {
        if ((value instanceof Object[])) {
            return (Object[]) value;
        }
        if ((value instanceof Collection)) {
            return ((Collection) value).toArray();
        }
        return null;
    }

    public static boolean hasType(Object[] objects, Class clazz) {
        return hasType(objects, clazz, false);
    }

    public static boolean hasType(Object[] objects, Class clazz, boolean allowSuperType) {
        if (null == clazz) {
            return false;
        }
        if (ArrayUtils.isEmpty(objects)) {
            return false;
        }
        for (int i = 0; i < objects.length; i++) {
            Object object = objects[i];
            if (null != object) {
                if (allowSuperType) {
                    if (clazz.isAssignableFrom(object.getClass())) {
                        return true;
                    }
                } else if (clazz == object.getClass()) {
                    return true;
                }
            }
        }
        return false;
    }

    public static Object[] sort(Object[] array) {
        if (ArrayUtils.isEmpty(array)) {
            return array;
        }
        Arrays.sort(array);
        return array;
    }

    public static boolean isArray(Object r_Object) {
        if (null == r_Object) {
            return false;
        }
        Class t_Class = r_Object.getClass();
        return t_Class.isArray();
    }

    public static boolean isEmpty(Object[] array) {
        if ((array == null) || (array.length == 0)) {
            return true;
        }
        return false;
    }
}
