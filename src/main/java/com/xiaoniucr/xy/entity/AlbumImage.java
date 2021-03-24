package com.xiaoniucr.xy.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.xiaoniucr.xy.core.base.BaseEntity;

import java.io.Serializable;

/**
 * photo album
 */
@TableName("xy_album_image")
public class AlbumImage extends BaseEntity<AlbumImage> {

    private static final long serialVersionUID = 1L;

    /**
     * Album ID
     */
    @TableField("album_id")
    private Integer albumId;
    /**
     * photo Adress
     */
    @TableField("album_image")
    private String albumImage;


    public Integer getAlbumId() {
        return albumId;
    }

    public void setAlbumId(Integer albumId) {
        this.albumId = albumId;
    }

    public String getAlbumImage() {
        return albumImage;
    }

    public void setAlbumImage(String albumImage) {
        this.albumImage = albumImage;
    }

    @Override
    protected Serializable pkVal() {
        return null;
    }

    @Override
    public String toString() {
        return "AlbumImage{" +
        ", albumId=" + albumId +
        ", albumImage=" + albumImage +
        "}";
    }
}
