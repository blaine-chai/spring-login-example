package com.blainechai.model;

import com.blainechai.domain.UserHistory;

/**
 * Created by blainechai on 2016. 11. 11..
 */
public class UserHistoryApi {
    private Long id;
    private String word;
    private long date;

    public UserHistoryApi(Long id, String word, long date) {
        this.id = id;
        this.word = word;
        this.date = date;
    }

    public UserHistoryApi(UserHistory userHistory) {
        this.id = userHistory.getId();
        this.word = userHistory.getWord();
        this.date = userHistory.getDate();
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
}
