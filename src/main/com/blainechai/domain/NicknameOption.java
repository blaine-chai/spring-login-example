package com.blainechai.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;
import java.text.DateFormat;
import java.text.SimpleDateFormat;

@Entity
@Table(name = "common_nickname")
public class NicknameOption implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String author;
    private String nickname;
    private String lastModifiedDate = "";
    private String priority;
    private String note;

    public NicknameOption() {
    }

    public NicknameOption(String author, String nickname, String priority, String note) {
        this.author = author;
        this.nickname = nickname;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        this.lastModifiedDate = sdf.format(new java.util.Date());
        this.priority = priority;
        this.note = note;
    }

    public NicknameOption(String author, String nickname, String priority, String note, String userID) {
        this.author = author;
        this.nickname = nickname;
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        this.lastModifiedDate = sdf.format(new java.util.Date()) + "(" + userID + ")";;
        this.priority = priority;
        this.note = note;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getLastModifiedDate() {
        return lastModifiedDate;
    }

    public void setLastModifiedDate() {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        this.lastModifiedDate = sdf.format(new java.util.Date());
    }

    public void setLastModifiedDatePlusUserID(String userID) {
        if(this.lastModifiedDate.equals("")) {
    		this.lastModifiedDate += "(" + userID + ")";
    		//startModifiedDate = this.lastModifiedDate;
    	}
    	else {
            String[] s = this.lastModifiedDate.split("<br>");
            String startModifiedDate = s[s.length-1];
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    		this.lastModifiedDate = sdf.format(new java.util.Date()) + "(" + userID + ")<br>"
    				+ startModifiedDate;
    	}
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getNote() {
        return note;
    }

    public void setNote(String note) {
        this.note = note;
    }
}
