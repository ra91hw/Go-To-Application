package com.xiaoniucr.xy.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.xiaoniucr.xy.entity.Banner;
import com.xiaoniucr.xy.mapper.BannerMapper;
import com.xiaoniucr.xy.service.IBannerService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 *Banner service
 *implementation class
 */
@Service
public class BannerServiceImpl extends ServiceImpl<BannerMapper, Banner> implements IBannerService {

    @Autowired
    private BannerMapper bannerMapper;

    @Override
    public List<Banner> queryList(Map map) {
        return bannerMapper.queryList(map);
    }

    @Override
    public int queryTotal(Map map) {
        return bannerMapper.queryTotal(map);
    }

    @Override
    public List<Banner> selectTopNewList(Integer limit) {
        return bannerMapper.selectTopNewList(limit);
    }
}
