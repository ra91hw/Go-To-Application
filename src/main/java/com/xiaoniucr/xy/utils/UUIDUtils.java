package com.xiaoniucr.xy.utils;

import java.util.UUID;

public class UUIDUtils {

    /**
     * Get the original UUID with'-'
     * @return
     */
    public static String getOrginalUUID(){

        return UUID.randomUUID().toString();

    }

    /**
     * Get UUID, remove'-'
     * @return
     */
    public static String getUUID(){
        return UUID.randomUUID().toString().replace("-", "");
    }
}
