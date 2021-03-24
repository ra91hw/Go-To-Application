package com.xiaoniucr.xy.utils;

import com.xiaoniucr.xy.core.constant.Global;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.core.io.DefaultResourceLoader;
import org.springframework.core.io.Resource;
import org.springframework.core.io.ResourceLoader;

import java.io.IOException;
import java.io.InputStream;
import java.util.Properties;
import java.util.concurrent.ConcurrentHashMap;
import java.util.concurrent.ConcurrentMap;

public class PropertiesUtils {

    private static Logger logger = LoggerFactory.getLogger(PropertiesUtils.class);

   /**
           * Save the global attribute value
* Concurrent containers: thread-safe
*/
    private static ConcurrentMap<String,String> map = new ConcurrentHashMap<String,String>();


    private static Properties props;

    static {

        props = new Properties();
        ResourceLoader loader = new DefaultResourceLoader();
        InputStream is = null;
        try {
            Resource resource = loader.getResource(Global.CONFIG_PATH);
            is = resource.getInputStream();
            props.load(is);
        } catch (IOException ex) {
            logger.info("Could not load properties from path:" + Global.CONFIG_PATH + ", " + ex.getMessage());
        } finally {
            if(is!=null){
                try {
                    is.close();
                } catch (IOException e) {
                    // TODO Auto-generated catch block
                    e.printStackTrace();
                }
            }
        }
    }


    /**
     * Get configuration
     */
    public static String getValue(String key) {
        String value = map.get(key);
        if (value == null){
            value = props.getProperty(key);
            map.put(key, value);
        }
        return value;
    }
}
