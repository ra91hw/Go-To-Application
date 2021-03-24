package com.xiaoniucr.xy.mapper;

import com.xiaoniucr.xy.entity.AlbumImage;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Album photo Mapper interface
 */
public interface AlbumImageMapper extends BaseMapper<AlbumImage> {

    List<AlbumImage> queryList(Map map);

    int queryTotal(Map map);

    List<AlbumImage> selectByAlbum(@Param(value = "albumId")Integer albumId);


}
