package com.xiaoniucr.xy.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.xiaoniucr.xy.core.base.BaseEntity;

import java.io.Serializable;

/**
 * Discuss
 */
@TableName("xy_discuss")
public class Discuss extends BaseEntity<Discuss> {

    private static final long serialVersionUID = 1L;

    /**
     * Blog ID
     */
    @TableField("album_id")
    private Integer albumId;


    /**
     * Commenter-User ID
     */
    @TableField("user_id")
    private Integer userId;
    /**
     * Parent node-which comment ID to reply to
     */
    private Integer pid;
    /**
     * Comments
     */
    private String content;

    @TableField(exist = false)
    private User user;

    public Integer getAlbumId() {
        return albumId;
    }

    public void setAlbumId(Integer albumId) {
        this.albumId = albumId;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    @Override
    protected Serializable pkVal() {
        return null;
    }

    @Override
    public String toString() {
        return "Discuss{" +
        ", albumId=" + albumId +
        ", userId=" + userId +
        ", pid=" + pid +
        ", content=" + content +
        "}";
    }
}
