package com.xiaoniucr.xy.service;

import com.xiaoniucr.xy.entity.Category;
import com.baomidou.mybatisplus.service.IService;
import com.xiaoniucr.xy.entity.User;

import java.util.List;
import java.util.Map;

 /**
 *Category Service interface
 */

public interface ICategoryService extends IService<Category> {


    List<Category> queryList(Map map);

    int queryTotal(Map map);

    Category selectById(Integer id);

    Category selectByName(String name);

    List<Category> selectAll();



}
