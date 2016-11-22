package com.blainechai.domain;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by blainechai on 2016. 11. 22..
 */

@Entity
@Table(name = "common_bookmark")
public class CommonBookmark implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "userId", referencedColumnName = "userId")
    private UserAccount userAccount;

    @ManyToOne
    @JoinColumn(name = "adminBookmarkId", referencedColumnName = "id")
    private AdminBookmark adminBookmark;

    private int count;

    protected CommonBookmark() {
    }


    public CommonBookmark(UserAccount userAccount, AdminBookmark adminBookmark, int count) {
        this.userAccount = userAccount;
        this.adminBookmark = adminBookmark;
        this.count = count;
    }

    public AdminBookmark getAdminBookmark() {
        return adminBookmark;
    }

    public void setAdminBookmark(AdminBookmark adminBookmark) {
        this.adminBookmark = adminBookmark;
    }

    public UserAccount getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(UserAccount userAccount) {
        this.userAccount = userAccount;
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    @Override
    public String toString() {
//        this.word
        return super.toString();
    }
}
