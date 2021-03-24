package com.xiaoniucr.xy.utils;

import org.springframework.util.StringUtils;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;

/**
 * Date tools
 */
public class DateUtils {

    public static final String DATE_TIME_PATTERN = "HH:mm:ss dd-MM-yyyy ";
    public static final String MINUTE_PATTERN = "HH:mm dd-MM-yyyy";
    public static final String HOUR_PATTERN = "HH:mm:ss dd-MM-yyyy";
    public static final String DATE_PATTERN = "MM-yyyy";
    public static final String MONTH_PATTERN = "MM-yyyy";
    public static final String MONTH_PATTERN_CHINA = "MM-yyyy";
    public static final String YEAR_PATTERN = "yyyy";
    public static final String MINUTE_ONLY_PATTERN = "mm";
    public static final String HOUR_ONLY_PATTERN = "HH";
    public static final String YEAR_MONTH_DAY = "ddMMyyyy";
    public static final String MONTH_DAY_PATTREN = "ddMM";

    //以下参数用来计算几秒前，几分钟前。
    private static final long ONE_MINUTE = 60000L;
    private static final long ONE_HOUR = 3600000L;
    private static final long ONE_DAY = 86400000L;
    private static final long ONE_WEEK = 604800000L;

    private static final String ONE_SECOND_AGO = "seconds ago";
    private static final String ONE_MINUTE_AGO = "minutes ago";
    private static final String ONE_HOUR_AGO = "hours ago";
    private static final String ONE_DAY_AGO = "days before";
    private static final String ONE_MONTH_AGO = "months ago";
    private static final String ONE_YEAR_AGO = "years ago";

    /**
     * Date addition and subtraction days
     *
     * @param date  If it is Null, it is the current time
     * @param days  add and subtract days
     * @param includeTime  whether to include hours, minutes and seconds, true means include
     * @return
     * @throws ParseException
     */
    public static Date dateAdd(Date date, int days, boolean includeTime) throws ParseException {
        if (date == null) {
            date = new Date();
        }
        if (!includeTime) {
            SimpleDateFormat sdf = new SimpleDateFormat(DateUtils.DATE_PATTERN);
            date = sdf.parse(sdf.format(date));
        }
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        cal.add(Calendar.DATE, days);
        return cal.getTime();
    }

    /**
     * The time is formatted as a string
     *
     * @param date Date
     * @param pattern  StrUtils.DATE_TIME_PATTERN || StrUtils.DATE_PATTERN, if it is empty, it is yyyy-MM-dd
     * @return
     * @throws ParseException
     */
    public static String dateFormat(Date date, String pattern) {
        if (StringUtils.isEmpty(pattern)) {
            pattern = DateUtils.DATE_PATTERN;
        }
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        return sdf.format(date);
    }

    /**
     * The string is parsed into a time object
     *
     * @param dateTimeString String
     * @param pattern StrUtils.DATE_TIME_PATTERN || StrUtils.DATE_PATTERN, if it is empty, it is yyyy-MM-dd
     * @return
     * @throws ParseException
     */
    public static Date dateParse(String dateTimeString, String pattern) throws ParseException {
        if (StringUtils.isEmpty(pattern)) {
            pattern = DateUtils.DATE_PATTERN;
        }
        SimpleDateFormat sdf = new SimpleDateFormat(pattern);
        return sdf.parse(dateTimeString);
    }

    /**
     * Format the date and time into a date-only string (you can use dateFormat directly, and Pattern is Null for formatting)
     *
     * @param dateTime Date
     * @return
     * @throws ParseException
     */
    public static String dateTimeToDateString(Date dateTime) throws ParseException {
        String dateTimeString = DateUtils.dateFormat(dateTime, DateUtils.DATE_TIME_PATTERN);
        return dateTimeString.substring(0, 10);
    }

