package com.xiaoniucr.xy.service;

import com.xiaoniucr.xy.entity.AlbumImage;
import com.baomidou.mybatisplus.service.IService;

import java.util.List;
import java.util.Map;

/**
 Photo Album Service interface
 */
public interface IAlbumImageService extends IService<AlbumImage> {

    List<AlbumImage> queryList(Map map);

    int queryTotal(Map map);

    /**
     * Delete photos in batch
     * @param ids
     * @return
     */
    int batchDelete(List<Integer> ids);

    /**
     * Check the album according to the album ID
     * @param albumId
     * @return
     */
    List<AlbumImage> selectByAlbum(Integer albumId);


}
