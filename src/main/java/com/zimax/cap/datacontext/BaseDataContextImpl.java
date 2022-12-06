package com.zimax.cap.datacontext;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.lang.reflect.Method;
import java.util.HashMap;
import java.util.Map;

/**
 * 基础数据环境实现类
 *
 * @author 苏尚文
 * @date 2022/12/6 10:20
 */
public abstract class BaseDataContextImpl implements IBaseDataContext {

    private static final long serialVersionUID = 5292663495594321983L;

    private String name;

    private String type;

    protected Object rootObject = null;

    protected IDataContext parentContext = null;

    protected boolean autoCreateNonexistPath = true;

    public Object clone() throws CloneNotSupportedException {
        BaseDataContextImpl ret = (BaseDataContextImpl) super.clone();
        try {
            ret.rootObject = serializeClone();
            return ret;
        } catch (Throwable e) {
//            try {
//                if (DataObject.class.isAssignableFrom(this.rootObject
//                        .getClass())) {
//                    ret.rootObject = ExtendedCopyHelper.eINSTANCE
//                            .copy((DataObject) this.rootObject);
//                } else {
//                    Method m = this.rootObject.getClass().getDeclaredMethod(
//                            "clone", new Class[0]);
//
//                    ret.rootObject = m.invoke(this.rootObject, new Object[0]);
//                }
//            } catch (Exception e1) {
//                try {
////                    ret.rootObject = BeanUtils.cloneBean(ret.rootObject);
//                } catch (Exception e2) {
//                    e2.printStackTrace();
//                    e.printStackTrace();
//                    throw new CloneNotSupportedException();
//                }
//            }
        }
        return ret;
    }

    private Object serializeClone() throws Exception {
        ObjectOutputStream out = null;
        ObjectInputStream in = null;
        try {
            ByteArrayOutputStream baos = new ByteArrayOutputStream(4096);
            out = new ObjectOutputStream(baos);
            out.writeObject(this.rootObject);
            out.flush();
            byte[] results = baos.toByteArray();
            ByteArrayInputStream bais = new ByteArrayInputStream(results);
            in = new ObjectInputStream(bais);
            Object o = in.readObject();
            return o;
        } finally {
            if (out != null) {
                try {
                    out.close();
                } catch (Throwable e) {
                    e.printStackTrace();
                }
            }
            if (in != null) {
                try {
                    in.close();
                } catch (Throwable e) {
                    e.printStackTrace();
                }
            }
        }
    }

    private IDataContext clone(String xpath, boolean lenient)
            throws CloneNotSupportedException {
        IDataContext ctx = subContext(xpath);
        if (null == ctx) {
            return null;
        }
        return (IDataContext) ctx.clone();
    }

    public IDataContext clone(String xpath) throws CloneNotSupportedException {
        return clone(xpath, true);
    }

    public IDataContext subContext(String xpath) {
//        BaseDataContextImpl ctx = (BaseDataContextImpl) DataContextFactory
//                .create(get(xpath));
//        if (null == ctx) {
//            return null;
//        }
//        ctx.parentContext = ((IDataContext) this);
//        ctx.autoCreateNonexistPath = this.autoCreateNonexistPath;
//        return (IDataContext) ctx;
        return null;
    }

    public IDataContext root() {
        BaseDataContextImpl root = (BaseDataContextImpl) this.parentContext;
        while (null != root.parentContext) {
            root = (BaseDataContextImpl) root.parentContext;
        }
        return (IDataContext) root;
    }

    public void setParentContext(IDataContext parent) {
        this.parentContext = parent;
    }

    public IDataContext getParentContext() {
        return this.parentContext;
    }

//    public Object createObject(String xpath, Class<?> clazz) {
//        try {
//            Object ret = clazz.newInstance();
//            getXPathLocator().setValue(this.rootObject, xpath, ret);
//            writeRootObject(xpath, false);
//            return ret;
//        } catch (Exception e) {
//            throw new DataContextOperationException(e);
//        }
//    }

