package com.zimax.cap.party;

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;
import java.util.Objects;

/**
 * 参与者
 *
 * @author 苏尚文
 * @date 2022-12-02
 */
public class Party implements Serializable {

    private static final long serialVersionUID = 9216314978437651640L;

    /**
     * 参与者类型编号
     */
    private String partyTypeId;

    /**
     * 编号
     */
    private String id;

    /**
     * 编码
     */
    private String code;

    /**
     * 名称
     */
    private String name;

    /**
     * 扩展属性
     */
    private Map<String, String> extAttributes = new HashMap();

    /**
     * 构造一个新的参与者
     */
    public Party() {
    }

    /**
     * 构造一个新的参与者
     *
     * @param partyTypeId 参与者类型编号
     * @param id 编号
     * @param code 编码
     * @param name 名称
     */
    public Party(String partyTypeId, String id, String code, String name) {
        this.partyTypeId = partyTypeId;
        this.id = id;
        this.code = code;
        this.name = name;
    }

    /**
     * 添加扩展属性
     *
     * @param key 属性名
     * @param value 属性值
     */
    public void putExtAttribute(String key, String value) {
        this.extAttributes.put(key, value);
    }

    /**
     * 获取展属性值
     *
     * @param key 属性名
     * @return 属性值
     */
    public String getExtAttribute(String key) {
        return this.extAttributes.get(key);
    }

    /**
     * 获取参与者类型编号
     *
     * @return 参与者类型编号
     */
    public String getPartyTypeId() {
        return this.partyTypeId;
    }

    /**
     * 设置参与者类型编号
     *
     * @param partyTypeId 参与者类型编号
     */
    public void setPartyTypeID(String partyTypeId) {
        this.partyTypeId = partyTypeId;
    }

    /**
     * 获取编码
     *
     * @return 编码
     */
    public String getCode() {
        return this.code;
    }

    /**
     * 设置编码
     *
     * @param code 编码
     */
    public void setCode(String code) {
        this.code = code;
    }

    /**
     * 获取编号
     *
     * @return 编号
     */
    public String getId() {
        return this.id;
    }

    /**
     * 设置编号
     *
     * @param id 编号
     */
    public void setId(String id) {
        this.id = id;
    }

    /**
     * 获取名称
     *
     * @return 名称
     */
    public String getName() {
        return this.name;
    }

    /**
     * 设置名称
     *
     * @param name 名称
     */
    public void setName(String name) {
        this.name = name;
    }

    @Override
    public boolean equals(Object other) {
        Party otherNode = (Party) other;
        if ((Objects.equals(this.id, otherNode.id))
                && (Objects.equals(this.partyTypeId, this.partyTypeId))) {
            return true;
        }
        return false;
    }

    @Override
    public int hashCode() {
        int PRIME = 31;
        int result = 1;
        result = 31 * result + (this.id == null ? 0 : this.id.hashCode());
        result = 31 * result
                + (this.partyTypeId == null ? 0 : this.partyTypeId.hashCode());
        return result;
    }

}