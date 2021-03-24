package com.xiaoniucr.xy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.xiaoniucr.xy.entity.Link;

import java.util.List;
import java.util.Map;

/**

 *  Link Mapper interface
 */
public interface LinkMapper extends BaseMapper<Link> {


    List<Link> queryList(Map map);

    int queryTotal(Map map);

    List<Link> selectAll();




}
