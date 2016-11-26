package com.blainechai.domain;

import javax.persistence.*;
import java.io.Serializable;
import java.util.List;

/**
 * Created by blainechai on 2016. 10. 18..
 */
@Entity
@Table(name = "user_table_option")
public class UserTableOption implements Serializable {
    private static final long serialVersionUID = 1L;

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    @OneToOne
    @JoinColumn(name = "userId", referencedColumnName = "userId")
    private UserAccount userAccount;

    private int col1;
    private int col2;
    private int col3;
    private int col4;
    private int col5;
    private int col6;
    private int col7;
    private int col8;
    private int col9;
    private int col10;
    private int col11;
    private int col12;

    protected UserTableOption() {
    }


    public UserTableOption(UserAccount userAccount, int[] colSizes) {
        this.userAccount = userAccount;
        this.col1 = colSizes[0];
        this.col2 = colSizes[1];
        this.col3 = colSizes[2];
        this.col4 = colSizes[3];
        this.col5 = colSizes[4];
        this.col6 = colSizes[5];
        this.col7 = colSizes[6];
        this.col8 = colSizes[7];
        this.col9 = colSizes[8];
        this.col10 = colSizes[9];
        this.col11 = colSizes[10];
        this.col12 = colSizes[11];
    }

    public static long getSerialVersionUID() {
        return serialVersionUID;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public UserAccount getUserAccount() {
        return userAccount;
    }

    public void setUserAccount(UserAccount userAccount) {
        this.userAccount = userAccount;
    }

    public int getCol1() {
        return col1;
    }

    public void setCol1(int col1) {
        this.col1 = col1;
    }

    public int getCol2() {
        return col2;
    }

    public void setCol2(int col2) {
        this.col2 = col2;
    }

    public int getCol3() {
        return col3;
    }

    public void setCol3(int col3) {
        this.col3 = col3;
    }

    public int getCol4() {
        return col4;
    }

    public void setCol4(int col4) {
        this.col4 = col4;
    }

    public int getCol5() {
        return col5;
    }

    public void setCol5(int col5) {
        this.col5 = col5;
    }

    public int getCol6() {
        return col6;
    }

    public void setCol6(int col6) {
        this.col6 = col6;
    }

    public int getCol7() {
        return col7;
    }

    public void setCol7(int col7) {
        this.col7 = col7;
    }

    public int getCol8() {
        return col8;
    }

    public void setCol8(int col8) {
        this.col8 = col8;
    }

    public int getCol9() {
        return col9;
    }

    public void setCol9(int col9) {
        this.col9 = col9;
    }

    public int getCol10() {
        return col10;
    }

    public void setCol10(int col10) {
        this.col10 = col10;
    }

    public int getCol11() {
        return col11;
    }

    public void setCol11(int col11) {
        this.col11 = col11;
    }

    public int getCol12() {
        return col12;
    }

    public void setCol12(int col12) {
        this.col12 = col12;
    }

    public void setColSizes(int[] colSizes) {
        this.col1 = colSizes[0];
        this.col2 = colSizes[1];
        this.col3 = colSizes[2];
        this.col4 = colSizes[3];
        this.col5 = colSizes[4];
        this.col6 = colSizes[5];
        this.col7 = colSizes[6];
        this.col8 = colSizes[7];
        this.col9 = colSizes[8];
        this.col10 = colSizes[9];
        this.col11 = colSizes[10];
        this.col12 = colSizes[11];
    }

    public void setColSizes(List colSizes) {
        this.col1 = (int) Float.parseFloat(colSizes.get(0).toString());
        this.col2 = (int) Float.parseFloat(colSizes.get(1).toString());
        this.col3 = (int) Float.parseFloat(colSizes.get(2).toString());
        this.col4 = (int) Float.parseFloat(colSizes.get(3).toString());
        this.col5 = (int) Float.parseFloat(colSizes.get(4).toString());
        this.col6 = (int) Float.parseFloat(colSizes.get(5).toString());
        this.col7 = (int) Float.parseFloat(colSizes.get(6).toString());
        this.col8 = (int) Float.parseFloat(colSizes.get(7).toString());
        this.col9 = (int) Float.parseFloat(colSizes.get(8).toString());
        this.col10 = (int) Float.parseFloat(colSizes.get(9).toString());
        this.col11 = (int) Float.parseFloat(colSizes.get(10).toString());
        this.col12 = (int) Float.parseFloat(colSizes.get(11).toString());
    }

    public String getColSizes() {
        return "[" + col1 + ", " + col2 + ", " + col3 + ", " + col4 + ", " + col5 + ", " + col6 + ", " + col7 + ", " + col8 + ", " + col9 + ", " + col10 + ", " + col11 + ", " + col12 + "]";
    }

    //    @Override
//    public String toString() {
//        return this.col1;
//    }
}
