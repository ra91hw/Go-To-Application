package com.xiaoniucr.xy.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.xiaoniucr.xy.core.base.BaseEntity;

import java.io.Serializable;

/**
*like
 */
@TableName("xy_like")
public class Like extends BaseEntity<Like> {

    private static final long serialVersionUID = 1L;

    /**
     * User ID
     */
    @TableField("user_id")
    private Integer userId;
    /**
     * Album ID
     */
    @TableField("album_id")
    private Integer albumId;


    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getAlbumId() {
        return albumId;
    }

    public void setAlbumId(Integer albumId) {
        this.albumId = albumId;
    }

    @Override
    protected Serializable pkVal() {
        return null;
    }

    @Override
    public String toString() {
        return "Like{" +
        ", userId=" + userId +
        ", albumId=" + albumId +
        "}";
    }
}