    /**
     * When the time, minute, and second are 00:00:00, format the date and time into a string with only the date,
     * When the time, minute, and second are not 00:00:00, return directly
     *
     * @param dateTime Date
     * @return
     * @throws ParseException
     */
    public static String dateTimeToDateStringIfTimeEndZero(Date dateTime) throws ParseException {
        String dateTimeString = DateUtils.dateFormat(dateTime, DateUtils.DATE_TIME_PATTERN);
        if (dateTimeString.endsWith("00:00:00")) {
            return dateTimeString.substring(0, 10);
        } else {
            return dateTimeString;
        }
    }

    /**
     * 将日期时间格式成日期对象，和dateParse互用
     *
     * @param dateTime Date
     * @return Date
     * @throws ParseException
     */
    public static Date dateTimeToDate(Date dateTime) throws ParseException {
        Calendar cal = Calendar.getInstance();
        cal.setTime(dateTime);
        cal.set(Calendar.HOUR_OF_DAY, 0);
        cal.set(Calendar.MINUTE, 0);
        cal.set(Calendar.SECOND, 0);
        cal.set(Calendar.MILLISECOND, 0);
        return cal.getTime();
    }

    /**
     * When time increases or decreases
     *
     * @param startDate the time to be processed, Null is the current time
     * @param hours plus and minus hours
     * @return Date
     */
    public static Date dateAddHours(Date startDate, int hours) {
        if (startDate == null) {
            startDate = new Date();
        }
        Calendar c = Calendar.getInstance();
        c.setTime(startDate);
        c.set(Calendar.HOUR, c.get(Calendar.HOUR) + hours);
        return c.getTime();
    }

    /**
     *Time plus or minus minutes
     *
     * @param startDate is the time to be processed. NULL is the current time
     * @param minutes   param minutes
     * @return
     */
    public static Date dateAddMinutes(Date startDate, int minutes) {
        if (startDate == null) {
            startDate = new Date();
        }
        Calendar c = Calendar.getInstance();
        c.setTime(startDate);
        c.set(Calendar.MINUTE, c.get(Calendar.MINUTE) + minutes);
        return c.getTime();
    }

    /**
     * Time plus or minus seconds
     *
     * @param startDate The time to process, NULL is the current time
     * @param seconds   Number of seconds to add or subtract
     * @return
     */
    public static Date dateAddSeconds(Date startDate, int seconds) {
        if (startDate == null) {
            startDate = new Date();
        }
        Calendar c = Calendar.getInstance();
        c.setTime(startDate);
        c.set(Calendar.SECOND, c.get(Calendar.SECOND) + seconds);
        return c.getTime();
    }

    /**
     * Time plus or minus days
     *
     * @param startDate The time to process, NULL is the current time
     * @param days      The number of days plus or minus
     * @return Date
     */
    public static Date dateAddDays(Date startDate, int days) {
        if (startDate == null) {
            startDate = new Date();
        }
        Calendar c = Calendar.getInstance();
        c.setTime(startDate);
        c.set(Calendar.DATE, c.get(Calendar.DATE) + days);
        return c.getTime();
    }

    /**
     * Time plus or minus months
     *
     * @param startDate the time to be processed, Null is the current time
     * @param months add or subtract months
     * @return Date
     */
    public static Date dateAddMonths(Date startDate, int months) {
        if (startDate == null) {
            startDate = new Date();
        }
        Calendar c = Calendar.getInstance();
        c.setTime(startDate);
        c.set(Calendar.MONTH, c.get(Calendar.MONTH) + months);
        return c.getTime();
    }

    /**
     * Time plus or minus years
     *
     * @param startDate the time to be processed, Null is the current time
     * @param years plus or minus the number of years
     * @return Date
     */
    public static Date dateAddYears(Date startDate, int years) {
        if (startDate == null) {
            startDate = new Date();
        }
        Calendar c = Calendar.getInstance();
        c.setTime(startDate);
        c.set(Calendar.YEAR, c.get(Calendar.YEAR) + years);
        return c.getTime();
    }

