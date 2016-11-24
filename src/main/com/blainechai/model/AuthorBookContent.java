package com.blainechai.model;

/**
 * Created by blainechai on 2016. 11. 9..
 */
public class AuthorBookContent {
    private String author;
    private String relAuthor;
    private String content;
    private String savedDate;

    public AuthorBookContent(String author, String relAuthor, String content, String savedDate) {
        this.author = author;
        this.relAuthor = relAuthor;
        this.content = content;
        this.savedDate = savedDate;
    }

    public AuthorBookContent(String[] r) {
        this.author = r[5];
        this.relAuthor = r[6];
        this.content = r[9];
        this.savedDate = r[2];
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getRelAuthor() {
        return relAuthor;
    }

    public void setRelAuthor(String relAuthor) {
        this.relAuthor = relAuthor;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getSavedDate() {
        return savedDate;
    }

    public void setSavedDate(String savedDate) {
        this.savedDate = savedDate;
    }
}
