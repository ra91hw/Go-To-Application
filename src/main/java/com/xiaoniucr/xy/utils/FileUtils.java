package com.xiaoniucr.xy.utils;


import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.Arrays;
import java.util.HashMap;
import java.util.Iterator;

/**
 * File related tools
 */
public class FileUtils {

    private static String[] allowFiles = { ".gif", ".png", ".jpg", ".jpeg", ".bmp" };

    /**
     * Picture upload return information
     */
    public static HashMap<String, String> errorInfo = new HashMap<String,String>();


    static {

        try {
            //Default success
            errorInfo.put("SUCCESS", "SUCCESS");
            errorInfo.put("NOFILE", URLEncoder.encode("The file upload field is not included","UTF-8"));
            errorInfo.put("TYPE", URLEncoder.encode("Disallowed file format","UTF-8"));
            errorInfo.put("SIZE", URLEncoder.encode("File size out of limit, maximum support 2MB","UTF-8"));
            errorInfo.put("ENTYPE", URLEncoder.encode("Request type ENTYPE error","UTF-8"));
            errorInfo.put("REQUEST", URLEncoder.encode("Upload request exception","UTF-8"));
            errorInfo.put("IO", URLEncoder.encode("IO exception","UTF-8"));
            errorInfo.put("DIR", URLEncoder.encode("Directory creation failed","UTF-8"));
            errorInfo.put("UNKNOWN", URLEncoder.encode("An unknown error","UTF-8"));
        } catch (UnsupportedEncodingException e) {
            e.printStackTrace();
        }
    }
    /**
     * Get the file suffix, for example: [.jpg]
     * @param fileName
     * @return
     */
    public static String getSuffix(String fileName){

        int index = fileName.lastIndexOf(".");
        return fileName.substring(index);
    }


    /**
     * Determine whether the file directory exists, create it if it does not exist
     * @param file It must be a specific file path, for example: [D:\tmp\test.txt], not a file directory
     */
    public static void checkDirAndCreate(File file) {
        if (!file.getParentFile().exists()) {
            file.getParentFile().mkdirs();
        }
    }


    /**
     * File type judgment
     *
     * @param fileName
     * @return
     */
    public static boolean checkFileType(String fileName) {
        Iterator<String> type = Arrays.asList(allowFiles).iterator();
        while (type.hasNext()) {
            String ext = type.next();
            if (fileName.toLowerCase().endsWith(ext)) {
                return true;
            }
        }
        return false;
    }



}
