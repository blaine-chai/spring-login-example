package com.blainechai.domain;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by blainechai on 2016. 10. 16..
 */
@Entity
@Table(name = "user_bookmark")
public class UserBookmark implements Serializable{
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @ManyToOne
    @JoinColumn(name = "userId", referencedColumnName = "userId")
    private UserAccount userAccount;

    @Column(length = 2048)
    private String word;

    private long date;

    private int count;

    protected UserBookmark() {
    }


    public UserBookmark(UserAccount userAccount, String word, long date) {
        this.userAccount = userAccount;
        this.word = word;
        this.date = date;
        this.count = 0;
    }

    public UserBookmark(UserHistory userHistory){
        this.userAccount = userHistory.getUserAccount();
        this.word = userHistory.getWord();
        this.date = new java.util.Date().getTime();
        this.count = 0;
    }

    public UserAccount getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(UserAccount userAccount) {
        this.userAccount = userAccount;
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
