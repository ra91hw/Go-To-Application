package com.xiaoniucr.xy.mapper;

import com.xiaoniucr.xy.entity.Category;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Category Mapper interface
 */
public interface CategoryMapper extends BaseMapper<Category> {

    /**
     * Query category
     * @param map
     * @return
     */
    List<Category> queryList(Map map);

    /**
     * Query the total number of categories
     * @param map
     * @return
     */
    int queryTotal(Map map);

    /**
     * Query category details
     * @param id
     * @return
     */
    Category selectByKey(@Param(value = "id") Integer id);


    /**
     * Query the category based on the category name (mainly to reuse)
     * @param name
     * @return
     */
    Category selectByName(@Param(value = "name")String name);


    /**
     * Query all categories
     * @return
     */
    List<Category> selectAll();




}
