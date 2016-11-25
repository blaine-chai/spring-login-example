package com.blainechai.domain;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by blainechai on 2016. 10. 16..
 */
@Entity
@Table(name = "admin_history")
public class AdminHistory implements Serializable{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "userId", referencedColumnName = "userId")
    private UserAccount adminAccount;

    @Column(length = 2048)
    private String word;
    private long date;

    @ManyToOne
    @JoinColumn(name = "bookmarkId", referencedColumnName="id")
    private AdminBookmark adminBookmark;

    protected AdminHistory() {
    }


    public AdminHistory(UserAccount adminAccount, String word, long date) {
        this.adminAccount = adminAccount;
        this.word = word;
        this.date = date;
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

    public long getDate() {
        return date;
    }

    public void setDate(long date) {
        this.date = date;
    }

    public AdminBookmark getAdminBookmark() {
        return adminBookmark;
    }

    public void setAdminBookmark(AdminBookmark adminBookmark) {
        this.adminBookmark = adminBookmark;
    }

    @Override
    public String toString() {
//        this.word
        return super.toString();
    }
}
