package com.xiaoniucr.xy.service.impl;

import com.xiaoniucr.xy.entity.AlbumImage;
import com.xiaoniucr.xy.mapper.AlbumImageMapper;
import com.xiaoniucr.xy.service.IAlbumImageService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Album photo service
 * implementation class
 */
@Service
public class AlbumImageServiceImpl extends ServiceImpl<AlbumImageMapper, AlbumImage> implements IAlbumImageService {

    @Autowired
    private AlbumImageMapper albumImageMapper;

    @Override
    public List<AlbumImage> queryList(Map map) {
        return albumImageMapper.queryList(map);
    }

    @Override
    public int queryTotal(Map map) {
        return albumImageMapper.queryTotal(map);
    }

    @Override
    public int batchDelete(List<Integer> ids) {
        return albumImageMapper.deleteBatchIds(ids);
    }

    @Override
    public List<AlbumImage> selectByAlbum(Integer albumId) {
        return albumImageMapper.selectByAlbum(albumId);
    }
}
