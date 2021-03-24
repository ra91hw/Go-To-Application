package com.xiaoniucr.xy.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.xiaoniucr.xy.entity.Link;
import com.xiaoniucr.xy.mapper.LinkMapper;
import com.xiaoniucr.xy.service.ILinkService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 *Link service
 *implementation class
 */
@Service
public class LinkServiceImpl extends ServiceImpl<LinkMapper, Link> implements ILinkService {

    @Autowired
    private LinkMapper linkMapper;

    @Override
    public List<Link> queryList(Map map) {
        return linkMapper.queryList(map);
    }

    @Override
    public int queryTotal(Map map) {
        return linkMapper.queryTotal(map);
    }

    @Override
    public List<Link> selectAll() {
        return linkMapper.selectAll();
    }

}
