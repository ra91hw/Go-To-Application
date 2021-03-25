package com.xiaoniucr.xy.service.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.xiaoniucr.xy.entity.Notice;
import com.xiaoniucr.xy.mapper.NoticeMapper;
import com.xiaoniucr.xy.service.INoticeService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 *Notice service
 *implementation class
 */
@Service
public class NoticeServiceImpl extends ServiceImpl<NoticeMapper, Notice> implements INoticeService {

    @Autowired
    private NoticeMapper noticeMapper;


    @Override
    public List<Notice> queryList(Map map) {
        return noticeMapper.queryList(map);
    }

    @Override
    public int queryTotal(Map map) {
        return noticeMapper.queryTotal(map);
    }

    @Override
    public List<Notice> selectLatestList(Integer limit) {
        return noticeMapper.selectLatestList(limit);
    }
}
