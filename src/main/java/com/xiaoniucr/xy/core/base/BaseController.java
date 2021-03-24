package com.xiaoniucr.xy.core.base;


import com.xiaoniucr.xy.service.*;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.context.request.RequestAttributes;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.net.InetAddress;
import java.net.UnknownHostException;


/**
 * Basic controller
 * All other controllers inherit from this class
 */
public class BaseController {

    @Autowired
    public IUserService iUserService;


    @Autowired
    public IDiscussService iDiscussService;

    @Autowired
    public ILikeService iLikeService;


    @Autowired
    public INoticeService iNoticeService;


    @Autowired
    public ILinkService iLinkService;


    @Autowired
    public ICategoryService iCategoryService;

    @Autowired
    public IBannerService iBannerService;

    @Autowired
    public IAlbumService iAlbumService;

    @Autowired
    public IAlbumImageService iAlbumImageService;

    /**
     * Log
     */
    public Logger logger = LoggerFactory.getLogger(this.getClass());


    /**
     * Get the session object
     *
     * @param attributeName
     * @return
     */
    public Object getSession(String attributeName) {
        return this.getRequest().getSession(true).getAttribute(attributeName);
    }

    /**
     * Set session
     *
     * @param attributeName
     * @param object
     */
    public void setSession(String attributeName, Object object) {
        this.getRequest().getSession(true).setAttribute(attributeName, object);
    }

    /**
     * Remove session
     * @param attributeName
     */
    public void removeSession(String attributeName){
        this.getRequest().getSession(true).removeAttribute(attributeName);
    }

    /**
     * Get the request object
     *
     * @return
     */
    public HttpServletRequest getRequest() {
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        return ((ServletRequestAttributes) ra).getRequest();
    }


    /**
     * Get the response object
     *
     * @return
     */
    public HttpServletResponse getResponse() {
        RequestAttributes ra = RequestContextHolder.getRequestAttributes();
        return ((ServletRequestAttributes) ra).getResponse();
    }


    /**
     * Get IP address
     * @return
     */
    public String getIpAddr() {

        String ipAddress = null;
        try {
            HttpServletRequest request = this.getRequest();
            ipAddress = request.getHeader("x-forwarded-for");
            if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
                ipAddress = request.getHeader("Proxy-Client-IP");
            }
            if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
                ipAddress = request.getHeader("WL-Proxy-Client-IP");
            }
            if (ipAddress == null || ipAddress.length() == 0 || "unknown".equalsIgnoreCase(ipAddress)) {
                ipAddress = request.getRemoteAddr();
                if (ipAddress.equals("127.0.0.1")) {
                    // Take the IP configured by the machine according to the network card
                    InetAddress inet = null;
                    try {
                        inet = InetAddress.getLocalHost();
                    } catch (UnknownHostException e) {
                        e.printStackTrace();
                    }
                    ipAddress = inet.getHostAddress();
                }
            }
            // In the case of multiple agents, the first IP is the real IP of the client, and multiple IPs are divided according to','
            if (ipAddress != null && ipAddress.length() > 15) { // "***.***.***.***".length()
                // = 15
                if (ipAddress.indexOf(",") > 0) {
                    ipAddress = ipAddress.substring(0, ipAddress.indexOf(","));
                }
            }
        } catch (Exception e) {
            ipAddress = "";
        }
        return ipAddress;
    }


}
