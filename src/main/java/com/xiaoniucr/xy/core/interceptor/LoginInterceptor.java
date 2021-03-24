package com.xiaoniucr.xy.core.interceptor;

import com.xiaoniucr.xy.core.constant.Global;
import com.xiaoniucr.xy.core.json.JSONReturn;
import com.xiaoniucr.xy.entity.User;
import com.xiaoniucr.xy.utils.JSONUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

public class LoginInterceptor extends HandlerInterceptorAdapter {


    private Logger logger = LoggerFactory.getLogger(LoginInterceptor.class);

    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {

        String url = request.getRequestURI();
        logger.info("url====>{}",url);
        int index = url.indexOf(Global.ADMIN);
        /**
         * Request method: ordinary request, ajax request
         */
        String xrequest = request.getHeader("X-Requested-With");
        /**
         * The description that contains admin in the request path is a background request
         */
        if(index>=0){
            User admin = (User) request.getSession().getAttribute("admin");
            if(admin!=null){
                return true;
            }
            request.getRequestDispatcher("/admin/login.html").forward(request,response);
        }else{
            User user = (User) request.getSession().getAttribute("user");
            if(user!=null){
                return true;
            }
            if("XMLHttpRequest".equals(xrequest)){

                JSONReturn result = JSONReturn.build(403,"Please log in first！");
                response.getWriter().print(JSONUtil.toString(result));
                return false;

            }else{
                request.getRequestDispatcher("/login.html").forward(request, response);
            }
        }
        return true;
    }
}
