//package com.blainechai.domain;
//
//import javax.persistence.*;
//import java.io.Serializable;
//import java.sql.Date;
//
//@Entity
//@Table(name = "admin_account")
//public class AdminAccount implements Serializable {
//
//    private static final long serialVersionUID = 1L;
//
//    @Id
//    @GeneratedValue(strategy = GenerationType.IDENTITY)
//    private Long id;
//
//    private String userId;
//    private String username;
////    private String organization;
//    private String password;
//    private Date createDate;
//
//    protected AdminAccount() {
//    }
//
////    public AdminAccount(String userId, String userName, String organization, String password) {
////        this.userId = userId;
////        this.userName = userName;
////        this.organization = organization;
////        this.password = password;
////        this.createDate = new Date(new java.util.Date().getTime());
////    }
//
//    public AdminAccount(String userId, String username, String password) {
//        this.userId = userId;
//        this.username = username;
//        this.password = password;
//        this.createDate = new Date(new java.util.Date().getTime());
//    }
//
//    public Long getId() {
//        return id;
//    }
//
//    public String getUserId() {
//        return userId;
//    }
//
//    public String getUsername() {
//        return username;
//    }
//
////    public String getOrganization() {
////        return organization;
////    }
//
//    public String getPassword() {
//        return password;
//    }
//
//    public Date getCreateDate() {
//        return createDate;
//    }
//
//    public void setUserId(String userId) {
//        this.userId = userId;
//    }
//
//    public void setUsername(String username) {
//        this.username = username;
//    }
//
//    public void setPassword(String password) {
//        this.password = password;
//    }
//
//    public void setCreateDate(Date createDate) {
//        this.createDate = createDate;
//    }
//}
