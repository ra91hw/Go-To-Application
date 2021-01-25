package com.upload.service;
import com.upload.entity.UserFile;
import java.util.List;
public interface UserFileService {
    List<UserFile> findByUserId (Integer id);

    void save(UserFile userFile);

    UserFile findById(String id);

    void update(UserFile userFile);

    void delete(String id);
}
