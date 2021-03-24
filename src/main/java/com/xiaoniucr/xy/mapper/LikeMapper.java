package com.xiaoniucr.xy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.xiaoniucr.xy.entity.Like;
import org.apache.ibatis.annotations.Param;

/**
 *  Like Mapper interface
 */
public interface LikeMapper extends BaseMapper<Like> {

    Like selectByUserAndAlbum(@Param(value = "userId") Integer userId,
                             @Param(value = "albumId") Integer albumId);

    /**
            * Delete thumb up
* @param albumId
* @return
        */
    Integer deleteByAlbum(@Param(value = "albumId")Integer albumId);

}