    /**
     * Time comparison (if myDate>compareDate returns 1, <returns -1, equal returns 0)
     *
     * @param myDate time
     * @param compareDate the time to compare
     * @return int
     */
    public static int dateCompare(Date myDate, Date compareDate) {
        Calendar myCal = Calendar.getInstance();
        Calendar compareCal = Calendar.getInstance();
        myCal.setTime(myDate);
        compareCal.setTime(compareDate);
        return myCal.compareTo(compareCal);
    }

    /**
     * Get the smallest of the two times
     *
     * @param date
     * @param compareDate
     * @return
     */
    public static Date dateMin(Date date, Date compareDate) {
        if (date == null) {
            return compareDate;
        }
        if (compareDate == null) {
            return date;
        }
        if (1 == dateCompare(date, compareDate)) {
            return compareDate;
        } else if (-1 == dateCompare(date, compareDate)) {
            return date;
        }
        return date;
    }

    /**
     * Get the largest time of the two times
     *
     * @param date
     * @param compareDate
     * @return
     */
    public static Date dateMax(Date date, Date compareDate) {
        if (date == null) {
            return compareDate;
        }
        if (compareDate == null) {
            return date;
        }
        if (1 == dateCompare(date, compareDate)) {
            return date;
        } else if (-1 == dateCompare(date, compareDate)) {
            return compareDate;
        }
        return date;
    }

    /**
     * Get the number of days between two dates (excluding hours, minutes and seconds), excluding today
     *
     * @param startDate
     * @param endDate
     * @return
     * @throws ParseException
     */
    public static int dateBetween(Date startDate, Date endDate) throws ParseException {
        Date dateStart = dateParse(dateFormat(startDate, DATE_PATTERN), DATE_PATTERN);
        Date dateEnd = dateParse(dateFormat(endDate, DATE_PATTERN), DATE_PATTERN);
        return (int) ((dateEnd.getTime() - dateStart.getTime()) / 1000 / 60 / 60 / 24);
    }

    /**
     * Get the number of days between two dates (excluding hours, minutes and seconds), including today
     *
     * @param startDate
     * @param endDate
     * @return
     * @throws ParseException
     */
    public static int dateBetweenIncludeToday(Date startDate, Date endDate) throws ParseException {
        return dateBetween(startDate, endDate) + 1;
    }

    /**
     * Get the year of the date and time, such as 2021-02-13, return 2021
     *
     * @param date
     * @return
     */
    public static int getYear(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return cal.get(Calendar.YEAR);
    }

    /**
     * Get the month of the date and time, such as February 13, 2021, return 2
     *
     * @param date
     * @return
     */
    public static int getMonth(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return cal.get(Calendar.MONTH) + 1;
    }

    /**
     * Get the day of the date and time (that is, the dd of the return date), such as 2021-02-13, return 13
     *
     * @param date
     * @return
     */
    public static int getDate(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return cal.get(Calendar.DATE);
    }

    /**
     * Get the total number of days in the month of the date and time, such as 2021-02-13, return 28
     *
     * @param date
     * @return
     */
    public static int getDaysOfMonth(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return cal.getActualMaximum(Calendar.DATE);
    }

    /**
     * Get the total number of days in the current year of the date and time, such as 2021-02-13, return the total number of days in 2021
     *
     * @param date
     * @return
     */
    public static int getDaysOfYear(Date date) {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        return cal.getActualMaximum(Calendar.DAY_OF_YEAR);
    }

    /**
     * Get the largest date of the month according to time
     * @param date Date
     * @return
     * @throws Exception
     */
    public static Date maxDateOfMonth(Date date) throws Exception {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int value = cal.getActualMaximum(Calendar.DATE);
        return dateParse(dateFormat(date, MONTH_PATTERN) + "-" + value, null);
    }

