package com.blainechai.model;

/**
 * Created by blainechai on 2016. 11. 9..
 */
public class AuthorAndRelAuthor {
    private String author;
    private String nickname;

    public AuthorAndRelAuthor(String author, String nickname) {
        this.author = author;
        this.nickname = nickname;
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
}
