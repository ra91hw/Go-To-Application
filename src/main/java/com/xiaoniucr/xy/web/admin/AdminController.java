package com.xiaoniucr.xy.web.admin;

import com.xiaoniucr.xy.core.base.BaseController;
import com.xiaoniucr.xy.core.json.JSONReturn;
import com.xiaoniucr.xy.entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
@Controller
@RequestMapping("/admin")
public class AdminController extends BaseController {


    @RequestMapping("/index")
    public String index(){
        return "/admin/index";
    }


    @RequestMapping("/login.html")
    public String tologin(){

        User admin = (User) getSession("admin");
        if(admin!=null){
            return "admin/index";
        }
        return "admin/login";
    }


    @RequestMapping("/login")
    @ResponseBody
    public JSONReturn login(@RequestBody User u, HttpServletRequest request){

        User admin = iUserService.selectByUsername(u.getUsername());
        if(admin==null){
            return JSONReturn.buildFailure("The user name does not exist！");
        }
        if(!u.getPassword().equals(admin.getPassword())){
            return JSONReturn.buildFailure("Please try again！");
        }
        if(admin.getType() != 1){
            return JSONReturn.buildFailure("Insufficient permissions！");
        }
        request.getSession().setAttribute("admin",admin);
        return JSONReturn.buildSuccess("Login successful！");
    }

    @RequestMapping("/logout")
    public String logout(HttpSession session){

        session.removeAttribute("admin");
        return "/admin/login";
    }

}
