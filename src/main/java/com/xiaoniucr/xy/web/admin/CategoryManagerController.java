package com.xiaoniucr.xy.web.admin;


import com.xiaoniucr.xy.core.json.JSONReturn;
import com.xiaoniucr.xy.core.page.Page;
import com.xiaoniucr.xy.core.page.PageQuery;
import com.xiaoniucr.xy.entity.Album;
import com.xiaoniucr.xy.entity.Category;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;

import org.springframework.stereotype.Controller;
import com.xiaoniucr.xy.core.base.BaseController;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;
import java.util.List;
import java.util.Map;

/**
 * Category manager Front controller
 */
@Controller
@RequestMapping("/admin/category")
public class CategoryManagerController extends BaseController {


    /**
     * 前往文章类别管理页面
     * @return
     */
    @RequestMapping("")
    public String toCategoryManager(){
        return "/admin/category/list";
    }


    /**
     * 查询文章类别数据
     * @param params
     * @return
     */
    @RequestMapping("/list")
    @ResponseBody
    public Page list(@RequestParam Map<String,Object> params){

        PageQuery query = new PageQuery(params);
        List<Category> data = iCategoryService.queryList(query);
        int total = iCategoryService.queryTotal(query);
        Page page = new Page(data,total);
        return page;
    }



    /**
     * 保存文章类别
     * @param category
     * @return
     */
    @RequestMapping("/save")
    @ResponseBody
    public JSONReturn save(@RequestBody Category category){

        Category c = iCategoryService.selectByName(category.getName());
        if(c!=null){
            return JSONReturn.buildFailure("The category already exists！");
        }
        try{
            Date date = new Date();
            category.setCreateTime(date);
            category.setUpdateTime(date);
            //正常
            category.setStatus(1);
            iCategoryService.insert(category);
            return JSONReturn.buildSuccess("Category added successfully！");
        }catch (Exception e){
            return JSONReturn.buildFailure("Add failure："+e.getMessage());
        }
    }


    /**
     * 类别修改
     * @param category
     * @return
     */
    @RequestMapping("/update")
    @ResponseBody
    public JSONReturn update(@RequestBody Category category){

        Category c = iCategoryService.selectById(category.getId());
        if(!c.getName().equals(category.getName())){
            Category exist = iCategoryService.selectByName(category.getName());
            if(exist != null){
                return JSONReturn.buildFailure("The category already exists！");
            }
        }
        Date date = new Date();
        category.setUpdateTime(date);
        iCategoryService.updateById(category);
        return JSONReturn.buildSuccess("Category modified successfully！");
    }


    /**
     * 根据类别Id获取类别信息
     * @param map
     * @return
     */
    @RequestMapping("/getById")
    @ResponseBody
    public JSONReturn getById(Map<String,Integer> map){

        Integer id = map.get("id");
        Category category = iCategoryService.selectById(id);
        return JSONReturn.buildSuccess(category);

    }


    /**
     * 删除类别
     * @param category
     * @return
     */
    @RequestMapping("/remove")
    @ResponseBody
    public JSONReturn remove(@RequestBody Category category){

        Category c = iCategoryService.selectById(category.getId());
        List<Album> albumList = iAlbumService.selectByCid(category.getId());
        if(albumList != null && albumList.size() > 0){
            return JSONReturn.buildFailure("There is an album under the category, which cannot be deleted！");
        }
        iCategoryService.deleteById(category.getId());
        return JSONReturn.buildSuccess("Category deleted successfully！");
    }

    /**
     * 类别启用禁用
     * @param category
     * @return
     */
    @ResponseBody
    @RequestMapping("/audit")
    public JSONReturn audit(@RequestBody Category category){

        category.setUpdateTime(new Date());
        iCategoryService.updateById(category);
        return JSONReturn.buildSuccess("Operation is successful！");
    }



    /**
     * 获取所有分类
     * @return
     */
    @ResponseBody
    @RequestMapping("/allcategory")
    public JSONReturn allcategory(){

        List<Category> categoryList = iCategoryService.selectAll();
        return JSONReturn.buildSuccess(categoryList);
    }




}

