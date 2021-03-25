package com.xiaoniucr.xy.web.front;

import com.xiaoniucr.xy.core.base.BaseController;
import com.xiaoniucr.xy.core.constant.SessionKey;
import com.xiaoniucr.xy.core.json.JSONReturn;
import com.xiaoniucr.xy.core.page.Page;
import com.xiaoniucr.xy.core.page.PageQuery;
import com.xiaoniucr.xy.entity.*;
import com.xiaoniucr.xy.utils.FileUtils;
import com.xiaoniucr.xy.utils.PropertiesUtils;
import com.xiaoniucr.xy.utils.UUIDUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * User Front controller
 */
@Controller
public class UserController extends BaseController {


    @RequestMapping("/user/profile.html")
    public String profile(){
        return "/front/user/profile";
    }


    /**
     * Go to my album page
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("/user/album.html")
    public String toAlbum(HttpServletRequest request,ModelMap map){

        return "front/user/album/album";
    }


    /**
     * Get a list of album data
     * @param params
     * @return
     */
    @RequestMapping("/user/album")
    @ResponseBody
    public Page album(@RequestParam Map<String,Object> params){

        PageQuery query = new PageQuery(params);
        List<Album> data = iAlbumService.queryList(query);
        int total = iAlbumService.queryTotal(query);
        Page page = new Page(data,total);
        return page;
    }


    /**
     * Delete album
     * @param params
     * @return
     */
    @RequestMapping("/user/album/remove")
    @ResponseBody
    public JSONReturn albumRemove(@RequestBody Map<String,Integer> params){


        Integer id = params.get("id");
        List<AlbumImage> imageList = iAlbumImageService.selectByAlbum(id);
        if(imageList != null && imageList.size() >0 ){
            return JSONReturn.buildFailure("Please delete the photos in the album first！");
        }
        iAlbumService.deleteById(id);
        return JSONReturn.buildSuccess("Successfully deleted！");
    }


    /**
     * Edit album
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("/user/album/edit.html")
    public String albumEdit(HttpServletRequest request, ModelMap map){

        Integer id = request.getParameter("id") == null ? null : Integer.parseInt(request.getParameter("id"));
        //Album classification
        List<Category> categoryList = iCategoryService.selectAll();
        map.put("categoryList",categoryList);
        if(id != null){
            Album album = iAlbumService.selectById(id);
            map.put("album",album);
        }
        return "front/user/album/edit";

    }



    /**
     * Album view photos
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("/user/album/piclist.html")
    public String toPiclist(HttpServletRequest request, ModelMap map){

        Integer id = request.getParameter("id") == null ? null : Integer.parseInt(request.getParameter("id"));
        //Check photo album
        Album album = iAlbumService.selectByKey(id);
        map.put("album",album);
        return "front/user/album/piclist";

    }



    /**
     * Get the photo data under the album
     * @param params
     * @return
     */
    @RequestMapping("/user/album/piclist")
    @ResponseBody
    public Page piclist(@RequestParam Map<String,Object> params){

        PageQuery query = new PageQuery(params);
        List<AlbumImage> data = iAlbumImageService.queryList(query);
        int total = iAlbumImageService.queryTotal(query);
        Page page = new Page(data,total);
        return page;
    }

    /**
     * Delete photos in bulk
     * @return
     */
    @RequestMapping("/user/album/batchDeletePic")
    @ResponseBody
    public JSONReturn batchDeletePic(@RequestBody List<Integer> ids){

        iAlbumImageService.deleteBatchIds(ids);
        return JSONReturn.buildSuccess("Batch delete successfully！");
    }


    /**
     * Delete photos in bulk
     * @return
     */
    @RequestMapping("/user/album/deletePic")
    @ResponseBody
    public JSONReturn deletePic(@RequestBody Map<String,Integer> map){

        Integer id = map.get("id");
        iAlbumImageService.deleteById(id);
        return JSONReturn.buildSuccess("successfully deleted！");
    }




    /**
     * Album view photos
     * @param request
     * @param map
     * @return
     */
    @RequestMapping("/user/album/upload.html")
    public String toUpload(HttpServletRequest request, ModelMap map){

        Integer id = request.getParameter("id") == null ? null : Integer.parseInt(request.getParameter("id"));
        Album album = iAlbumService.selectByKey(id);
        map.put("album",album);
        return "front/user/album/upload";

    }


