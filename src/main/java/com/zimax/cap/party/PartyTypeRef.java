package com.zimax.cap.party;

/**
 * 参与都类型引用
 *
 * @author 苏尚文
 * @date 2022/12/2 16:56
 */

import java.io.Serializable;
import java.util.HashMap;
import java.util.Map;

public class PartyTypeRef implements Serializable {

    private static final long serialVersionUID = -1849693503741281360L;

    public static String PARENT_CHILD_REF_TYPE = "p_c";

    public static String ROLE_PARTY_REF_TYPE = "r_p";

    private String refId;

    private String refName;

    private String refType;

    private PartyType childPartyType;

    private PartyType parentPartyType;

    private Map<String, String> extAttributes = new HashMap();

    public void putExtAttribute(String key, String value) {
        this.extAttributes.put(key, value);
    }

    public String getExtAttribute(String key) {
        return (String) this.extAttributes.get(key);
    }

    public String getRefType() {
        return this.refType;
    }

    public void setRefType(String refType) {
        this.refType = refType;
    }

    public PartyType getChildPartyType() {
        return this.childPartyType;
    }

    public void setChildPartyType(PartyType childPartyType) {
        this.childPartyType = childPartyType;
    }

    public PartyType getParentPartyType() {
        return this.parentPartyType;
    }

    public void setParentPartyType(PartyType parentPartyType) {
        this.parentPartyType = parentPartyType;
    }

    public String getRefId() {
        return this.refId;
    }

    public void setRefId(String refId) {
        this.refId = refId;
    }

    public String getRefName() {
        return this.refName;
    }

    public void setRefName(String refName) {
        this.refName = refName;
    }
}
