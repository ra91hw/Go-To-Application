package com.xiaoniucr.xy.entity;

import com.baomidou.mybatisplus.annotations.TableName;
import com.xiaoniucr.xy.core.base.BaseEntity;

import java.io.Serializable;

/**
 * Category
 */
@TableName("xy_category")
public class Category extends BaseEntity<Category> {

    private static final long serialVersionUID = 1L;

    /**
     * Category name
     */
    private String name;
    /**
     * The higher classification
     */
    private Integer pid;
    /**
     * Classification description
     */
    private String description;
    /**
     * The sorting
     */
    private Integer sort;
    /**
     * icon
     */
    private String icon;
    /**
     * Status: 1 enabled, 2 disabled
     */
    private Integer status;



    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getPid() {
        return pid;
    }

    public void setPid(Integer pid) {
        this.pid = pid;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public Integer getSort() {
        return sort;
    }

    public void setSort(Integer sort) {
        this.sort = sort;
    }

    public String getIcon() {
        return icon;
    }

    public void setIcon(String icon) {
        this.icon = icon;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }


    @Override
    protected Serializable pkVal() {
        return null;
    }

    @Override
    public String toString() {
        return "Category{" +
        ", name=" + name +
        ", description=" + description +
        ", sort=" + sort +
        ", icon=" + icon +
        ", status=" + status +
        "}";
    }
}
