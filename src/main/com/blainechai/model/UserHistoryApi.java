package com.blainechai.model;

import com.blainechai.domain.UserBookmark;
import com.blainechai.domain.UserHistory;

/**
 * Created by blainechai on 2016. 11. 11..
 */
public class UserHistoryApi {
    private Long id;
    private String word;
    private long date;
    private boolean isBookmarked;
    private int count;

    public UserHistoryApi(Long id, String word, long date, boolean isBookmarked, int count) {
        this.id = id;
        this.word = word;
        this.date = date;
        this.isBookmarked = isBookmarked;
        this.count = count;
    }

    public UserHistoryApi(UserHistory userHistory) {
        this.id = userHistory.getId();
        this.word = userHistory.getWord();
        this.date = userHistory.getDate();
        if (userHistory.getUserBookmark() != null) {
            this.isBookmarked = true;
        }else {
            this.isBookmarked = false;
        }
    }

    public UserHistoryApi(UserBookmark userBookmark) {
        this.id = userBookmark.getId();
        this.word = userBookmark.getWord();
        this.date = userBookmark.getDate();
        this.isBookmarked = true;
        this.count = userBookmark.getCount();
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
}
