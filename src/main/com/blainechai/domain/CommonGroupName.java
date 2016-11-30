package com.blainechai.domain;

import org.eclipse.persistence.annotations.CascadeOnDelete;

import javax.persistence.*;
import java.util.ArrayList;
import java.util.Collection;
import java.util.List;

/**
 * Created by blainechai on 2016. 11. 23..
 */
@Entity
@Table(name = "common_group_name")
public class CommonGroupName {
    private static final long serialVersionUID = 1L;


    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String groupName;

    @OneToMany(fetch=FetchType.EAGER, cascade = CascadeType.ALL)
    @JoinColumn(name="groupName")
    private List<UserGroup> userGroup;

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

    public Collection<UserGroup> getUserGroup() {
        return userGroup;
    }

    public void setUserGroup(List<UserGroup> userGroup) {
        this.userGroup = userGroup;
    }

    public void addUserGroup(UserGroup userGroup){
        if(userGroup ==null){
            this.userGroup = new ArrayList<UserGroup>();
        }
        this.userGroup.add(userGroup);
    }
}
