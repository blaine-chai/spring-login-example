package com.blainechai.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;

@Entity
@Table(name = "common_nickname")
public class NicknameOption implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String author;
    private String nickname;
    private Long lastModifiedDate;
    private String priority;
    private String note;

    public NicknameOption() {
    }

    public NicknameOption(String author, String nickname, Long lastModifiedDate, String priority, String note) {
        this.author = author;
        this.nickname = nickname;
        this.lastModifiedDate = lastModifiedDate;
        this.priority = priority;
        this.note = note;
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

    public Long getLastModifiedDate() {
        return lastModifiedDate;
    }

    public void setLastModifiedDate() {
        this.lastModifiedDate = new java.util.Date().getTime();
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
