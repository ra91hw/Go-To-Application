package com.xiaoniucr.xy.entity;

import com.baomidou.mybatisplus.annotations.TableName;
import com.xiaoniucr.xy.core.base.BaseEntity;

import java.io.Serializable;

/**
*Banner
 */
@TableName("xy_banner")
public class Banner extends BaseEntity<Banner> {

    private static final long serialVersionUID = 1L;

    private String title;
    private String url;
    private String link;
    private Integer status;


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
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
        return "Banner{" +
        ", title=" + title +
        ", url=" + url +
        ", link=" + link +
        ", status=" + status +
        "}";
    }
}
