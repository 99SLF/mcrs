package com.zimax.cap.auth;

import com.zimax.cap.party.Party;

import java.util.List;

/**
 * 授权池管理器接口
 */
public interface IAuthPoolManager {

    void addAuthResourceList(Party paramParty, List<AuthResource> paramList);

    void addOrUpdateAuthResource(Party paramParty, AuthResource paramAuthResource);

    void deleteAuthResourceList(Party paramParty);

    void deleteAuthResource(Party paramParty, AuthResource paramAuthResource);

    List<AuthResource> getAuthResourceList(Party paramParty);

    String getAuthResourceState(Party paramParty, String paramString1, String paramString2);
}
