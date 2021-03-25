package com.upload.service;

import com.upload.dao.UserDao;
import com.upload.entity.User;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;

import javax.annotation.Resource;

@Service //Hand it over to factory management
@Transactional //Control the transaction

//Implementing 'UserService' interface
public class UserServiceImpl implements UserService{
    @Autowired
    private UserDao userDao;

    @Override
    @Transactional(propagation = Propagation.SUPPORTS)//Query Support Transaction
    public User login(User user){
        return userDao.login(user);
    }
}
