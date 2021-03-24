package com.xiaoniucr.xy.web.front;

import com.xiaoniucr.xy.core.base.BaseController;
import com.xiaoniucr.xy.core.constant.SessionKey;
import com.xiaoniucr.xy.core.json.JSONReturn;
import com.xiaoniucr.xy.entity.User;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpSession;
import java.util.Date;

/**
 * Login Front controller
 */

@Controller
public class LoginController extends BaseController {

    @RequestMapping("/login.html")
    public String login(){
        return "front/login";
    }


    @RequestMapping("/register.html")
    public String toRegiter(){
        return "front/register";
    }


    /**
     * Login authentication
     * @param u
     * @return
     */
    @RequestMapping("/signin")
    @ResponseBody
    public JSONReturn signIn(@RequestBody User u){

        User user = iUserService.selectByUsername(u.getUsername());
        if(user == null){
            return JSONReturn.buildFailure("The user name does not exist！");
        }
        if(!user.getPassword().equals(u.getPassword())){
            return JSONReturn.buildFailure("Please enter the correct password！");
        }
        if(user.getStatus() == 2){
            return JSONReturn.buildFailure("The account has been banned, please contact the administrator！");
        }
        setSession("user",user);
        return JSONReturn.buildSuccess("Login successful！");
    }


    /**
     * register
     * @param u
     * @return
     */
    @RequestMapping("/signup")
    @ResponseBody
    public JSONReturn signup(@RequestBody User u){

        User user = iUserService.selectByUsername(u.getUsername());
        if(user!=null){
            return JSONReturn.buildFailure("The user name already exists！");
        }
        Date date = new Date();
        u.setCreateTime(date);
        u.setUpdateTime(date);
        //normal
        u.setStatus(1);
        u.setType(2);
        u.setVisitNumber(0);
        iUserService.insert(u);
        return JSONReturn.buildSuccess("Registration is successful. Welcome to join us！");

    }

    @RequestMapping("/signout")
    public String signout(HttpSession session){

        removeSession(SessionKey.CURRENT_USER);
        return "redirect:/index.html";

    }


}
