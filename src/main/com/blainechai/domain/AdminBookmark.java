package com.blainechai.domain;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by blainechai on 2016. 10. 16..
 */
@Entity
@Table(name = "admin_bookmark")
public class AdminBookmark implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "adminId", referencedColumnName = "userId")
    private UserAccount adminAccount;

    @ManyToOne
    @JoinColumn(name = "userId", referencedColumnName = "userId")
    private UserAccount userAccount;

    @ManyToOne
    @JoinColumn(name = "bookmarkId", referencedColumnName = "id")
    private AdminHistory adminHistory;
    private String word;

    private long date;

    private int count;

    protected AdminBookmark() {
    }


    public AdminBookmark(UserAccount userAccount, UserAccount adminAccount, AdminHistory adminHistory, String word, long date) {
        this.userAccount = userAccount;
        this.adminAccount = adminAccount;
        this.adminHistory = adminHistory;
        this.date = date;
        this.count = 0;
        this.word = word;
    }

    public AdminBookmark(UserAccount userAccount, UserAccount adminAccount,String word, AdminHistory adminHistory) {
        this.userAccount = userAccount;
        this.adminAccount = adminAccount;
        this.adminHistory = adminHistory;
        this.word = word;
        this.date = new java.util.Date().getTime();
        this.count = 0;
    }

    public UserAccount getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(UserAccount userAccount) {
        this.userAccount = userAccount;
    }

    public AdminHistory getAdminHistory() {
        return adminHistory;
    }

    public void setAdminHistory(AdminHistory adminHistory) {
        this.adminHistory = adminHistory;
    }

    public long getDate() {
        return date;
    }

    public void setDate(long date) {
        this.date = date;
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

    public UserAccount getAdminAccount() {
        return adminAccount;
    }

    public void setAdminAccount(UserAccount adminAccount) {
        this.adminAccount = adminAccount;
    }

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }

    @Override
    public String toString() {
//        this.word
        return super.toString();
    }
}
