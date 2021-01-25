package com.upload.service;

import com.upload.dao.UserFileDao;
import com.upload.entity.UserFile;
import lombok.Data;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.Date;
import java.util.List;

@Service
@Transactional
public class UserFileServiceImpl implements UserFileService{
    @Autowired
    private UserFileDao userFileDao;

    @Override
    public List<UserFile> findByUserId(Integer id){
        return userFileDao.findByUserID(id);
    }

    @Override
    public void delete(String id){
        userFileDao.delete(id);
    }

    @Override
    public void update(UserFile userFile){
         userFileDao.update(userFile);
    }

    @Override
    public UserFile findById(String id){
        return userFileDao.findById(id);
    }

    @Override
    public void save(UserFile userFile){
        //If the type contains image, the current type must be image
        String isImg = userFile.getType().startsWith("image")?"It is a photo":"It is not a photo";
        userFile.setIsImg(isImg);
        userFile.setDownloadcounts(0);
        userFile.setUploadtime(new Date());
        userFileDao.save(userFile);
    }
}
