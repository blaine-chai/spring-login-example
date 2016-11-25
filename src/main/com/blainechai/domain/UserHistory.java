package com.blainechai.domain;

import javax.persistence.*;
import java.io.Serializable;

/**
 * Created by blainechai on 2016. 10. 16..
 */
@Entity
@Table(name = "user_history")
public class UserHistory implements Serializable{
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

    @ManyToOne
    @JoinColumn(name = "bookmarkId", referencedColumnName="id")
    private UserBookmark userBookmark;

    protected UserHistory() {
    }


    public UserHistory(UserAccount userAccount, String word, long date) {
        this.userAccount = userAccount;
        this.word = word;
        this.date = date;
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

    public UserBookmark getUserBookmark() {
        return userBookmark;
    }

    public void setUserBookmark(UserBookmark userBookmark) {
        this.userBookmark = userBookmark;
    }

    @Override
    public String toString() {
//        this.word
        return super.toString();
    }
}
