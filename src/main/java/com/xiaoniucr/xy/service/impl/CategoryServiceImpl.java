package com.xiaoniucr.xy.service.impl;

import com.xiaoniucr.xy.entity.Category;
import com.xiaoniucr.xy.mapper.CategoryMapper;
import com.xiaoniucr.xy.service.ICategoryService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 *Category service
 *implementation class

 */
@Service
public class CategoryServiceImpl extends ServiceImpl<CategoryMapper, Category> implements ICategoryService {

    @Autowired
    private CategoryMapper categoryMapper;

    @Override
    public List<Category> queryList(Map map) {
        return categoryMapper.queryList(map);
    }

    @Override
    public int queryTotal(Map map) {
        return categoryMapper.queryTotal(map);
    }

    @Override
    public Category selectById(Integer id) {
        return categoryMapper.selectByKey(id);
    }

    @Override
    public Category selectByName(String name) {
        return categoryMapper.selectByName(name);
    }

    @Override
    public List<Category> selectAll() {
        return categoryMapper.selectAll();
    }


}
