package com.blainechai.domain;

import javax.persistence.*;

/**
 * Created by blainechai on 2016. 11. 23..
 */
@Entity
@Table(name = "common_group_name")
public class CommonGroupName {
    private static final long serialVersionUID = 1L;

    @Id
    private String groupName;

    protected CommonGroupName() {
    }

    public CommonGroupName(String groupName) {
        this.groupName = groupName;
    }


    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }
}
