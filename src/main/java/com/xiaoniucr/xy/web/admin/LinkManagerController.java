package com.xiaoniucr.xy.web.admin;


import com.xiaoniucr.xy.core.base.BaseController;
import com.xiaoniucr.xy.core.json.JSONReturn;
import com.xiaoniucr.xy.core.page.Page;
import com.xiaoniucr.xy.core.page.PageQuery;
import com.xiaoniucr.xy.entity.Link;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * link manager Front controller
 */
@Controller
@RequestMapping("/admin/link")
public class LinkManagerController extends BaseController {


    /**
     * Go to the link list page
     * @return
     */
    @RequestMapping("")
    public String toNoticeManager(){

        return "/admin/link/list";
    }


    @RequestMapping("/list")
    @ResponseBody
    public Page list(@RequestParam Map<String,Object> params){

        PageQuery query = new PageQuery(params);
        List<Link> data = iLinkService.queryList(query);
        int total = iLinkService.queryTotal(query);
        Page page = new Page(data,total);
        return page;
    }



    @RequestMapping("/save")
    @ResponseBody
    public JSONReturn save(@RequestBody Link link){

        link.setCreateTime(new Date());
        iLinkService.insert(link);
        return JSONReturn.buildSuccess("Friendship chain saved successfully！");

    }


    @RequestMapping("/update")
    @ResponseBody
    public JSONReturn update(@RequestBody Link link){


        link.setUpdateTime(new Date());
        iLinkService.updateById(link);
        return JSONReturn.buildSuccess("Friendship chain updated successfully！");

    }


    @RequestMapping("/remove")
    @ResponseBody
    public JSONReturn remove(@RequestBody Map<String,Object> params){

        Integer id = Integer.parseInt(params.get("id").toString());
        iLinkService.deleteById(id);
        return JSONReturn.buildSuccess("Friendship chain deleted successfully！");

    }




}

