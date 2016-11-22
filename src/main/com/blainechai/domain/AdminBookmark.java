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

    @Column(length = 2048)
    private String word;

    private long date;

    protected AdminBookmark() {
    }


    public AdminBookmark(UserAccount adminAccount, String word, long date) {
        this.adminAccount = adminAccount;
        this.date = date;
        this.word = word;
    }

    public AdminBookmark(UserAccount adminAccount, String word) {
        this.adminAccount = adminAccount;
        this.word = word;
        this.date = new java.util.Date().getTime();
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
