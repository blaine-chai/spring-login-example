package com.blainechai.model;

/**
 * Created by blainechai on 2016. 12. 2..
 */
public class GroupApi {
    private String groupName;
    private boolean isChecked;

    public GroupApi(String groupName, boolean isChecked) {
        this.groupName = groupName;
        this.isChecked = isChecked;
    }

    public String getGroupName() {
        return groupName;
    }

    public void setGroupName(String groupName) {
        this.groupName = groupName;
    }

    public boolean isChecked() {
        return isChecked;
    }

    public void setChecked(boolean checked) {
        isChecked = checked;
    }
}
