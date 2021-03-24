package com.xiaoniucr.xy.core.page;


import com.xiaoniucr.xy.utils.PropertiesUtils;

import java.util.Collections;
import java.util.List;


public class Page<T> {

    /**
     * Current page data list
     */
    private List<T> rows;

    /**
     * Page size (number of data per page)
     */
    private int pageSize;

    /**
     * Current page number
     */
    private int pageNo;

    /**
     * Total number of data
     */
    private int total = 0;

    private boolean isLast;

    private boolean isFirst;

    private int totalPage = 0;


    public int getTotalPage() {
        return totalPage;
    }


    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }


    public List<T> getRows() {
        return rows;
    }

    public void setRows(List<T> rows) {
        this.rows = rows;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }


    public void setPageNo(int pageNo) {
        this.pageNo = pageNo;
    }


    public void setTotal(int total) {
        this.total = total;
    }

    public boolean getIsLast() {
        return isLast;
    }


    public void setLast(boolean isLast) {
        this.isLast = isLast;
    }


    public boolean getIsFirst() {
        return isFirst;
    }


    public void setFirst(boolean isFirst) {
        this.isFirst = isFirst;
    }


    /**
     * Customized pagination and encapsulated response parameters for the front end of the website
     * According to the current page number, page size (number of data per page), the current page data list, and the total number of data to construct an instance of the paging data object.
     * @param pageNo current page number
     * @param rows current page data list
     * @param total Total number of data
     */
    public Page(int pageNo, List<T> rows, int total) {
        this.pageNo = pageNo;
        this.pageSize = Integer.valueOf(PropertiesUtils.getValue("page.size"));
        this.rows = rows;
        this.total = total;
        this.isLast = isLastPage();
        this.isFirst = isFirstPage();
        this.totalPage = getTotalPageNum();
    }

    /**
     * Bootstrap-table paging response parameter package
     * @param rows
     * @param total
     */
    public Page(List<T> rows, int total) {

        //Parameter name is not allowed to be modified
        this.rows = rows;
        this.total = total;
    }



    public int getTotalPageNum() {
        if (pageSize != 0) {
            if (pageSize - total > 0) {
                return 1;
            }
            if (total % pageSize == 0) {
                return total / pageSize;
            } else {
                return total / pageSize + 1;
            }
        } else {
            return 0;
        }

    }

    /**
     * Define an empty page
     *
     * @see #emptyPage()
     */
    @SuppressWarnings("rawtypes")
    public static final Page EMPTY_PAGE = new Page(
            0, Collections.emptyList(), 0);

    /**
     * Get an empty page
     */
    public static <E> Page<E> emptyPage() {
        return (Page<E>) EMPTY_PAGE;
    }


    public boolean isFirstPage() {
        return getPageNo() == 1;
    }


    public boolean isLastPage() {
        return getPageNo() >= getLastPageNo();
    }


    public boolean hasNextPage() {
        return rows == null ? false : rows.size() > getPageSize();
    }


    public boolean hasPreviousPage() {
        return getPageNo() > 1;
    }


    public int getLastPageNo() {
        double totalResults = new Integer(getTotal()).doubleValue();
        return (totalResults % getPageSize() == 0) ? new Double(
                Math.floor(totalResults / getPageSize())).intValue()
                : (new Double(Math.floor(totalResults / getPageSize()))
                .intValue() + 1);
    }


    public List<T> getThisPagerows() {
        return hasNextPage() ? rows.subList(0, getPageSize()) : rows;
    }


    public int getTotal() {
        return total;
    }


    public int getThisPageFirstElementNumber() {
        return getPageNo() * getPageSize() + 1;
    }


    public int getThisPageLastElementNumber() {
        int fullPage = getThisPageFirstElementNumber() + getPageSize() - 1;
        return getTotal() < fullPage ? getTotal() : fullPage;
    }

    public int getNextPageNo() {
        return getPageNo() + 1;
    }

    public int getPreviousPageNo() {
        return getPageNo() - 1;
    }

    public int getPageSize() {
        return pageSize;
    }

    public int getPageNo() {
        return pageNo;
    }

    /**
     * Get the position of the first data of a given page number in the total data according to the page size (number of data per page) (starting from 1)
     *
     * @param pageNo given page number
     * @param pageSize page size (number of data per page)
     * @return The position of the first data of a given page number in the total data (starting from 1)
     */
    public static int getStartOfPage(int pageNo, int pageSize) {
        int startIndex = (pageNo - 1) * pageSize + 1;
        if (startIndex < 1)
            startIndex = 1;
        return startIndex;
    }
}
