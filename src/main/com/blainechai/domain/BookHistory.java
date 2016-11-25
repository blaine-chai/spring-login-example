//package com.blainechai.domain;
//
//import javax.persistence.*;
//import java.io.Serializable;
//
///**
// * Created by blainechai on 2016. 10. 20..
// */
//
//public class BookHistory{
//
//    private UserAccount userAccount;
//    private String bookId;
//    private int priority;
//    private boolean r;
//    private boolean e;
//
//    protected BookHistory() {
//    }
//
//
//    public BookHistory(UserAccount userAccount, String bookId, int priority, boolean r, boolean e) {
//        this.userAccount = userAccount;
//        this.bookId = bookId;
//        this.priority = priority;
//        this.r = r;
//        this.e = e;
//    }
//
//    public UserAccount getUserAccount() {
//        return userAccount;
//    }
//
//    public void setUserAccount(UserAccount userAccount) {
//        this.userAccount = userAccount;
//    }
//
//    public String getBookId() {
//        return bookId;
//    }
//
//    public void setBookId(String bookId) {
//        this.bookId = bookId;
//    }
//
//    public int getPriority() {
//        return priority;
//    }
//
//    public void setPriority(int priority) {
//        this.priority = priority;
//    }
//
//    public boolean isR() {
//        return r;
//    }
//
//    public void setR(boolean r) {
//        this.r = r;
//    }
//
//    public boolean isE() {
//        return e;
//    }
//
//    public void setE(boolean e) {
//        this.e = e;
//    }
//}
