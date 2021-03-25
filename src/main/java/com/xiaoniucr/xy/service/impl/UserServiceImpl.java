package com.xiaoniucr.xy.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.xiaoniucr.xy.entity.User;
import com.xiaoniucr.xy.mapper.UserMapper;
import com.xiaoniucr.xy.service.IUserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 *User service
 *implementation class
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    @Autowired
    private UserMapper userMapper;

    @Override
    public List<User> queryList(Map map) {
        return userMapper.queryList(map);
    }

    @Override
    public int queryTotal(Map map) {
        return userMapper.queryTotal(map);
    }

    @Override
    public User selectByUsername(String username) {
        return userMapper.selectByUsername(username);
    }

    @Override
    public User selectById(Integer id) {
        return userMapper.selectById(id);
    }

}
