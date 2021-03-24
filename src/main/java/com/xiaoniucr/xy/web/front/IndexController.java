package com.xiaoniucr.xy.web.front;

import com.xiaoniucr.xy.core.base.BaseController;
import com.xiaoniucr.xy.entity.*;
import org.apache.commons.collections.CollectionUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;


/**
 * Index Front controller
 */
@Controller
public class IndexController extends BaseController {

    @RequestMapping(value = {"","/","/index.html"})
    public String index(ModelMap map){


        //Get the loop player
        List<Banner> bannerList = iBannerService.selectTopNewList(4);
        map.put("bannerList",bannerList);

        //Most commented blog post
        List<Album> hotestAlbumList = iAlbumService.selectClickTopList(6);
        map.put("hotestAlbumList",hotestAlbumList);

        //The latest 6 blog posts
        List<Album> latestAlbumList = iAlbumService.selectLatestList(6);
        map.put("latestAlbumList",latestAlbumList);


        //5 Announcement
        List<Notice> noticeList = iNoticeService.selectLatestList(5);
        map.put("noticeList",noticeList);

        //like Top List
        List<Album> likeTopList = iAlbumService.selectLikeTopList(5);
        map.put("likeTopList",likeTopList);

        //Get the latest few comments
        List<Discuss> latestDiscussList = iDiscussService.selectLatestList(5);
        map.put("latestDiscussList",latestDiscussList);

        //Get all the links
        List<Link> linkList = iLinkService.selectAll();
        map.put("linkList",linkList);

        return "front/index";
    }
}
