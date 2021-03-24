package com.xiaoniucr.xy.web.admin;


import com.xiaoniucr.xy.core.base.BaseController;
import com.xiaoniucr.xy.core.json.JSONReturn;
import com.xiaoniucr.xy.core.page.Page;
import com.xiaoniucr.xy.core.page.PageQuery;
import com.xiaoniucr.xy.entity.Notice;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.Date;
import java.util.List;
import java.util.Map;


/**
 * Announcement manager Front controller
 */
@Controller
@RequestMapping("/admin/notice")
public class NoticeManagerController extends BaseController {


    /**
     * Go to the announcement list page
     * @return
     */
    @RequestMapping("")
    public String toNoticeManager(){
        return "/admin/notice/list";
    }


    @RequestMapping("/list")
    @ResponseBody
    public Page list(@RequestParam Map<String,Object> params){

        PageQuery query = new PageQuery(params);
        List<Notice> data = iNoticeService.queryList(query);
        int total = iNoticeService.queryTotal(query);
        Page page = new Page(data,total);
        return page;
    }



    @RequestMapping("/edit")
    public String edit(HttpServletRequest request, ModelMap map){

        String id = request.getParameter("id");
        if(!StringUtils.isEmpty(id)){
            Notice notice = iNoticeService.selectById(Integer.valueOf(id));
            map.addAttribute("notice",notice);
        }
        return "/admin/notice/edit";
    }


    @RequestMapping("/view")
    public String view(HttpServletRequest request, ModelMap map){

        String id = request.getParameter("id");
        if(!StringUtils.isEmpty(id)){
            Notice notice = iNoticeService.selectById(Integer.valueOf(id));
            map.addAttribute("notice",notice);
        }
        return "/admin/notice/view";
    }


    /**
     * Post Announcement
     *
     * @return
     */
    @RequestMapping(value = "/post")
    @ResponseBody
    public JSONReturn post(@RequestBody Notice notice) {
        Date date = new Date();
        notice.setCreateTime(date);
        notice.setUpdateTime(date);
        iNoticeService.insert(notice);
        return JSONReturn.buildSuccess("Announcement issued successfully！");
    }


    @RequestMapping(value = "/update")
    @ResponseBody
    public JSONReturn update(@RequestBody Notice notice){

        notice.setUpdateTime(new Date());
        iNoticeService.updateById(notice);
        return JSONReturn.buildSuccess("Announcement Edit Successfully！");
    }


    @RequestMapping(value = "/remove")
    @ResponseBody
    public JSONReturn remove(@RequestBody Map map){

        Integer id = Integer.valueOf(map.get("id").toString());
        iNoticeService.deleteById(id);
        return JSONReturn.buildSuccess("Announcement deleted successfully！");
    }


}

