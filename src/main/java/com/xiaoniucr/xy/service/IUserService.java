package com.xiaoniucr.xy.service;

import com.baomidou.mybatisplus.service.IService;
import com.xiaoniucr.xy.entity.User;

import java.util.List;
import java.util.Map;


 /**
 * User Service interface
 */

public interface IUserService extends IService<User> {

    List<User> queryList(Map map);

    int queryTotal(Map map);

    User selectByUsername(String username);

    User selectById(Integer id);


}
