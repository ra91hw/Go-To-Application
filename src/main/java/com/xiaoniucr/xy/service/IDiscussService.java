package com.xiaoniucr.xy.service;

import com.baomidou.mybatisplus.service.IService;
import com.xiaoniucr.xy.entity.Discuss;

import java.util.List;


/**
 * Discuss Service interface
 */
public interface IDiscussService extends IService<Discuss> {

    Discuss selectByKey(Integer id);


    List<Discuss> selectLatestList(Integer limit);

    /**
     * Delete likes
     * @param blogId
     * @return
     */
    Integer deleteByBlog(Integer blogId);

}
