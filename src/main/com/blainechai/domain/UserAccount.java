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
    private String type;

    protected UserAccount() {
    }

    public UserAccount(String userId, String username, String password, String phone, String type) {
        this.userId = userId;
        this.username = username;
        this.hash = EncryptUtil.getSHA256(EncryptUtil.FIRST_KEY + userId + password + EncryptUtil.SECOND_KEY);
        this.phone = phone;
        this.createDate = new Date(new java.util.Date().getTime());
        this.type = type;
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

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public void setPassword(String password){
        this.hash = EncryptUtil.getSHA256(EncryptUtil.FIRST_KEY + this.userId + password + EncryptUtil.SECOND_KEY);
    }


}
