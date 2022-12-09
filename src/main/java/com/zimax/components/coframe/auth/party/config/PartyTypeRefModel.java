package com.zimax.components.coframe.auth.party.config;

import java.io.Serializable;
import java.util.Properties;

/**
 * @author 苏尚文
 * @date 2022/12/8 18:47
 */
public class PartyTypeRefModel implements Serializable {

    private static final long serialVersionUID = 4917953390194747413L;

    private String refID;

    private String refName;

    private String refType;

    private String partyTypeRefDataService;

    private String parentPartyTypeID;

    private String childPartyTypeID;

//	private TenantModel tenant = null;

    private Properties extProperties = new Properties();

    public void addExtProperty(String key, String value){
        extProperties.put(key, value);
    }

    public Properties getExtProperties(){
        return this.extProperties;
    }

    public String getRefType() {
        return refType;
    }

    public void setRefType(String refType) {
        this.refType = refType;
    }

    public String getChildPartyTypeID() {
        return childPartyTypeID;
    }

    public void setChildPartyTypeID(String childPartyTypeID) {
        this.childPartyTypeID = childPartyTypeID;
    }

    public String getParentPartyTypeID() {
        return parentPartyTypeID;
    }

    public void setParentPartyTypeID(String parentPartyTypeID) {
        this.parentPartyTypeID = parentPartyTypeID;
    }

    public String getPartyTypeRefDataService() {
        return partyTypeRefDataService;
    }

    public void setPartyTypeRefDataService(String partyTypeRefDataService) {
        this.partyTypeRefDataService = partyTypeRefDataService;
    }

    public String getRefID() {
        return refID;
    }

    public void setRefID(String refID) {
        this.refID = refID;
    }

    public String getRefName() {
        return refName;
    }

    public void setRefName(String refName) {
        this.refName = refName;
    }

//	public TenantModel getTenant() {
//		return tenant;
//	}
//
//	public void setTenant(TenantModel tenant) {
//		this.tenant = tenant;
//	}

}