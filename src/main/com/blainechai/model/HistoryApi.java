package com.blainechai.model;

import com.blainechai.domain.*;

/**
 * Created by blainechai on 2016. 11. 11..
 */
public class HistoryApi {
    private Long id;
    private String word;
    private long date;
    private boolean isBookmarked;
    private int count;
    private boolean hasNewData;

    public HistoryApi(Long id, String word, long date, boolean isBookmarked, int count, boolean hasNewData) {
        this.id = id;
        this.word = word;
        this.date = date;
        this.isBookmarked = isBookmarked;
        this.count = count;
        this.hasNewData = hasNewData;
    }

    public HistoryApi(UserHistory userHistory) {
        this.id = userHistory.getId();
        this.word = userHistory.getWord();
        this.date = userHistory.getDate();
        if (userHistory.getUserBookmark() != null) {
            this.isBookmarked = true;
        } else {
            this.isBookmarked = false;
        }
        this.hasNewData = false;
    }

    public HistoryApi(UserBookmark userBookmark, boolean hasNewData) {
        this.id = userBookmark.getId();
        this.word = userBookmark.getWord();
        this.date = userBookmark.getDate();
        this.isBookmarked = true;
        this.count = userBookmark.getCount();
        this.hasNewData = hasNewData;
    }

    public HistoryApi(AdminHistory adminHistory, boolean isBookmarked) {
        this.id = adminHistory.getId();
        this.word = adminHistory.getWord();
        this.date = adminHistory.getDate();
        this.isBookmarked = isBookmarked;
        this.hasNewData = false;
    }

    public HistoryApi(CommonBookmark commonBookmark, boolean hasNewData) {
        this.id = commonBookmark.getId();
        this.word = commonBookmark.getAdminBookmark().getWord();
        this.date = commonBookmark.getAdminBookmark().getDate();
        this.isBookmarked = true;
        this.count = commonBookmark.getCount();
        this.hasNewData = hasNewData;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getWord() {
        return word;
    }

    public void setWord(String word) {
        this.word = word;
    }

    public long getDate() {
        return date;
    }

    public void setDate(long date) {
        this.date = date;
    }

    public boolean isBookmarked() {
        return isBookmarked;
    }

    public void setBookmarked(boolean bookmarked) {
        isBookmarked = bookmarked;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public boolean isHasNewData() {
        return hasNewData;
    }

    public void setHasNewData(boolean hasNewData) {
        this.hasNewData = hasNewData;
    }
}
