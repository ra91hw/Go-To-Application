package com.xiaoniucr.xy.service;

import com.baomidou.mybatisplus.service.IService;
import com.xiaoniucr.xy.entity.Link;

import java.util.List;
import java.util.Map;


/**
 * link Service interface
 */
public interface ILinkService extends IService<Link> {

    /**
     *Query Link
     * @param map
     * @return
     */
    List<Link> queryList(Map map);

    /**
     * Query the total number of links
     * @param map
     * @return
     */
    int queryTotal(Map map);


    /**
     * Query all links
     * @return
     */
    List<Link> selectAll();



}
