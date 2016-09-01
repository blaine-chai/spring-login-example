package com.blainechai.model;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;

@Entity
@Table(name = "UserAccount")
public class UserAccount implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;


    private String username;
    private String password;

//    private String type;
//    private String firstname;
//    private String lastname;
//    private String account;
//    private String password;
//    private String number;
//    private String model;
//    private String uuid;
//    private boolean active;
//    private Date createDate;
//    private String chatId;
//    private String businessNumber;
//    private String say;

    protected UserAccount() {
    }

    public UserAccount(String username, String password) {
        this.username = username;
        this.password = password;
    }

    //    public UserAccount(String type, String firstname, String lastname, String account, String password, String number, String model, String businessNumber, String chatId) {
//        this.type = type;
//        this.firstname = firstname;
//        this.lastname = lastname;
//        this.account = account;
//        this.password = password;
//        this.number = number;
//        this.model = model;
////        this.uuid = new MD5Generator(account + number).generate();
//        this.createDate = new Date(new java.util.Date().getTime());
//        this.businessNumber = businessNumber;
//        this.active = false;
//        this.say = "";
//        this.chatId = chatId;
//    }
//
//    public Long getId() {
//        return id;
//    }
//
//    public String getType() {
//        return type;
//    }
//
//    public String getFirstname() {
//        return firstname;
//    }
//
//    public String getLastname() {
//        return lastname;
//    }
//
//    public String getUsername() {
//        return lastname + firstname;
//    }
//
//    public String getAccount() {
//        return account;
//    }
//
//    public String getPassword() {
//        return password;
//    }
//
//    public String getNumber() {
//        return number;
//    }
//
//    public String getModel() {
//        return model;
//    }
//
//    public String getUuid() {
//        return uuid;
//    }
//
//    public Date getCreateDate() {
//        return createDate;
//    }
//
//    public boolean isActive() {
//        return active;
//    }
//
//    public void setFirstname(String firstname) {
//        this.firstname = firstname;
//    }
//
//    public void setLastname(String lastname) {
//        this.lastname = lastname;
//    }
//
//    public void setAccount(String account) {
//        this.account = account;
//    }
//
//    public void setPassword(String password) {
//        this.password = password;
//    }
//
//    public void setNumber(String number) {
//        this.number = number.trim().replaceAll("[^0-9]", "");
//    }
//
////    public void setUuid() {
////        this.uuid = new MD5Generator(account + number).generate();
////    }
//
//    public void setActive(boolean active) {
//        this.active = active;
//    }
//
//    public String getBusinessNumber() {
//        return businessNumber;
//    }
//
//    public String getChatId() {
//        return chatId;
//    }
//
//    public void setChatId(String chatId) {
//        this.chatId = chatId;
//    }
//
//    public String getSay() {
//        return say;
//    }
//
//    public void setSay(String say) {
//        this.say = say;
//    }
}
