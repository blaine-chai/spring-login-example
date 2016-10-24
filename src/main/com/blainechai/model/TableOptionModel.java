package com.blainechai.model;

/**
 * Created by blainechai on 2016. 10. 22..
 */
public class TableOptionModel {
    int[] colSizes;

    public TableOptionModel(int[] colSizes) {
        this.colSizes = colSizes;
    }

    public int[] getColSizes() {
        return colSizes;
    }

    public void setColSizes(int[] colSizes) {
        this.colSizes = colSizes;
    }
}
