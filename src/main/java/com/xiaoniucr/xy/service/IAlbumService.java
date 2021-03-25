package com.xiaoniucr.xy.service;

import com.xiaoniucr.xy.entity.Album;
import com.baomidou.mybatisplus.service.IService;

import java.util.List;
import java.util.Map;


/**
 * Album Service interface
 */
public interface IAlbumService extends IService<Album> {


    Album selectByKey(Integer id);

    List<Album> queryList(Map map);

    int queryTotal(Map map);

    List<Album> selectByCid(Integer categoryId);


    /**
     * Check the last album
     * @param id
     * @return
     */
    Album selectPreAlbum(Integer id);

    /**
     * Check the nest album
     * @param id
     * @return
     */
    Album selectNextAlbum(Integer id);


    /**
     * Check the latest album
     * @param limit
     * @return
     */
    List<Album> selectLatestList(Integer limit);


    /**
     * Check the 5 most commented albums
     * @param limit
     * @return
     */
    List<Album> selectDiscussNumberTopList(Integer limit);


    /**
     * Get the most likes
     * @param limit
     * @return
     */
    List<Album> selectLikeTopList(Integer limit);


    /**
     * Check the N albums with the most clicks
     * @param limit
     * @return
     */
    List<Album> selectClickTopList(Integer limit);





}
