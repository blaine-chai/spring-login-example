package com.blainechai.domain;

import com.blainechai.util.EncryptUtil;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;

@Entity
@Table(name = "user_account")
public class UserAccount implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String userId;
    private String username;
    private String hash;
    private String phone;
    private Date createDate;
//    private int col1;
//    private int col2;
//    private int col3;
//    private int col4;
//    private int col5;
//    private int col6;
//    private int col7;
//    private int col8;
//    private int col9;
//    private int col10;
//    private int col11;
//    private int col12;

    protected UserAccount() {
    }

    public UserAccount(String userId, String username, String password, String phone) {
        this.userId = userId;
        this.username = username;
        this.hash = EncryptUtil.getSHA256(EncryptUtil.FIRST_KEY + username + password + EncryptUtil.SECOND_KEY);
        this.phone = phone;
        this.createDate = new Date(new java.util.Date().getTime());
    }

//    public Long getId() {
//        return id;
//    }
//
    public String getUserId() {
        return userId;
    }

    public String getUsername() {
        return username;
    }

    public String getHash() {
        return hash;
    }

    public String getPhone() {
        return phone;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public void setHash(String hash) {
        this.hash = hash;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }
}