    @RequestMapping(value = "/user/album/batchUpload")
    @ResponseBody
    public JSONReturn upload(@RequestParam MultipartFile[] files, @RequestParam(value = "albumId")Integer albumId){

        //Save Picture
        if(files.length>0){
            if(files.length > 9){
                return JSONReturn.buildFailure("Add up to 9 photos！");
            }
            String postPath = PropertiesUtils.getValue("album.path");
            for(MultipartFile multipartFile : files){
                String fileSuffix = FileUtils.getSuffix(multipartFile.getOriginalFilename());
                String newFileName = UUIDUtils.getUUID() + fileSuffix;
                String newFilePath = postPath  + newFileName;
                File dest = new File(postPath);
                if(!dest.exists()){
                    dest.mkdirs();
                }
                // Create file instance
                File uploadFile = new File(newFilePath);
                // Conducive to FileCopyUtils.copy() in spring to copy files
                try {
                    FileCopyUtils.copy(multipartFile.getBytes(), uploadFile);
                    AlbumImage image = new AlbumImage();
                    image.setAlbumId(albumId);
                    image.setAlbumImage("/ipicimg/album/"+newFileName);
                    Date date = new Date();
                    image.setCreateTime(date);
                    image.setUpdateTime(date);
                    iAlbumImageService.insert(image);
                } catch (IOException ex) {
                    return JSONReturn.buildFailure("Upload failed！");
                }
            }
            //Update the number of photos
            Album album = iAlbumService.selectByKey(albumId);
            album.setTotalNumber(album.getTotalNumber() + files.length);
            album.setUpdateTime(new Date());
            iAlbumService.updateById(album);
        }
        return JSONReturn.buildSuccess("Uploaded successfully！");
    }



    /**
     * New album
     *
     * @return
     */
    @RequestMapping(value = "/user/album/save")
    @ResponseBody
    public JSONReturn save(HttpServletRequest request) {

        User user = (User) getSession(SessionKey.CURRENT_USER);
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        // Receive the file stream through the parameter name in the form (file.getInputStream() can be used to receive the input stream)
        MultipartFile multipartFile = multipartRequest.getFile("file");
        // Receive other form parameters
        Integer categoryId = Integer.parseInt(multipartRequest.getParameter("categoryId"));
        String title = multipartRequest.getParameter("title");
        Integer status = Integer.parseInt(multipartRequest.getParameter("status"));
        String description = multipartRequest.getParameter("description");
        String albumPath = PropertiesUtils.getValue("album.cover.path");

        String fileSuffix = FileUtils.getSuffix(multipartFile.getOriginalFilename());
        String newFileName = UUIDUtils.getUUID() + fileSuffix;
        String newFilePath = albumPath  + newFileName;
        File dest = new File(albumPath);
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
        Album album = new Album();
        album.setCategoryId(categoryId);
        album.setTitle(title);
        album.setUserId(user.getId());
        album.setCover("/ipicimg/album/cover/"+newFileName);
        album.setAgreeNumber(0);
        album.setDiscussNumber(0);
        album.setClickNumber(0);
        album.setTotalNumber(0);
        album.setStatus(status);
        album.setDescription(description);
        Date date = new Date();
        album.setCreateTime(date);
        album.setUpdateTime(date);
        iAlbumService.insert(album);
        return JSONReturn.buildSuccess("Your album has been added successfully！");

    }