    /**
     * Get the smallest date of the month according to time, that is, return the 1st date object of the current month
     *
     * @param date Date
     * @return
     * @throws Exception
     */
    public static Date minDateOfMonth(Date date) throws Exception {
        Calendar cal = Calendar.getInstance();
        cal.setTime(date);
        int value = cal.getActualMinimum(Calendar.DATE);
        return dateParse(dateFormat(date, MONTH_PATTERN) + "-" + value, null);
    }


    /**
     * According to the month and day of the current time
     *
     * @param date Date
     * @return
     * @throws Exception
     */
    public static String getMonthAndDate(Date date) {
        SimpleDateFormat sf = new SimpleDateFormat(MONTH_DAY_PATTREN);
        return sf.format(date);
    }


    /**
     * Get the first N months of the current month
     *
     * @param i Previous i months
     * @return
     */
    public static Date getLast12Months(int i) {
        SimpleDateFormat sdf = new SimpleDateFormat(MONTH_PATTERN_CHINA);
        Calendar c = Calendar.getInstance();
        c.setTime(new Date());
        c.add(Calendar.MONTH, -i);
        Date m = c.getTime();
        return m;
    }


    /**
     * Get the start time of the month in which the date is based on the date
     *
     * @param date
     * @return
     */
    public static String getFirstTimeOfMonth(Date date) {
        Calendar startDate = Calendar.getInstance();
        startDate.setTime(date);
        startDate.set(Calendar.DAY_OF_MONTH, 1);
        startDate.set(Calendar.HOUR_OF_DAY, 0);
        startDate.set(Calendar.MINUTE, 0);
        startDate.set(Calendar.SECOND, 0);
        startDate.set(Calendar.MILLISECOND, 0);
        Date firstDate = startDate.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_TIME_PATTERN);
        return sdf.format(firstDate);

    }


    /**
     * Get the last time of the month in which the date is based on the date
     *
     * @param date
     * @return
     */
    public static String getLastTimeOfMonth(Date date) {

        Calendar startDate = Calendar.getInstance();
        startDate.setTime(date);
        startDate.set(Calendar.DAY_OF_MONTH, startDate.getActualMaximum(Calendar.DAY_OF_MONTH));
        startDate.set(Calendar.HOUR_OF_DAY, 23);
        startDate.set(Calendar.MINUTE, 59);
        startDate.set(Calendar.SECOND, 59);
        startDate.set(Calendar.MILLISECOND, 999);
        Date firstDate = startDate.getTime();
        SimpleDateFormat sdf = new SimpleDateFormat(DATE_TIME_PATTERN);
        return sdf.format(firstDate);

    }


    /**
     * Get the start time of the current quarter
     *
     * @return
     */
    public static Date getCurrentQuarterStartTime() {
        Calendar c = Calendar.getInstance();
        int currentMonth = c.get(Calendar.MONTH) + 1;
        SimpleDateFormat longSdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
        SimpleDateFormat shortSdf = new SimpleDateFormat("dd-MM-yyyy");
        Date now = null;
        try {
            if (currentMonth >= 1 && currentMonth <= 3)
                c.set(Calendar.MONTH, 0);
            else if (currentMonth >= 4 && currentMonth <= 6)
                c.set(Calendar.MONTH, 3);
            else if (currentMonth >= 7 && currentMonth <= 9)
                c.set(Calendar.MONTH, 4);
            else if (currentMonth >= 10 && currentMonth <= 12)
                c.set(Calendar.MONTH, 9);
            c.set(Calendar.DATE, 1);
            now = longSdf.parse(shortSdf.format(c.getTime()) + " 00:00:00");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return now;
    }

    /**
     *End time of current quarter.
     *
     * @return
     */
    public static Date getCurrentQuarterEndTime() {
        Calendar c = Calendar.getInstance();
        int currentMonth = c.get(Calendar.MONTH) + 1;
        SimpleDateFormat longSdf = new SimpleDateFormat("dd-MM-yyyy HH:mm:ss");
        SimpleDateFormat shortSdf = new SimpleDateFormat("dd-MM-yyyy");
        Date now = null;
        try {
            if (currentMonth >= 1 && currentMonth <= 3) {
                c.set(Calendar.MONTH, 2);
                c.set(Calendar.DATE, 31);
            } else if (currentMonth >= 4 && currentMonth <= 6) {
                c.set(Calendar.MONTH, 5);
                c.set(Calendar.DATE, 30);
            } else if (currentMonth >= 7 && currentMonth <= 9) {
                c.set(Calendar.MONTH, 8);
                c.set(Calendar.DATE, 30);
            } else if (currentMonth >= 10 && currentMonth <= 12) {
                c.set(Calendar.MONTH, 11);
                c.set(Calendar.DATE, 31);
            }
            now = longSdf.parse(shortSdf.format(c.getTime()) + " 23:59:59");
        } catch (Exception e) {
            e.printStackTrace();
        }
        return now;
    }


    /**
     * 计算几秒前，几分钟前
     * @param date
     * @return
     */
    public static String relativeFormat(Date date) {
        long delta = System.currentTimeMillis() - date.getTime();
        if (delta < 1L * ONE_MINUTE) {
            long seconds = toSeconds(delta);
            return (seconds <= 0 ? 1 : seconds) + ONE_SECOND_AGO;
        }
        if (delta < 45L * ONE_MINUTE) {
            long minutes = toMinutes(delta);
            return (minutes <= 0 ? 1 : minutes) + ONE_MINUTE_AGO;
        }
        if (delta < 24L * ONE_HOUR) {
            long hours = toHours(delta);
            return (hours <= 0 ? 1 : hours) + ONE_HOUR_AGO;
        }
        if (delta < 48L * ONE_HOUR) {
            return "Yesterday";
        }
        if (delta < 30L * ONE_DAY) {
            long days = toDays(delta);
            return (days <= 0 ? 1 : days) + ONE_DAY_AGO;
        }
        if (delta < 12L * 4L * ONE_WEEK) {
            long months = toMonths(delta);
            return (months <= 0 ? 1 : months) + ONE_MONTH_AGO;
        } else {
            long years = toYears(delta);
            return (years <= 0 ? 1 : years) + ONE_YEAR_AGO;
        }
    }

    private static long toSeconds(long date) {
        return date / 1000L;
    }

    private static long toMinutes(long date) {
        return toSeconds(date) / 60L;
    }

    private static long toHours(long date) {
        return toMinutes(date) / 60L;
    }

    private static long toDays(long date) {
        return toHours(date) / 24L;
    }

    private static long toMonths(long date) {
        return toDays(date) / 30L;
    }

    private static long toYears(long date) {
        return toMonths(date) / 365L;
    }


    public static void main(String[] args) throws Exception {
        /*System.out.println(dateTimeToDate(new Date()));
        System.out.println(dateParse("2017-02-04 14:58:20", null));
        System.out.println(dateTimeToDateStringIfTimeEndZero(new Date()));
        System.out.println(dateTimeToDateStringIfTimeEndZero(dateTimeToDate(new Date())));*/
        //System.out.println(dateBetween(dateParse("2017-01-30", null), dateParse("2017-02-01", null)));
        //System.out.println(dateBetweenIncludeToday(dateParse("2017-01-30", null), dateParse("2017-02-01", null)));
//        System.out.println(getDate(dateParse("2017-01-17", null)));
        /*
        System.out.println(getDaysOfMonth(dateParse("2017-02-01", null)));
        System.out.println(getDaysOfYear(dateParse("2017-01-30", null)));*/
        //System.out.println(dateFormat(dateAddMonths(dateParse("2017-02-07", StrUtils.MONTH_PATTERN), -12), StrUtils.MONTH_PATTERN));
        /*System.out.println(dateFormat(maxDateOfMonth(dateParse("2016-02", "yyyy-MM")), null));
        System.out.println(dateFormat(minDateOfMonth(dateParse("2016-03-31", null)), null));*/
        System.out.println(getLast12Months(1));
    }


}