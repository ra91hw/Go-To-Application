package com.xiaoniucr.xy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.xiaoniucr.xy.entity.Notice;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 *  Notice Mapper interface
 */
public interface NoticeMapper extends BaseMapper<Notice> {

    List<Notice> queryList(Map map);

    int queryTotal(Map map);

    List<Notice> selectLatestList(@Param(value = "limit") Integer limit);


}
