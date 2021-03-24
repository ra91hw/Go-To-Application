package com.xiaoniucr.xy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.xiaoniucr.xy.entity.Discuss;
import com.xiaoniucr.xy.vo.DiscussVo;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 *  Discuss Mapper interface
 */
public interface DiscussMapper extends BaseMapper<Discuss> {

    /**
     * Check article comments
     * @param blogId
     * @return
     */
    List<DiscussVo> selectDiscussList(@Param(value = "blogId") Integer blogId);



    /**
     * Check comments based on the primary key
     * @param id
     * @return
     */
    Discuss selectByKey(@Param(value = "id") Integer id);



    /**
     * Get the latest reviews
     * @param limit
     * @return
     */
    List<Discuss> selectLatestList(@Param(value = "limit")Integer limit);



    /**
     * Delete comment
     * @param blogId
     * @return
     */
    Integer deleteByBlog(@Param(value = "blogId")Integer blogId);

}
