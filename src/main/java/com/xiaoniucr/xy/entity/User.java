package com.xiaoniucr.xy.entity;

import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableName;
import com.xiaoniucr.xy.core.base.BaseEntity;

import java.io.Serializable;

/**
*User
 */
@TableName("xy_user")
public class User extends BaseEntity<User> {

    private static final long serialVersionUID = 1L;

    /**
     * User
     */
    private String username;
    /**
     * nickname
     */
    private String nickname;
    /**
     *password
     */
    private String password;
    /**
     * telephone
     */
    private String telphone;
    /**
     * email
     */
    private String email;
    /**
     * avatar
     */
    private String avatar;

    /**
     * Has been changed
     * the name of your city
     */
    private String school;

    /**
     * Has been changed
     * hobby
     */
    private String professional;

    /**
     * Personal introduction html text
     */
    private String introduce;

    /**
     * User type: 1 administrator, 2 users
     */
    private Integer type;

    /**
     * Number of visits
     */
    @TableField("visit_number")
    private Integer visitNumber;

    /**
     * 1 enable, 2 disable
     */
    private Integer status;

    @TableField(exist = false)
    private String dateFormat;

    /**
     * isFriend？
     */
    @TableField(exist = false)
    private Integer isFriend = 0;


    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getTelphone() {
        return telphone;
    }

    public void setTelphone(String telphone) {
        this.telphone = telphone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getAvatar() {
        return avatar;
    }

    public void setAvatar(String avatar) {
        this.avatar = avatar;
    }

    public Integer getType() {
        return type;
    }

    public void setType(Integer type) {
        this.type = type;
    }

    public String getSchool() {
        return school;
    }

    public void setSchool(String school) {
        this.school = school;
    }

    public String getProfessional() {
        return professional;
    }

    public void setProfessional(String professional) {
        this.professional = professional;
    }

    public String getIntroduce() {
        return introduce;
    }

    public void setIntroduce(String introduce) {
        this.introduce = introduce;
    }

    public Integer getVisitNumber() {
        return visitNumber;
    }

    public void setVisitNumber(Integer visitNumber) {
        this.visitNumber = visitNumber;
    }

    public Integer getStatus() {
        return status;
    }

    public void setStatus(Integer status) {
        this.status = status;
    }


    public String getDateFormat() {
        return dateFormat;
    }

    public void setDateFormat(String dateFormat) {
        this.dateFormat = dateFormat;
    }

    public Integer getIsFriend() {
        return isFriend;
    }

    public void setIsFriend(Integer isFriend) {
        this.isFriend = isFriend;
    }

    @Override
    protected Serializable pkVal() {
        return null;
    }

    @Override
    public String toString() {
        return "User{" +
        ", username=" + username +
        ", nickname=" + nickname +
        ", password=" + password +
        ", telphone=" + telphone +
        ", email=" + email +
        ", avatar=" + avatar +
        ", type=" + type +
        ", status=" + status +
        "}";
    }
}
