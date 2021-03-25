package com.xiaoniucr.xy.service;

import com.baomidou.mybatisplus.service.IService;
import com.xiaoniucr.xy.entity.Banner;

import java.util.List;
import java.util.Map;


/**
 * Banner Service interface
 */
public interface IBannerService extends IService<Banner> {

    List<Banner> queryList(Map map);

    int queryTotal(Map map);

    List<Banner> selectTopNewList(Integer limit);



}
