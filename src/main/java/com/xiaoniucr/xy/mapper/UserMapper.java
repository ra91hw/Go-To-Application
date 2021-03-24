package com.xiaoniucr.xy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.xiaoniucr.xy.entity.User;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**

 *  User Mapper interface
 */
public interface UserMapper extends BaseMapper<User> {

    List<User> queryList(Map map);

    int queryTotal(Map map);

    User selectByUsername(@Param(value = "username") String username);

    User selectByKey(@Param(value = "id") Integer id);

}
