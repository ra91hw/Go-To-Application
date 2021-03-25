package com.xiaoniucr.xy.entity;

import com.baomidou.mybatisplus.annotations.TableName;
import com.xiaoniucr.xy.core.base.BaseEntity;

import java.io.Serializable;

/**
Link
 */
@TableName("xy_link")
public class Link extends BaseEntity<Link> {

    private static final long serialVersionUID = 1L;

    /**
     * link title
     */
    private String title;
    /**
     *  link address
     */
    private String link;


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLink() {
        return link;
    }

    public void setLink(String link) {
        this.link = link;
    }

    @Override
    protected Serializable pkVal() {
        return null;
    }

    @Override
    public String toString() {
        return "Link{" +
        ", title=" + title +
        ", link=" + link +
        "}";
    }
}
