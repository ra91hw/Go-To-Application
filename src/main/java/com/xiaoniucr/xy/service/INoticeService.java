package com.xiaoniucr.xy.service;

import com.baomidou.mybatisplus.service.IService;
import com.xiaoniucr.xy.entity.Notice;

import java.util.List;
import java.util.Map;

/**
 * Notice Service interface
 */
public interface INoticeService extends IService<Notice> {

    List<Notice> queryList(Map map);

    int queryTotal(Map map);

    List<Notice> selectLatestList(Integer limit);

}
