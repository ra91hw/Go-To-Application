package com.xiaoniucr.xy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.xiaoniucr.xy.entity.Banner;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**

 *  Banner Mapper interface

 */
public interface BannerMapper extends BaseMapper<Banner> {

    List<Banner> queryList(Map map);

    int queryTotal(Map map);

    List<Banner> selectTopNewList(@Param(value = "limit") Integer limit);

}
