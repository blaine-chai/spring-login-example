package com.blainechai.model;

import com.blainechai.domain.UserAccount;
import com.blainechai.domain.UserGroup;

import java.sql.Date;
import java.util.ArrayList;
import java.util.List;

/**
 * Created by blainechai on 2016. 11. 23..
 */
public class UserAccountApi {
    private String userId;
    private String username;
    //    private String hash;
    private String phone;
    private Date createDate;
    private String type;
    private List<UserGroup> userGroups;

    public UserAccountApi(String userId, String username, String phone, Date createDate, String type, List<UserGroup> userGroups) {
        this.userId = userId;
        this.username = username;
        this.phone = phone;
        this.createDate = createDate;
        this.type = type;
        this.userGroups = userGroups;
    }

    public UserAccountApi(UserAccount userAccount, List<UserGroup> userGroup) {
        this.userId = userAccount.getUserId();
        this.username = userAccount.getUsername();
        this.phone = userAccount.getPhone();
        this.createDate = userAccount.getCreateDate();
        this.type = userAccount.getType();
        this.userGroups = userGroup;
    }

    public UserAccountApi(UserAccount userAccount) {
        this.userId = userAccount.getUserId();
        this.username = userAccount.getUsername();
        this.phone = userAccount.getPhone();
        this.createDate = userAccount.getCreateDate();
        this.type = userAccount.getType();
    }

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

//    public String getHash() {
//        return hash;
//    }
//
//    public void setHash(String hash) {
//        this.hash = hash;
//    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public List<UserGroup> getUserGroups() {
        return userGroups;
    }

    public void setUserGroups(List<UserGroup> userGroups) {
        this.userGroups = userGroups;
    }

    public boolean hasGroupName(String groupName) {
        for (UserGroup userGroup : userGroups) {
            if (groupName.equals(userGroup.getGroupName().getGroupName())) {
                return true;
            }
        }
        return false;
    }
}
