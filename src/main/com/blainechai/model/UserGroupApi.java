package com.blainechai.model;

/**
 * Created by blainechai on 2016. 12. 27..
 */
public class UserGroupApi {

    private String groupName;
    private String groupId;

//    public UserGroupApi() {
//    }

    public UserGroupApi(String groupName, String groupId) {
        this.groupName = groupName;
        this.groupId = groupId;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }
}
