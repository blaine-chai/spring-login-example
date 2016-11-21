package com.blainechai.model;

import com.blainechai.domain.AdminBookmark;
import com.blainechai.domain.AdminHistory;
import com.blainechai.domain.UserBookmark;
import com.blainechai.domain.UserHistory;

/**
 * Created by blainechai on 2016. 11. 11..
 */
public class HistoryApi {
    private Long id;
    private String word;
    private long date;
    private boolean isBookmarked;
    private int count;

    public HistoryApi(Long id, String word, long date, boolean isBookmarked, int count) {
        this.id = id;
        this.word = word;
        this.date = date;
        this.isBookmarked = isBookmarked;
        this.count = count;
    }

    public HistoryApi(UserHistory userHistory) {
        this.id = userHistory.getId();
        this.word = userHistory.getWord();
        this.date = userHistory.getDate();
        if (userHistory.getUserBookmark() != null) {
            this.isBookmarked = true;
        }else {
            this.isBookmarked = false;
        }
    }

    public HistoryApi(UserBookmark userBookmark) {
        this.id = userBookmark.getId();
        this.word = userBookmark.getWord();
        this.date = userBookmark.getDate();
        this.isBookmarked = true;
        this.count = userBookmark.getCount();
    }

    public HistoryApi(AdminHistory adminHistory) {
        this.id = adminHistory.getId();
        this.word = adminHistory.getWord();
        this.date = adminHistory.getDate();
        if (adminHistory.getUserBookmark() != null) {
            this.isBookmarked = true;
        }else {
            this.isBookmarked = false;
        }
    }

    public HistoryApi(AdminBookmark adminBookmark) {
        this.id = adminBookmark.getId();
        this.word = adminBookmark.getAdminHistory().getWord();
        this.date = adminBookmark.getDate();
        this.isBookmarked = true;
        this.count = adminBookmark.getCount();
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
}
