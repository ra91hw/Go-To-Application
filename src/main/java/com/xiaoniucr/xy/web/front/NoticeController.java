package com.xiaoniucr.xy.web.front;


import com.xiaoniucr.xy.core.base.BaseController;
import com.xiaoniucr.xy.entity.Album;
import com.xiaoniucr.xy.entity.Discuss;
import com.xiaoniucr.xy.entity.Link;
import com.xiaoniucr.xy.entity.Notice;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import java.util.List;

/**
 * Announcement Front controller
 */
@Controller
public class NoticeController extends BaseController {

    @RequestMapping("/notice/view/{id}.html")
    public String view(@PathVariable(value = "id")Integer id, ModelMap map){

        Notice notice = iNoticeService.selectById(id);
        if(notice==null){
            throw new RuntimeException("Announcement does not exist！");
        }
        map.put("notice",notice);

        //5 Announcements
        List<Notice> noticeList = iNoticeService.selectLatestList(5);
        map.put("noticeList",noticeList);

        //Most liked blog posts
        List<Album> likeTopList = iAlbumService.selectLikeTopList(5);
        map.put("likeTopList",likeTopList);

        //Get the latest few comments
        List<Discuss> latestDiscussList = iDiscussService.selectLatestList(5);
        map.put("latestDiscussList",latestDiscussList);

        //Get all the links
        List<Link> linkList = iLinkService.selectAll();
        map.put("linkList",linkList);

        return "/front/notice/info";
    }

}

