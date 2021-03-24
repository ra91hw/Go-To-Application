package com.xiaoniucr.xy.entity;

import com.baomidou.mybatisplus.annotations.TableName;
import com.xiaoniucr.xy.core.base.BaseEntity;

import java.io.Serializable;

/**

 * Notice

 */
@TableName("xy_notice")
public class Notice extends BaseEntity<Notice> {

    private static final long serialVersionUID = 1L;

    /**
     * Announcement title
     */
    private String title;
    /**
     * Announcement content
     */
    private String content;


    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    @Override
    protected Serializable pkVal() {
        return null;
    }

    @Override
    public String toString() {
        return "Notice{" +
        ", title=" + title +
        ", content=" + content +
        "}";
    }
}
