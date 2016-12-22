package com.blainechai.domain;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by blainechai on 2016. 12. 22..
 */

@Entity
@Table(name = "common_group_map")
public class CommonGroupMap implements Serializable {
    private static final long serialVersionUID = 1L;


    @Id
    private String groupId;

    @OneToOne
    @JoinColumn(name = "groupNameId")
    private CommonGroupName groupName;

    protected CommonGroupMap() {
    }

    public CommonGroupMap(String groupId, CommonGroupName groupName) {
        this.groupId = groupId;
        this.groupName = groupName;
    }

    public String getGroupId() {
        return groupId;
    }

    public void setGroupId(String groupId) {
        this.groupId = groupId;
    }

    public CommonGroupName getGroupName() {
        return groupName;
    }

    public void setGroupName(CommonGroupName groupName) {
        this.groupName = groupName;
    }
}
