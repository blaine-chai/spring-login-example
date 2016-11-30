package com.blainechai.domain;

import org.eclipse.persistence.annotations.CascadeOnDelete;

import javax.persistence.*;

/**
 * Created by blainechai on 2016. 11. 23..
 */
@Entity
@Table(name = "user_group")
public class UserGroup {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "groupName", referencedColumnName = "groupName")
    private CommonGroupName groupName;


    @ManyToOne
    @JoinColumn(name = "userId", referencedColumnName = "userId")
    private UserAccount userAccount;

    protected UserGroup() {
    }

    public UserGroup(CommonGroupName commonGroupName, UserAccount userAccount) {
        this.groupName = commonGroupName;
        this.userAccount = userAccount;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public CommonGroupName getGroupName() {
        return groupName;
    }

    public void setGroupName(CommonGroupName groupName) {
        this.groupName = groupName;
    }

    public UserAccount getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(UserAccount userAccount) {
        this.userAccount = userAccount;
    }
}
