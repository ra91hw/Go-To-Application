package com.upload.controller;

import com.upload.entity.User;
import com.upload.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("user")

public class UserController {
    @Autowired
    private UserService userService;

     @PostMapping("login")
    //login method
    public String login(User user, HttpSession session){  //Receive the object transmitted by the user
         User userDB = userService.login(user);//Call the login method to query user, and return information in the database if found
         if (userDB!=null){
             session.setAttribute("user",userDB);
             return "redirect:/file/showAll";//Jump after successful login

         }else {
             return "redirect:/index";//Jump after unsuccessful login
         }
    }
}
