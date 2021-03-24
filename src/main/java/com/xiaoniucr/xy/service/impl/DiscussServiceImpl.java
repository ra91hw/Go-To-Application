package com.xiaoniucr.xy.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.xiaoniucr.xy.entity.Discuss;
import com.xiaoniucr.xy.mapper.DiscussMapper;
import com.xiaoniucr.xy.service.IDiscussService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 *Discuss service
 *implementation class
 */
@Service
public class DiscussServiceImpl extends ServiceImpl<DiscussMapper, Discuss> implements IDiscussService {

    @Autowired
    private DiscussMapper discussMapper;

    @Override
    public Discuss selectByKey(Integer id) {
        return discussMapper.selectByKey(id);
    }


    @Override
    public List<Discuss> selectLatestList(Integer limit) {
        return discussMapper.selectLatestList(limit);
    }

    @Override
    public Integer deleteByBlog(Integer blogId) {
        return discussMapper.deleteByBlog(blogId);
    }
}
