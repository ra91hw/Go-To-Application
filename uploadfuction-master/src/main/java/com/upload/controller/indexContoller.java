package com.upload.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class indexContoller {

    @GetMapping("index")
    public String toLogin(){

        return "login";
    }
}
