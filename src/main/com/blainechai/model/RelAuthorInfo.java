package com.blainechai.model;

/**
 * Created by blainechai on 2016. 11. 9..
 */
public class RelAuthorInfo {
    private String relAuthor;
    private String from;
    private String to;
    private String nickname;

    public RelAuthorInfo(String relAuthor, String from, String to) {
        this.relAuthor = relAuthor;
        this.from = from;
        this.to = to;
    }

    public RelAuthorInfo(String relAuthor, String from, String to, String nickname) {
        this.relAuthor = relAuthor;
        this.from = from;
        this.to = to;
        this.nickname = nickname;
    }

    public RelAuthorInfo(String[] q) {
        this.relAuthor = q[0];
        this.from = q[1];
        this.to = q[2];
        //System.out.println(from);
    }

    public String getRelAuthor() {
        return relAuthor;
    }

    public void setRelAuthor(String relAuthor) {
        this.relAuthor = relAuthor;
    }

    public String getFrom() {
        return from;
    }

    public void setFrom(String from) {
        this.from = from;
    }

    public String getTo() {
        return to;
    }

    public void setTo(String to) {
        this.to = to;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }
}
