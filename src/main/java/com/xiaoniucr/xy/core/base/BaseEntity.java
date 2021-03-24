package com.xiaoniucr.xy.core.base;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.IdType;
import com.fasterxml.jackson.annotation.JsonFormat;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;


public class BaseEntity<T extends Model> extends Model<T> {


    @TableId(type = IdType.AUTO)
    private Integer id;

    @JsonFormat(pattern = "HH:mm:ss dd-MM-yyyy",timezone = "GMT+8")
    @DateTimeFormat(pattern = "HH:mm:ss dd-MM-yyyy")
    private Date createTime;

    @JsonFormat(pattern = "HH:mm:ss dd-MM-yyyy",timezone = "GMT+8")
    @DateTimeFormat(pattern = "HH:mm:ss dd-MM-yyyy")
    private Date updateTime;

    @Override
    protected Serializable pkVal() {
        return this.id;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }
}
