package com.xiaoniucr.xy.mapper;

import com.xiaoniucr.xy.entity.Album;
import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;
import java.util.Map;

/**
 * Album Mapper interface
 */
public interface AlbumMapper extends BaseMapper<Album> {

    Album selectByKey(@Param(value = "id") Integer id);

    List<Album> queryList(Map map);

    int queryTotal(Map map);

    List<Album> selectByCid(@Param(value = "categoryId")Integer categoryId);


    /**
     * 查上一个相册
     * @param id
     * @return
     */
    Album selectPreAlbum(@Param(value = "id") Integer id);

    /**
     * 查下一个相册
     * @param id
     * @return
     */
    Album selectNextAlbum(@Param(value = "id") Integer id);


    /**
     * 获取最新的N个相册
     * @param limit
     * @return
     */
    List<Album> selectLatestList(@Param(value = "limit") Integer limit);


    /**
     * 查评论量最多的N个相册
     * @param limit
     * @return
     */
    List<Album> selectDiscussNumberTopList(@Param(value = "limit") Integer limit);


    /**
     * 获取点赞最多的N个相册
     * @param limit
     * @return
     */
    List<Album> selectLikeTopList(@Param(value = "limit") Integer limit);


    /**
     * 查点击量最多的N个相册
     * @param limit
     * @return
     */
    List<Album> selectClickTopList(@Param(value = "limit")Integer limit);



}
