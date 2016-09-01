package com.blainechai.model;

import javax.persistence.*;
import java.io.Serializable;

@Entity
@Table(name = "AdminAccount")
public class AdminAccount implements Serializable {

    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String username;
    private String password;

    protected AdminAccount() {
    }

    public AdminAccount(String username, String password) {
        this.username = username;
        this.password = password;
    }

    public Long getId() {
        return id;
    }

    public String getUsername() {
        return username;
    }

    public String getPassword() {
        return password;
    }

}
