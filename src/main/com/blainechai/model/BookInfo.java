package com.blainechai.model;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;

/**
 * Created by blainechai on 2016. 10. 14..
 */

public class BookInfo{

    private String number;
    private String priority;
    private String groupName;
    private String publishedDate;
    private String savedDate;
    private String author;
    private String referencedAuthor;
    private String r;
    private String e;
    private String contents;
    private String note1;
    private String note2;
    private String eventNo;
    private String authNickname;
    private String refNickname;


    protected BookInfo() {
    }


    public BookInfo(String priority, String groupName, String publishedDate, String savedDate, String author, String referencedAuthor, String r, String e, String contents, String note1, String note2) {
        this.priority = priority;
        this.groupName = groupName;
        this.publishedDate = publishedDate;
        this.savedDate = savedDate;
        this.author = author;
        this.referencedAuthor = referencedAuthor;
        this.r = r;
        this.e = e;
        this.contents = contents;
        this.note1 = note1;
        this.note2 = note2;
    }

    public BookInfo(String[] str) {
        this.number = str[0];
        this.priority = str[4];
        this.groupName = str[1];
        this.publishedDate = str[2];
        this.savedDate = str[3];
        this.author = str[5].split("_")[1];
        this.referencedAuthor = str[6].split("_")[1];
        this.r = str[7];
        this.e = str[8];
        this.contents = str[9];
        this.note1 = str[10];
        this.note2 = str[11];
        this.eventNo = str[12];
    }

    public String getPriority() {
        return priority;
    }

    public void setPriority(String priority) {
        this.priority = priority;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public String getPublishedDate() {
        return publishedDate;
    }

    public void setPublishedDate(String publishedDate) {
        this.publishedDate = publishedDate;
    }

    public String getSavedDate() {
        return savedDate;
    }

    public void setSavedDate(String savedDate) {
        this.savedDate = savedDate;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getReferencedAuthor() {
        return referencedAuthor;
    }

    public void setReferencedAuthor(String referencedAuthor) {
        this.referencedAuthor = referencedAuthor;
    }

    public String getR() {
        return r;
    }

    public void setR(String r) {
        this.r = r;
    }

    public String getE() {
        return e;
    }

    public void setE(String e) {
        this.e = e;
    }

    public String getContents() {
        return contents;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public String getNote1() {
        return note1;
    }

    public void setNote1(String note1) {
        this.note1 = note1;
    }

    public String getNote2() {
        return note2;
    }

    public void setNote2(String note2) {
        this.note2 = note2;
    }

    public String getEventNo() {
        return eventNo;
    }

    public void setEventNo(String eventNo) {
        this.eventNo = eventNo;
    }

    public String getAuthNickname() {
        return authNickname;
    }

    public void setAuthNickname(String authNickname) {
        this.authNickname = authNickname;
    }

    public String getRefNickname() {
        return refNickname;
    }

	public void setRefNickname(String refNickname) {
        this.refNickname = refNickname;
    }
}
