package com.xiaoniucr.xy.service.impl;

import com.xiaoniucr.xy.entity.Album;
import com.xiaoniucr.xy.mapper.AlbumMapper;
import com.xiaoniucr.xy.service.IAlbumService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

/**
 * Album service
 * implementation class
 */
@Service
public class AlbumServiceImpl extends ServiceImpl<AlbumMapper, Album> implements IAlbumService {

    @Autowired
    private AlbumMapper albumMapper;

    @Override
    public Album selectByKey(Integer id) {
        return albumMapper.selectByKey(id);
    }

    @Override
    public List<Album> queryList(Map map) {
        return albumMapper.queryList(map);
    }

    @Override
    public int queryTotal(Map map) {
        return albumMapper.queryTotal(map);
    }

    @Override
    public List<Album> selectByCid(Integer categoryId) {

        return albumMapper.selectByCid(categoryId);
    }

    @Override
    public Album selectPreAlbum(Integer id) {
        return albumMapper.selectPreAlbum(id);
    }

    @Override
    public Album selectNextAlbum(Integer id) {
        return albumMapper.selectNextAlbum(id);
    }

    @Override
    public List<Album> selectLatestList(Integer limit) {
        return albumMapper.selectLatestList(limit);
    }

    @Override
    public List<Album> selectDiscussNumberTopList(Integer limit) {
        return albumMapper.selectDiscussNumberTopList(limit);
    }

    @Override
    public List<Album> selectLikeTopList(Integer limit) {
        return albumMapper.selectLikeTopList(limit);
    }

    @Override
    public List<Album> selectClickTopList(Integer limit) {
        return albumMapper.selectClickTopList(limit);
    }
}
