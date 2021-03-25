package com.xiaoniucr.xy.vo;

import java.io.Serializable;

/**
 * UEditorCustomize image upload return data format
 */
public class UEditorResult implements Serializable {

    private static final long serialVersionUID = 1L;

    /**
     * file name
     */
    private String name;
    /**
     * Original file name
     */
    private String originalName;
    /**
     * File size
     */
    private long size;
    /**
     * Upload status
     */
    private String state;
    /**
     * File type [.jpg/.png...]
     */
    private String type;
    /**
     * Picture echo address
     */

    private String url;

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getOriginalName() {
        return originalName;
    }

    public void setOriginalName(String originalName) {
        this.originalName = originalName;
    }

    public long getSize() {
        return size;
    }

    public void setSize(long size) {
        this.size = size;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getUrl() {
        return url;
    }

    public void setUrl(String url) {
        this.url = url;
    }


}
