package com.upload.dao;

import com.upload.entity.UserFile;

import java.util.List;

public interface UserFileDao {
    //Gets a list of user photo information based on the logged-in user
    List<UserFile> findByUserID(Integer id);

    //Save the user's photo record

    void save(UserFile userFile);
//Get photo information based on the photo ID
    UserFile findById(String id);
//Update download times based on ID
    void update(UserFile userFile);
//Delete records by ID
    void delete(String id);
}
