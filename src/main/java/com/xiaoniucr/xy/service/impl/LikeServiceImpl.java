package com.xiaoniucr.xy.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.xiaoniucr.xy.entity.Like;
import com.xiaoniucr.xy.mapper.LikeMapper;
import com.xiaoniucr.xy.service.ILikeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

/**
 *Like service
 *implementation class
 */
@Service
public class LikeServiceImpl extends ServiceImpl<LikeMapper, Like> implements ILikeService {

    @Autowired
    private LikeMapper likeMapper;

    @Override
    public Like selectByUserAndAlbum(Integer userId, Integer albumId) {
        return likeMapper.selectByUserAndAlbum(userId,albumId);
    }

    @Override
    public Integer deleteByBlog(Integer albumId) {
        return likeMapper.deleteByAlbum(albumId);
    }

}
