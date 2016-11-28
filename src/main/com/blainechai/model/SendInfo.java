package com.blainechai.model;

/**
 * Created by blainechai on 2016. 10. 14..
 */

public class SendInfo {

    private String id;
    private String sel;
    private String contents;    
    
    private int job;
    private int jobOrder;
    private int page;
    private String bookInfoList;
    
    private String author;
    private String period;
    
    private String keyword;
    private String resultList;
    
    protected SendInfo() {
    }

    public SendInfo(String id, String job, String jobOrder, String sel, String page, String contents, String bookInfoList) {
        this.id = id;
        this.job = Integer.parseInt(job);
        this.jobOrder = Integer.parseInt(jobOrder);
        this.sel = sel;
        this.page = Integer.parseInt(page);
        this.contents = contents;
        this.bookInfoList = bookInfoList;
    }
    public SendInfo(String id, String author, String period, String sel, String page, String contents, String bookInfoList, int k) {
        this.id = id;
        this.author = author;
        this.period = period;
        this.sel = sel;
        this.page = Integer.parseInt(page);
        this.contents = contents;
        this.bookInfoList = bookInfoList;
    }
    
    public SendInfo(String id, String sel, String contents, String keyword, String resultList) {
        this.id = id;
        this.sel = sel;
        this.contents = contents;
        this.keyword = keyword;
        this.resultList = resultList;
    }
    

    public String getId() {
        return id;
    }
    
    public int getJob() {
        return job;
    }
    
    public int getJobOrder() {
        return jobOrder;
    }
    
   public String getSel() {
        return sel;
    }

    public int getPage() {
        return page;
    }
    
    public String getContents() {
        return contents;
    }
    public String getBookInfo() {
        return bookInfoList;
    }

    public void setJob(int job) {
        this.job = job;
    }

    public void setJobOrder(int jobOrder) {
        this.jobOrder = jobOrder;
    }

    public void setSel(String sel) {
        this.sel = sel;
    }

    public void setPage(int page) {
        this.page = page;
    }

    public void setContents(String contents) {
        this.contents = contents;
    }

    public String getBookInfoList() {
        return bookInfoList;
    }

    public void setBookInfoList(String bookInfoList) {
        this.bookInfoList = bookInfoList;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getPeriod() {
        return period;
    }

    public void setPeriod(String period) {
        this.period = period;
    }
}
