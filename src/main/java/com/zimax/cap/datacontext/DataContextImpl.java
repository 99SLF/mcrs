package com.zimax.cap.datacontext;

import java.lang.reflect.Array;
import java.util.Collection;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * 数据环境实现类
 *
 * @author 苏尚文
 * @date 2022/12/6 10:17
 */
public class DataContextImpl extends BaseDataContextImpl implements
        IDataContext {

    private static final long serialVersionUID = -803859980594982982L;

    public DataContextImpl() {
    }

    private static void assertNotEmpty(String xpath) {
        if ((xpath == null) || (xpath.trim().equals(""))) {
            throw new IllegalArgumentException("xpath is [" + xpath + "]!");
        }
    }

    public DataContextImpl(String name, Object object) {
        setName(name);
        this.rootObject = object;
    }

//    public BigDecimal getBigDecimal(String xpath) {
//        return DataUtil.toBigDecimal(get(xpath));
//    }

//    public BigInteger getBigInteger(String xpath) {
//        return DataUtil.toBigInteger(get(xpath));
//    }

//    public boolean getBoolean(String xpath) {
//        return DataUtil.toBoolean(get(xpath));
//    }

//    public byte getByte(String xpath) {
//        return DataUtil.toByte(get(xpath));
//    }

//    public byte[] getBytes(String xpath) {
//        return DataUtil.toBytes(get(xpath));
//    }

//    public char getChar(String xpath) {
//        return DataUtil.toChar(get(xpath));
//    }

//    public DataObject getDataObject(String xpath) {
//        return DataUtil.toDataObject(get(xpath));
//    }

//    public Date getDate(String xpath) {
//        return DataUtil.toDate(get(xpath));
//    }
//
//    public double getDouble(String xpath) {
//        return DataUtil.toDouble(get(xpath));
//    }
//
//    public float getFloat(String xpath) {
//        return DataUtil.toFloat(get(xpath));
//    }
//
//    public int getInt(String xpath) {
//        return DataUtil.toInt(get(xpath));
//    }
//
//    @SuppressWarnings("unchecked")
//    public List<Object> getList(String xpath) {
//        return DataUtil.toList(get(xpath));
//    }
//
//    public long getLong(String xpath) {
//        return DataUtil.toLong(get(xpath));
//    }
//
//    public short getShort(String xpath) {
//        return DataUtil.toShort(get(xpath));
//    }
//
//    public String getString(String xpath) {
//        return DataUtil.toString(get(xpath));
//    }
//
//    public boolean isEmpty(String xpath) {
//        Object o = get(xpath);
//        if ((o instanceof String)) {
//            String s = (String) o;
//            return "".equals(s.trim());
//        }
//        if ((o instanceof Collection)) {
//            return ((Collection<?>) o).isEmpty();
//        }
//        if ((o instanceof Map)) {
//            return ((Map<?, ?>) o).isEmpty();
//        }
//        if (o.getClass().isArray()) {
//            return Array.getLength(o) == 0;
//        }
//        return false;
//    }
//
//    public boolean isNull(String xpath) {
//        return null == get(xpath);
//    }
//
//    public boolean isExist(String xpath) {
//        assertNotEmpty(xpath);
//        try {
//            get(xpath);
//        } catch (IllegalArgumentException e) {
//            return false;
//        }
//        return true;
//    }
//
//    public void setBigDecimal(String xpath, Object bigdecimal) {
//        set(xpath, DataUtil.toBigDecimal(bigdecimal));
//    }
//
//    public void setBigInteger(String xpath, Object biginteger) {
//        set(xpath, DataUtil.toBigInteger(biginteger));
//    }
//
//    public void setBoolean(String xpath, Object flag) {
//        set(xpath, Boolean.valueOf(DataUtil.toBoolean(flag)));
//    }
//
//    public void setByte(String xpath, Object byte0) {
//        set(xpath, Byte.valueOf(DataUtil.toByte(byte0)));
//    }
//
//    public void setBytes(String xpath, Object abyte0) {
//        set(xpath, DataUtil.toBytes(abyte0));
//    }
//
//    public void setChar(String xpath, Object c) {
//        set(xpath, Character.valueOf(DataUtil.toChar(c)));
//    }
//
//    public void setDataObject(String xpath, Object obj) {
//        set(xpath, DataUtil.toDataObject(obj));
//    }
//
//    public void setDate(String xpath, Object date) {
//        set(xpath, DataUtil.toDate(date));
//    }
//
//    public void setDouble(String xpath, Object d) {
//        set(xpath, Double.valueOf(DataUtil.toDouble(d)));
//    }
//
//    public void setFloat(String xpath, Object f) {
//        set(xpath, Float.valueOf(DataUtil.toFloat(f)));
//    }
//
//    public void setInt(String xpath, Object i) {
//        set(xpath, Integer.valueOf(DataUtil.toInt(i)));
//    }
//
//    public void setList(String xpath, Object list) {
//        set(xpath, DataUtil.toList(list));
//    }
//
//    public void setLong(String xpath, Object l) {
//        set(xpath, Long.valueOf(DataUtil.toLong(l)));
//    }
//
//    public void setNull(String xpath) {
//        set(xpath, null);
//    }
//
//    public void setShort(String xpath, Object s) {
//        set(xpath, Short.valueOf(DataUtil.toShort(s)));
//    }
//
//    public void setString(String xpath, Object s) {
//        set(xpath, DataUtil.toString(s));
//    }
}
