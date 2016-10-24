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

//    @ManyToOne
//    @JoinColumn(name = "userId", referencedColumnName = "userId")
//    private UserAccount userAccount;

    private String word;
    private long date;

    protected AdminHistory() {
    }

    public AdminHistory(String word, long date) {
        this.word = word;
        this.date = date;
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

    @Override
    public String toString() {
//        this.word
        return super.toString();
    }
}
