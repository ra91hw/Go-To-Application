package com.xiaoniucr.xy.vo;

import java.util.Date;

public class DiscussVo {

    /**
     * CommentID
     */
    private Integer id;

    /**
     * Comment content
     */
    private String content;


    /**
     * Reviewer ID
     */
    private Integer disId;

    /**
     * Commenter's nickname
     */
    private String disNickname;

    /**
     * Commenter's Avatar
     */
    private String disAvatar;

    /**
     * Comment type: 0 comment, 1 reply comment
     */
    private Integer disType;

    /**
     * Replied person Id
     */
    private Integer beReplyId;

    /**
     * Replied person's nickname
     */
    private String beReplyNickname;

    /**
     * date
     */
    private Date createTime;

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getDisId() {
        return disId;
    }

    public void setDisId(Integer disId) {
        this.disId = disId;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getDisNickname() {
        return disNickname;
    }

    public void setDisNickname(String disNickname) {
        this.disNickname = disNickname;
    }

    public String getDisAvatar() {
        return disAvatar;
    }

    public void setDisAvatar(String disAvatar) {
        this.disAvatar = disAvatar;
    }

    public Integer getDisType() {
        return disType;
    }

    public void setDisType(Integer disType) {
        this.disType = disType;
    }

    public Integer getBeReplyId() {
        return beReplyId;
    }

    public void setBeReplyId(Integer beReplyId) {
        this.beReplyId = beReplyId;
    }

    public String getBeReplyNickname() {
        return beReplyNickname;
    }

    public void setBeReplyNickname(String beReplyNickname) {
        this.beReplyNickname = beReplyNickname;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
