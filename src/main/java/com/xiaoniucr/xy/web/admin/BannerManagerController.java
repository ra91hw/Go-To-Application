package com.xiaoniucr.xy.web.admin;


import com.xiaoniucr.xy.core.base.BaseController;
import com.xiaoniucr.xy.core.json.JSONReturn;
import com.xiaoniucr.xy.core.page.Page;
import com.xiaoniucr.xy.core.page.PageQuery;
import com.xiaoniucr.xy.entity.Banner;
import com.xiaoniucr.xy.utils.FileUtils;
import com.xiaoniucr.xy.utils.PropertiesUtils;
import com.xiaoniucr.xy.utils.UUIDUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Banner Front controller
 */
@Controller
@RequestMapping("/admin/banner")
public class BannerManagerController extends BaseController {


    @RequestMapping("")
    public String toBannerManager(){
        return "/admin/banner/list";
    }


    /**
     * Get carousel list
     * @param params
     * @return
     */
    @RequestMapping("/list")
    @ResponseBody
    public Page list(@RequestParam Map<String,Object> params){

        PageQuery query = new PageQuery(params);
        List<Banner> data = iBannerService.queryList(query);
        int total = iBannerService.queryTotal(query);
        Page page = new Page(data,total);
        return page;
    }

    @RequestMapping("/edit")
    public String edit(HttpServletRequest request, ModelMap map){

        String id = request.getParameter("id");

        if(!StringUtils.isEmpty(id)){
            Banner banner = iBannerService.selectById(Integer.valueOf(id));
            map.put("banner",banner);
        }
        return "/admin/banner/edit";

    }


    @RequestMapping(value = "/save", method = RequestMethod.POST)
    @ResponseBody
    public JSONReturn save(HttpServletRequest request){

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        // Receive the file stream through the parameter name in the form (file.getInputStream() can be used to receive the input stream)
        MultipartFile multipartFile = multipartRequest.getFile("file");
        // Receive other form parameters
        String title = multipartRequest.getParameter("title");
        String link = multipartRequest.getParameter("link");
        String bannerPath = PropertiesUtils.getValue("banner.path");
        String fileSuffix = FileUtils.getSuffix(multipartFile.getOriginalFilename());
        String newFileName = UUIDUtils.getUUID() + fileSuffix;
        String newFilePath = bannerPath  + newFileName;
        File dest = new File(bannerPath);
        if(!dest.exists()){
            dest.mkdirs();
        }
        // Create file instance
        File uploadFile = new File(newFilePath);
        // Conducive to FileCopyUtils.copy() in spring to copy files
        try {
            FileCopyUtils.copy(multipartFile.getBytes(), uploadFile);
        } catch (IOException e) {
            return JSONReturn.buildFailure("Save failed！");
        }
        Banner banner = new Banner();
        banner.setTitle(title);
        banner.setLink(link);
        banner.setUrl("/ipicimg/banner/"+newFileName);
        banner.setStatus(1);
        Date date = new Date();
        banner.setCreateTime(date);
        banner.setUpdateTime(date);
        iBannerService.insert(banner);
        return JSONReturn.buildSuccess("Save success！");
    }



    @RequestMapping(value = "/update", method = RequestMethod.POST)
    @ResponseBody
    public JSONReturn update(HttpServletRequest request){


        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        // Receive the file stream through the parameter name in the form (file.getInputStream() can be used to receive the input stream)
        MultipartFile multipartFile = multipartRequest.getFile("file");
        // Receive other form parameters
        Integer id = Integer.valueOf(multipartRequest.getParameter("id"));
        String title = multipartRequest.getParameter("title");
        String link = multipartRequest.getParameter("link");
        Banner banner = iBannerService.selectById(id);
        if(multipartFile.getSize()>0){
            String bannerPath = PropertiesUtils.getValue("banner.path");
            String fileSuffix = FileUtils.getSuffix(multipartFile.getOriginalFilename());
            String newFileName = UUIDUtils.getUUID() + fileSuffix;
            String newFilePath = bannerPath  + newFileName;
            File dest = new File(bannerPath);
            if(!dest.exists()){
                dest.mkdirs();
            }
            // Create file instance
            File uploadFile = new File(newFilePath);
            // Conducive to FileCopyUtils.copy() in spring to copy files
            try {
                FileCopyUtils.copy(multipartFile.getBytes(), uploadFile);
            } catch (IOException ex) {
                return JSONReturn.buildFailure("Save failed！");
            }
            banner.setUrl("/ipicimg/banner/"+newFileName);
        }
        banner.setTitle(title);
        banner.setLink(link);
        banner.setUpdateTime(new Date());
        iBannerService.updateById(banner);
        return JSONReturn.buildSuccess("Modify the success！");
    }


    @RequestMapping("/delete")
    @ResponseBody
    public JSONReturn delete(@RequestBody Banner banner){

        iBannerService.deleteById(banner.getId());
        return JSONReturn.buildSuccess("Loop display deleted successfully！");
    }



    /**
     * Turn on and off loop play
     * @param banner
     * @return
     */
    @ResponseBody
    @RequestMapping("/audit")
    public JSONReturn audit(@RequestBody Banner banner){

        Banner ban = iBannerService.selectById(banner.getId());
        ban.setStatus(banner.getStatus());
        iBannerService.updateById(ban);
        return JSONReturn.buildSuccess("Operation is successful！");
    }



}

