package com.xiaoniucr.xy.web;

import com.alibaba.fastjson.JSON;
import com.xiaoniucr.xy.utils.FileUtils;
import com.xiaoniucr.xy.utils.PropertiesUtils;
import com.xiaoniucr.xy.utils.UUIDUtils;
import com.xiaoniucr.xy.vo.UEditorResult;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.File;
import java.io.IOException;

/**
 * Ueditor file upload
 * Front controller
 */

@Controller
public class FileUploadController {

    private static Logger logger = LoggerFactory.getLogger(FileUploadController.class);

    /**
     * File format allowed
     */
    private static String[] allowFiles = {".gif", ".png", ".jpg", ".jpeg", ".bmp"};


    /**
     *
     * @param type      Picture type: 1 case picture, 2 design reply
     * @param file
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/ueditorUpload/{type}")
    public void upload(@PathVariable(value = "type")Integer type,@RequestParam(value = "upfile", required = false) MultipartFile file,
                       HttpServletRequest request, HttpServletResponse response) throws IOException {

        logger.info("ServerPath:{}", request.getServletContext().getRealPath("/"));
        UEditorResult data = new UEditorResult();
        // save photo
        if (file != null && !file.isEmpty()) {
            String fileOriginName = file.getOriginalFilename();
            if (file.getSize() > Long.parseLong(PropertiesUtils.getValue("ueditor.fileSizeLimit"))* 1024 *1024) {
                data.setState(FileUtils.errorInfo.get("SIZE"));
            } else {
                if (FileUtils.checkFileType(fileOriginName)) {
                    try {
                        String path = null;
                        if(type == 1){
                            path = PropertiesUtils.getValue("blog.path");
                        }
                        String fileSuffix = FileUtils.getSuffix(file.getOriginalFilename());
                        String fileName = UUIDUtils.getUUID() + fileSuffix;
                        String newFilePath = path  + fileName;
                        File dest = new File(path);
                        if(!dest.exists()){
                            dest.mkdirs();
                        }
                        File destFile = new File(newFilePath);
                        FileUtils.checkDirAndCreate(destFile);
                        file.transferTo(destFile);
                        data.setName(fileName);
                        data.setOriginalName(fileOriginName);
                        data.setType(fileSuffix);
                        data.setState(FileUtils.errorInfo.get("SUCCESS"));
                        if(type == 1){
                            data.setUrl("iblogimg/blog/" + fileName);
                        }
                        data.setSize(file.getSize());
                    } catch (Exception e) {
                        data.setState(FileUtils.errorInfo.get("UNKNOWN"));
                        e.printStackTrace();
                    }
                } else {
                    data.setState(FileUtils.errorInfo.get("TYPE"));
                }
            }

        } else {
            data.setState(FileUtils.errorInfo.get("NOFILE"));
        }

        response.getWriter().write(JSON.toJSONString(data));
    }



    /**
     *
     * @param type      Picture type: 1 case picture, 2 design reply
     * @param file
     * @param request
     * @param response
     * @throws IOException
     */
    @RequestMapping("/admin/ueditorUpload/{type}")
    public void upload4Admin(@PathVariable(value = "type")Integer type,@RequestParam(value = "upfile", required = false) MultipartFile file,
                       HttpServletRequest request, HttpServletResponse response) throws IOException {

        logger.info("ServerPath:{}", request.getServletContext().getRealPath("/"));
        UEditorResult data = new UEditorResult();
        // 保存图片
        if (file != null && !file.isEmpty()) {
            String fileOriginName = file.getOriginalFilename();
            if (file.getSize() > Long.parseLong(PropertiesUtils.getValue("ueditor.fileSizeLimit"))* 1024 *1024) {
                data.setState(FileUtils.errorInfo.get("SIZE"));
            } else {
                if (FileUtils.checkFileType(fileOriginName)) {
                    try {
                        String path = null;
                        if(type == 1){
                            path = PropertiesUtils.getValue("blog.path");
                        }
                        String fileSuffix = FileUtils.getSuffix(file.getOriginalFilename());
                        String fileName = UUIDUtils.getUUID() + fileSuffix;
                        String newFilePath = path  + fileName;
                        File dest = new File(path);
                        if(!dest.exists()){
                            dest.mkdirs();
                        }
                        File destFile = new File(newFilePath);
                        FileUtils.checkDirAndCreate(destFile);
                        file.transferTo(destFile);
                        data.setName(fileName);
                        data.setOriginalName(fileOriginName);
                        data.setType(fileSuffix);
                        data.setState(FileUtils.errorInfo.get("SUCCESS"));
                        if(type == 1){
                            data.setUrl("iblogimg/blog/" + fileName);
                        }
                        data.setSize(file.getSize());
                    } catch (Exception e) {
                        data.setState(FileUtils.errorInfo.get("UNKNOWN"));
                        e.printStackTrace();
                    }
                } else {
                    data.setState(FileUtils.errorInfo.get("TYPE"));
                }
            }

        } else {
            data.setState(FileUtils.errorInfo.get("NOFILE"));
        }

        response.getWriter().write(JSON.toJSONString(data));
    }



}
