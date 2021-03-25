package com.xiaoniucr.xy.web.admin;


import com.xiaoniucr.xy.core.base.BaseController;
import com.xiaoniucr.xy.core.json.JSONReturn;
import com.xiaoniucr.xy.core.page.Page;
import com.xiaoniucr.xy.core.page.PageQuery;
import com.xiaoniucr.xy.entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;
import java.util.Map;


 /**
 * User manager Front controller
 */
@Controller
@RequestMapping("/admin/user")
public class UserManagerController extends BaseController {


    /**
     * Go to user list page
     * @return
     */
    @RequestMapping("")
    public String toUserManager(){
        return "/admin/user/list";
    }


    @RequestMapping("/list")
    @ResponseBody
    public Page list(@RequestParam Map<String,Object> params){

        PageQuery query = new PageQuery(params);
        List<User> data = iUserService.queryList(query);
        int total = iUserService.queryTotal(query);
        Page page = new Page(data,total);
        return page;
    }



    @RequestMapping("/edit")
    public String edit(){
        return "/admin/user/edit";
    }


    /**
     * register
     * @param user
     * @return
     */
    @RequestMapping("/save")
    @ResponseBody
    public JSONReturn save(@RequestBody User user){

        User u = iUserService.selectByUsername(user.getUsername());
        if(u!=null){
            return JSONReturn.buildFailure("The user name already exists！");
        }
        Date date = new Date();
        user.setCreateTime(date);
        user.setUpdateTime(date);
        //normal
        user.setStatus(1);
        user.setPassword("123456");
        iUserService.insert(user);
        return JSONReturn.buildSuccess("User Added Successfully！");
    }


    /**
     * register
     * @param user
     * @return
     */
    @RequestMapping("/update")
    @ResponseBody
    public JSONReturn update(@RequestBody User user){

        Date date = new Date();
        user.setUpdateTime(date);
        iUserService.updateById(user);
        return JSONReturn.buildSuccess("The user modified successfully！");
    }


    /**
     * Obtain user information according to user Id
     * @param map
     * @return
     */
    @RequestMapping("/getUserById")
    @ResponseBody
    public JSONReturn getUserById(Map<String,Integer> map){

        Integer id = map.get("id");
        User user = iUserService.selectById(id);
        return JSONReturn.buildSuccess(user);

    }


    /**
     * delete users
     * @param user
     * @return
     */
    @RequestMapping("/remove")
    @ResponseBody
    public JSONReturn remove(@RequestBody User user){

        iUserService.deleteById(user.getId());
        return JSONReturn.buildSuccess("Delete the success！");
    }

    /**
     * User ban
     * @param user
     * @return
     */
    @ResponseBody
    @RequestMapping("/audit")
    public JSONReturn audit(@RequestBody User user){

        User u = iUserService.selectById(user.getId());
        u.setStatus(user.getStatus());
        iUserService.updateById(u);
        return JSONReturn.buildSuccess("Operation is successful！");
    }


    /**
     * Reset Password
     * @param user
     * @return
     */
    @RequestMapping("/reset")
    @ResponseBody
    public JSONReturn reset(@RequestBody User user){

        User u = iUserService.selectById(user.getId());
        u.setPassword("123456");
        iUserService.updateById(u);
        return JSONReturn.buildSuccess("Password reset successfully！");
    }







}

