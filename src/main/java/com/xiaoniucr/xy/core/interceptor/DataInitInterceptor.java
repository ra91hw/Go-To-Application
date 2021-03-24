package com.xiaoniucr.xy.core.interceptor;

import com.xiaoniucr.xy.core.constant.Global;
import com.xiaoniucr.xy.entity.Category;
import com.xiaoniucr.xy.mapper.CategoryMapper;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class DataInitInterceptor extends HandlerInterceptorAdapter {

    @Autowired
    private CategoryMapper categoryMapper;

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
         * The front-end request here needs to query the menu data
         */
        if(index < 0){
            if(!"XMLHttpRequest".equals(xrequest)){
                Map<String,Object> params = new HashMap<>();
                params.put("status","1");
                params.put("pid","0");
                List<Category> categoryList = categoryMapper.queryList(params);
                request.setAttribute("categoryList",categoryList);
            }
        }
        return true;
    }

}
