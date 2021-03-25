package com.xiaoniucr.xy.core.page;

import com.xiaoniucr.xy.utils.PropertiesUtils;
import org.springframework.util.StringUtils;

import java.util.HashMap;
import java.util.Map;

/**
 * Paging query parameter conversion
 * Use Map to pass parameters and call mybatis to query
 */
public class PageQuery extends HashMap {

    private int start = 0;
    private int limit = 0;

    private int pageNo = 1;
    private int pageSize = 10;

    private String sort;
    //Sort: asc or desc
    private String order;


    {
        pageSize = Integer.valueOf(PropertiesUtils.getValue("page.size"));
    }

    /**
     * Check only the first page
     */
    public PageQuery(){
        this.limit = this.pageSize;
        this.put("start", this.start);
        this.put("limit", this.limit);
    }

    /**
     * <p>
     * For the short answer pagination encapsulated by the front end, the front end will only pass a pageNo parameter to the back end at this time.
     * As for pageSize (several items per page) has been written into the configuration file, just get the configuration
     * According to the number of pages entered, start and limit are automatically converted
     * Convenient for mysql database query
     * </p>
     * @param pageNo
     */
    public PageQuery(Integer pageNo) {

        if(StringUtils.isEmpty(pageNo)){
            pageNo = 1;
        }
        this.pageNo = pageNo;
        this.limit = this.pageSize;
        /**
         * mysql start starts from 0
         */
        this.start = (pageNo - 1) * this.pageSize;
        this.put("start", this.start);
        this.put("limit", this.limit);
    }


    public PageQuery(Map<String,Object> params) {

        this.putAll(params);
        /**
         * These two parameters must be converted to int type, mybatis can find the result, the reason is unknown, it’s too bad
         */
        this.put("start", Integer.parseInt(params.get("start").toString()));
        this.put("limit", Integer.parseInt(params.get("limit").toString()));
    }





    public int getPageNo() {
        return pageNo;
    }

    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }


}
