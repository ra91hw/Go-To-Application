package com.upload.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.UUID;

import com.upload.entity.User;
import com.upload.entity.UserFile;
import com.upload.service.UserFileService;
import org.apache.catalina.filters.AddDefaultCharsetFilter;
import org.apache.commons.io.FilenameUtils;
import org.apache.commons.io.IOUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.ResourceUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("file")
public class FileController {
    @Autowired
    private UserFileService userFileService;

    /*Delete*/
    @GetMapping("delete")
    public String delete(String id) throws FileNotFoundException {

        //Query information by ID
        UserFile userFile = userFileService.findById(id);

        //delete photo
        String realPath = ResourceUtils.getURL("classpath:").getPath() + "/static" + userFile.getPath();
        File file= new File(realPath,userFile.getNewFileName());
        if (file.exists())file.delete();//Immediately delete

        //Delete a record in the database
        userFileService.delete(id);

        return "redirect:/file/showAll";

    }


    /*photo download*/
    @GetMapping("download")
    public void download(String id, HttpServletResponse response) throws IOException {
        //Get photo information
        UserFile userFile = userFileService.findById(id);
        //Updates Downloads
        userFile.setDownloadcounts(userFile.getDownloadcounts()+1);
        userFileService.update(userFile);
        //Get the photo input stream based on the photo name and photo storage path in the photo information
        String realPath = ResourceUtils.getURL("classpath:").getPath()+"/static"+userFile.getPath();
        //Gets the file input stream
        FileInputStream is = new FileInputStream(new File(realPath, userFile.getNewFileName()));
        //Download the attachment
        response.setHeader("content-dispostion","inline;fileName="+ URLEncoder.encode(userFile.getOldFileName(),"UTF-8"));
        //Gets the response output stream
        ServletOutputStream os = response.getOutputStream();
        //copy photo
        IOUtils.copy(is,os);
        IOUtils.closeQuietly(is);
        IOUtils.closeQuietly(os);



    }


/*Upload photo processing and save photo information to the database*/
    @PostMapping("upload")
    public String upload(MultipartFile aaa,HttpSession session) throws IOException {
        //Gets the ID of the user who uploaded the photo
        User user = (User) session.getAttribute("user");

        //Gets the original name of the photo
        String oldFileName = aaa.getOriginalFilename();

        //Gets the suffix of the name of the photo
       String extension ="."+ FilenameUtils.getExtension(aaa.getOriginalFilename());


        //Generate a new photo name
        String newFileName = new SimpleDateFormat("yyyyMMddHHmmss").format(new Date())+ UUID.randomUUID().toString().replace("-","")+extension;

        //photo size
        long size =aaa.getSize();

        //photo type
        String type =aaa.getContentType();

        //Processes generating directories based on dates
       String realPath = ResourceUtils.getURL("classpath:").getPath()+"/static/files";
        String dateFormat = new SimpleDateFormat("yyyy-MM-dd").format(new Date());
        String dateDirPath = realPath + "/" + dateFormat;
        File dateDir = new File(dateDirPath);
        if(!dateDir.exists())dateDir.mkdirs();

        //Handle photo uploads
        aaa.transferTo(new File(dateDir,newFileName));

        //Put the photo information into the database for storage
        UserFile userFile = new UserFile();
        userFile.setOldFileName(oldFileName).setNewFileName(newFileName).setExt(extension).setSize(String.valueOf(size)).setType(type).setPath("/files/"+dateFormat).setUserId(user.getId());
        userFileService.save(userFile);











        return "redirect:/file/showAll";//After uploading, it still jumps to the showall page




    }


    /*Display all photo information*/

    @GetMapping("showAll")
    public String findAll(HttpSession session, Model model){
    //Gets the user's ID in the logged session
        User user = (User) session.getAttribute("user");
        //Query user photo information based on user ID
        List<UserFile> userFiles = userFileService.findByUserId(user.getId());
        model.addAttribute("files",userFiles);


        return "showAll";


    }
}
