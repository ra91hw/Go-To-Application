package com.xiaoniucr.xy.service;

import com.baomidou.mybatisplus.service.IService;
import com.xiaoniucr.xy.entity.Like;


/**
 * like Service interface
 */
public interface ILikeService extends IService<Like> {

    /**
     * 根据用户和相册查询点赞
     * @param userId
     * @return
     */
    Like selectByUserAndAlbum(Integer userId, Integer blogId);

    /**
     * 删除点赞
     * @param blogId
     * @return
     */
    Integer deleteByBlog(Integer blogId);


}