    /**
     * Album editing
     *
     * @return
     */
    @RequestMapping(value = "/user/album/update")
    @ResponseBody
    public JSONReturn update(HttpServletRequest request) {

        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        // Receive the file stream through the parameter name in the form (file.getInputStream() can be used to receive the input stream)
        MultipartFile multipartFile = multipartRequest.getFile("file");
        // Receive other form parameters
        Integer id = Integer.valueOf(multipartRequest.getParameter("id"));
        Integer categoryId = Integer.parseInt(multipartRequest.getParameter("categoryId"));
        String title = multipartRequest.getParameter("title");
        Integer status = Integer.parseInt(multipartRequest.getParameter("status"));
        String description = multipartRequest.getParameter("description");
        Album album = iAlbumService.selectById(id);
        if(multipartFile.getSize()>0){
            String blogPath = PropertiesUtils.getValue("album.cover.path");
            String fileSuffix = FileUtils.getSuffix(multipartFile.getOriginalFilename());
            String newFileName = UUIDUtils.getUUID() + fileSuffix;
            String newFilePath = blogPath  + newFileName;
            File dest = new File(blogPath);
            if(!dest.exists()){
                dest.mkdirs();
            }
            // Create file instance
            File uploadFile = new File(newFilePath);
            // Conducive to FileCopyUtils.copy() in spring to copy files
            try {
                FileCopyUtils.copy(multipartFile.getBytes(), uploadFile);
                album.setCover("/ipicimg/album/cover/"+newFileName);
            } catch (IOException e) {
                return JSONReturn.buildFailure("Save failed！");
            }
        }
        album.setCategoryId(categoryId);
        album.setTitle(title);
        album.setTitle(title);
        album.setStatus(status);
        album.setDescription(description);
        Date date = new Date();
        album.setUpdateTime(date);
        iAlbumService.updateById(album);
        return JSONReturn.buildSuccess("Your album has been edited successfully！");
    }


    /**
     * Go to the password modification page
     * @return
     */
    @RequestMapping("/user/updatePwd.html")
    public String updatePwd(){
        return "/front/user/updatePwd";
    }

    /**
     * sign out
     * @return
     */
    @RequestMapping("/user/logout")
    public String logout(){
        removeSession("user");
        return "redirect:/index.html";
    }

    /**
     * Modify user basic information
     * @param request
     * @return
     */
    @RequestMapping("/user/updateBasicInfo")
    @ResponseBody
    public JSONReturn updateBasicInfo(HttpServletRequest request){

        User user = (User) getSession(SessionKey.CURRENT_USER);
        MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
        // Receive the file stream through the parameter name in the form (file.getInputStream() can be used to receive the input stream)
        MultipartFile multipartFile = multipartRequest.getFile("file");
        // Receive other form parameters
        String nickname = multipartRequest.getParameter("nickname");
        String telphone = multipartRequest.getParameter("telphone");
        String email = multipartRequest.getParameter("email");
        String school = multipartRequest.getParameter("school");
        String professional = multipartRequest.getParameter("professional");
        String introduce = multipartRequest.getParameter("introduce");
        if(multipartFile.getSize()>0){
            String logoPath = PropertiesUtils.getValue("avatar.path");
            String fileSuffix = FileUtils.getSuffix(multipartFile.getOriginalFilename());
            String newFileName = UUIDUtils.getUUID() + fileSuffix;
            String newFilePath = logoPath  + newFileName;
            File dest = new File(logoPath);
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
            user.setAvatar("/iphotoimg/avatar/"+newFileName);
        }
        user.setNickname(nickname);
        user.setTelphone(telphone);
        user.setEmail(email);
        user.setUpdateTime(new Date());
        user.setSchool(school);
        user.setProfessional(professional);
        user.setIntroduce(introduce);
        iUserService.updateById(user);
        setSession("user",user);
        return JSONReturn.buildSuccess("Personal information has been modified successfully！");

    }


    /**
     * Password modification and save
     * @param map
     * @param session
     * @return
     */
    @RequestMapping("/user/updatePwd")
    @ResponseBody
    public JSONReturn updatePwd(@RequestBody Map<String,String> map, HttpSession session){


        String orginPwd = map.get("orginPwd");
        String newPwd = map.get("newPwd");
        User user = (User) session.getAttribute("user");
        if(!orginPwd.equals(user.getPassword())){
            return JSONReturn.buildFailure("Original password error！");
        }
        user.setPassword(newPwd);
        iUserService.updateById(user);
        session.removeAttribute("user");
        return JSONReturn.buildSuccess("Password changed successfully, please log in again！");
    }


    /**
     * Get user information, whether to log in
     * @return
     */
    @RequestMapping("/user/getUser")
    @ResponseBody
    public JSONReturn getUser(){

        User user = (User) getSession("user");
        return JSONReturn.buildSuccess(user);

    }
}
