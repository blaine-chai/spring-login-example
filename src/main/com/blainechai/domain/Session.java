package com.blainechai.domain;

import org.eclipse.persistence.annotations.DeleteAll;

import javax.persistence.*;
import java.io.Serializable;
import java.sql.Date;

/**
 * Created by blainechai on 2016. 9. 7..
 */

@Entity
@Table(name = "Session")
public class Session implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String jSessionId;
    private String userId;
    private Date createDate;
    private String type;

    protected Session() {
    }

    public Session(String jSessionId, String userId, String type) {
        this.jSessionId = jSessionId;
        this.createDate = new Date(new java.util.Date().getTime());
        this.type = type;
    }

    public String getjSessionId() {
        return jSessionId;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public String getType() {
        return type;
    }
}
