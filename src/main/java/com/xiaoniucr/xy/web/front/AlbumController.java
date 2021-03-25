package com.xiaoniucr.xy.web.front;


import com.xiaoniucr.xy.core.json.JSONReturn;
import com.xiaoniucr.xy.core.page.Page;
import com.xiaoniucr.xy.core.page.PageQuery;
import com.xiaoniucr.xy.entity.*;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import com.xiaoniucr.xy.core.base.BaseController;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

/**
 * Album Front controller
 */
@Controller
public class AlbumController extends BaseController {


    /**
     * Album list page
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("/album.html")
    public String album(HttpServletRequest request, ModelMap map){

        String typeStr = request.getParameter("type");
        Integer type = null;
        Category category = null;
        if(typeStr != null && typeStr != ""){
            type = Integer.parseInt(typeStr);
            category = iCategoryService.selectById(type);
        }
        String currentPage = request.getParameter("pageNo");
        String wd = request.getParameter("wd");
        Integer pageNo = currentPage==null?null:Integer.valueOf(currentPage);
        PageQuery query = new PageQuery(pageNo);
        query.put("title",wd);
        query.put("status",0);
        query.put("categoryId",type);
        List<Album> albumList = iAlbumService.queryList(query);
        int total = iAlbumService.queryTotal(query);
        Page page = new Page(query.getPageNo(),albumList,total);
        map.put("page",page);
        map.put("wd",wd);
        map.put("type",type);
        map.put("category",category);
        return "front/album/list";
    }


    /**
     * Album photo list
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("/album/piclist.html")
    public String piclist(HttpServletRequest request, ModelMap map){

        Integer id = Integer.parseInt(request.getParameter("id"));
        String currentPage = request.getParameter("pageNo");
        String wd = request.getParameter("wd");
        Integer pageNo = currentPage==null?null:Integer.valueOf(currentPage);
        PageQuery query = new PageQuery(pageNo);
        query.put("title",wd);
        query.put("status",0);
        query.put("albumId",id);
        List<AlbumImage> imageList = iAlbumImageService.queryList(query);
        int total = iAlbumImageService.queryTotal(query);
        Page page = new Page(query.getPageNo(),imageList,total);
        map.put("page",page);
        map.put("wd",wd);

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

        Album album = iAlbumService.selectByKey(id);
        album.setClickNumber(album.getClickNumber() + 1);
        iAlbumService.updateById(album);
        map.put("album",album);

        //Previous, next
        Album preAlbum = iAlbumService.selectPreAlbum(id);
        Album nextAlbum = iAlbumService.selectNextAlbum(id);
        map.put("preAlbum",preAlbum);
        map.put("nextAlbum",nextAlbum);
        return "front/album/piclist";
    }


    @RequestMapping(value = "/album/discuss")
    @ResponseBody
    public JSONReturn discuss(@RequestBody Discuss discuss){

        User user = (User) getSession("user");
        //Save comment
        discuss.setUserId(user.getId());
        Date now = new Date();
        discuss.setCreateTime(now);
        discuss.setUpdateTime(now);
        iDiscussService.insert(discuss);
        discuss = iDiscussService.selectByKey(discuss.getId());
        //Number of comments +1
        Album album = iAlbumService.selectByKey(discuss.getAlbumId());
        album.setDiscussNumber(album.getDiscussNumber() +1);
        iAlbumService.updateById(album);
        return JSONReturn.buildSuccess(discuss);
    }



    @RequestMapping(value = "/album/like")
    @ResponseBody
    public JSONReturn like(@RequestBody Like like){

        User user = (User) getSession("user");
        Integer albumId = like.getAlbumId();
        Like exist = iLikeService.selectByUserAndAlbum(user.getId(),albumId);
        if(exist != null){
            return JSONReturn.buildFailure("You've already clicked！");
        }
        //Save Like
        like.setUserId(user.getId());
        Date now = new Date();
        like.setCreateTime(now);
        like.setUpdateTime(now);
        iLikeService.insert(like);

        Album album = iAlbumService.selectByKey(albumId);
        album.setAgreeNumber(album.getAgreeNumber() +1);
        iAlbumService.updateById(album);
        return JSONReturn.buildSuccess("Successfully add likes！");
    }







}

