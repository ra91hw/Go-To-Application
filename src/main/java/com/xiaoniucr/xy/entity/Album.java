package com.xiaoniucr.xy.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import com.xiaoniucr.xy.core.base.BaseEntity;

import java.io.Serializable;
import java.util.List;

/**
 * Album
 */
@TableName("xy_album")
public class Album extends BaseEntity<Album> {

    private static final long serialVersionUID = 1L;

    /**
     * User ID
     */
    @TableField("user_id")
    private Integer userId;
    /**
     * Classification
     */
    @TableField("category_id")
    private Integer categoryId;
    /**
     * Album theme
     */
    private String title;
    /**
     * Album cover, the system defaults when there is no photo in the album, and the first one when there is a photo
     */
    private String cover;
    /**
     * album description
     */
    private String description;
    /**
     * Likes
     */
    @TableField("agree_number")
    private Integer agreeNumber;
    /**
     * Number of comments
     */
    @TableField("discuss_number")
    private Integer discussNumber;
    /**
     * Clicks
     */
    @TableField("click_number")
    private Integer clickNumber;

    /**
     * Number of photos
     */
    @TableField("total_number")
    private Integer totalNumber;
    /**
     * Status: 0 public, 1 private
     */
    private Integer status;

    /**
     * Like or not: 0 no, 1 yes
     */
    @TableField(exist = false)
    private Integer isAgree = 0;

    /**
     * Album classification
     */
    @TableField(exist = false)
    private Category category;

    /**
     * user
     */
    @TableField(exist = false)
    private User user;

    @TableField(exist = false)
    private List<Discuss> discussList;


    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getCategoryId() {
        return categoryId;
    }

    public void setCategoryId(Integer categoryId) {
        this.categoryId = categoryId;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getCover() {
        return cover;
    }

    public void setCover(String cover) {
        this.cover = cover;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getAgreeNumber() {
        return agreeNumber;
    }

    public void setAgreeNumber(Integer agreeNumber) {
        this.agreeNumber = agreeNumber;
    }

    public Integer getDiscussNumber() {
        return discussNumber;
    }

    public void setDiscussNumber(Integer discussNumber) {
        this.discussNumber = discussNumber;
    }

    public Integer getClickNumber() {
        return clickNumber;
    }

    public void setClickNumber(Integer clickNumber) {
        this.clickNumber = clickNumber;
    }

    public Integer getTotalNumber() {
        return totalNumber;
    }

    public void setTotalNumber(Integer totalNumber) {
        this.totalNumber = totalNumber;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }

    public Integer getIsAgree() {
        return isAgree;
    }

    public void setIsAgree(Integer isAgree) {
        this.isAgree = isAgree;
    }

    public Category getCategory() {
        return category;
    }

    public void setCategory(Category category) {
        this.category = category;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Discuss> getDiscussList() {
        return discussList;
    }

    public void setDiscussList(List<Discuss> discussList) {
        this.discussList = discussList;
    }

    @Override
    protected Serializable pkVal() {
        return null;
    }

    @Override
    public String toString() {
        return "Album{" +
        ", userId=" + userId +
        ", categoryId=" + categoryId +
        ", title=" + title +
        ", cover=" + cover +
        ", description=" + description +
        ", agreeNumber=" + agreeNumber +
        ", discussNumber=" + discussNumber +
        ", clickNumber=" + clickNumber +
        ", status=" + status +
        "}";
    }
}
