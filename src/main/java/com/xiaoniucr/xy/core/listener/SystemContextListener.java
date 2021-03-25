package com.xiaoniucr.xy.core.listener;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.io.InputStream;
import java.util.Properties;

@WebListener
public class SystemContextListener implements ServletContextListener {

    private static final Logger logger = LoggerFactory.getLogger(SystemContextListener.class);

;    @Override
    public void contextInitialized(ServletContextEvent sce) {

        logger.info("System starts from now...");
        InputStream is = null;
        try {
            Properties Properties =new Properties();
            is = this.getClass().getResourceAsStream("/config.properties");
            Properties.load(is);
            //Properties use the getProperty method to get the property value of the object
            String urlPrefix = Properties .getProperty("url.prefix");
            logger.info("basePath===>{}",urlPrefix+sce.getServletContext().getContextPath());
            sce.getServletContext().setAttribute("basePath", urlPrefix+sce.getServletContext().getContextPath());
        } catch (Exception e) {
            e.printStackTrace();
        }

    }

    @Override
    public void contextDestroyed(ServletContextEvent event) {

        logger.error("System starts to stop...");
    }
}