    public void writeRootObject(String xpath, boolean delete) {
    }

    public void readRootObject(String xpath) {
    }

//    public DataObject createObject(String xpath, Type type) {
//        try {
//            DataObject ret = DataFactory.INSTANCE.create(type);
//            getXPathLocator().setValue(this.rootObject, xpath, ret);
//            writeRootObject(xpath, false);
//            return ret;
//        } catch (Exception e) {
//            throw new DataContextOperationException(e);
//        }
//    }

//    public void deleteObject(String xpath) {
//        getXPathLocator().deleteValue(this.rootObject, xpath);
//        writeRootObject(xpath, true);
//    }

    public Object get(String xpath) {
        try {
//            Object result = getXPathLocator().getValue(this.rootObject, xpath);
//            readRootObject(xpath);
            Object result = null;
            return result;
        } catch (Exception e) {
            throw new IllegalArgumentException(e);
        }
    }

//    public Object get(String xpath, Class<?> targetClass) {
//        try {
//            Object o = get(xpath);
//            return DataUtil.toType(targetClass, o);
//        } catch (Exception e) {
//            throw new IllegalArgumentException(e);
//        }
//    }

    public void set(String xpath, Object value) {
        try {
//            getXPathLocator().setValue(this.rootObject, xpath, value,
//                    this.autoCreateNonexistPath);
            writeRootObject(xpath, false);
        } catch (Exception e) {
            throw new IllegalArgumentException(e);
        }
    }

    public void set(String xpath, Object obj, Class<?> targetType) {
//        Object o = null;
//        try {
//            o = DataUtil.toType(targetType, obj);
//        } catch (Exception e) {
//            o = null;
//        }
//        if (null == o) {
//            o = obj;
//        }
//        set(xpath, o);
    }

    public void add(String xpath, Object obj) {
//        try {
//            getXPathLocator().addValue(this.rootObject, xpath, obj);
//            writeRootObject(xpath, false);
//        } catch (Exception e) {
//            throw new IllegalArgumentException(e);
//        }
    }

    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Object getRootObject() {
        return this.rootObject;
    }

    public void setRootObject(Object rootObject) {
        this.rootObject = rootObject;
    }

    public String toString() {
//        if (null != this.rootObject) {
//            try {
//                return new XMLSerializer().marshallToString(this.rootObject);
//            } catch (Exception e) {
//                e.printStackTrace();
//                return super.toString();
//            }
//        }
        return super.toString();
    }

    private Map<String, String> typeMappings = new HashMap<String, String>();

    public void setTypeMappings(Map<String, String> mappings) {
        this.typeMappings = mappings;
    }

    public Map<String, String> getTypeMappings() {
        return this.typeMappings;
    }

    public void addTypeMapping(String key, String value) {
        this.typeMappings.put(key, value);
    }

//    @SuppressWarnings("deprecation")
//    private XPathLocator getXPathLocator() {
//        XPathLocator locator = XPathLocator.getInstance();
//        locator.setTypeMappings(this.typeMappings);
//        return locator;
//    }

    public String getType() {
        return this.type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String directionalMarshall() {
        if (null != this.rootObject) {
//            try {
//                ExtendedXMLSerializer serializer = new ExtendedXMLSerializer();
//                SerializeOption operation = new SerializeOption();
//                operation.setCreateOuterCollectionNode(true);
//                serializer.setOption(operation);
//                return serializer.marshallToString(this.rootObject);
//            } catch (Exception e) {
//                ExtendedXMLSerializer serializer = new ExtendedXMLSerializer();
//                SerializeOption operation = new SerializeOption();
//                operation.setCreateOuterCollectionNode(true);
//                serializer.setOption(operation);
//                Map<String, Object> map = new HashMap<String, Object>();
//                map.put("__exception", e.getMessage());
//                map.put("__stack", e.getStackTrace());
//                return serializer.marshallToString(map);
//            }
        }
        return super.toString();
    }
}
