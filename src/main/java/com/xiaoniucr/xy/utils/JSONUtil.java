package com.xiaoniucr.xy.utils;


import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.core.JsonParser;
import com.fasterxml.jackson.databind.DeserializationFeature;
import com.fasterxml.jackson.databind.ObjectMapper;
import com.fasterxml.jackson.databind.SerializationFeature;
import org.springframework.util.StringUtils;

import java.io.InputStream;
import java.io.OutputStream;
import java.io.Reader;
import java.io.Writer;
import java.text.SimpleDateFormat;

/**
 *Jackjson
 * Turn the Json object
 */
public class JSONUtil {
    private static ObjectMapper mapper =  new ObjectMapper();

    static{
        mapper.configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false);
        mapper.configure(JsonParser.Feature.ALLOW_SINGLE_QUOTES, true);
        mapper.configure(JsonParser.Feature.ALLOW_UNQUOTED_FIELD_NAMES, true);

        mapper.configure(SerializationFeature.WRITE_ENUMS_USING_TO_STRING,true);
        mapper.configure(SerializationFeature.FAIL_ON_EMPTY_BEANS, false);
        mapper.setDateFormat(new SimpleDateFormat("dd-MM-yyyy HH:mm:ss"));
        mapper.disable(DeserializationFeature.FAIL_ON_UNKNOWN_PROPERTIES);
        mapper.setSerializationInclusion(JsonInclude.Include.NON_NULL);

    }

    /**
            * Json string to object
* @param value source string
* @Param CLZ The type of the target object
* @param <T>
* @return generic class
*/
    public static <T> T parse(String value, Class<T> clz){

        if (StringUtils.isEmpty(value)) {
            return null;
        }
        try {
            return mapper.readValue(value, clz);
        }
        catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }

    public static <T> T parse(byte[] bytes, Class<T> clz){
        try {
            return mapper.readValue(bytes, clz);
        }
        catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }



    public static <T> T parse(InputStream ins, Class<T> clz){
        try {
            return mapper.readValue(ins, clz);
        }
        catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }


    public static <T> T  parse(Reader reader, Class<T> clz){
        try {
            return mapper.readValue(reader, clz);
        }
        catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }

    @SuppressWarnings("unchecked")
    public static <T> T update(String value, T object) {
        try {
            return (T) mapper.readerForUpdating(object).readValue(value);
        }
        catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }

    public static String writeValueAsString(Object o){
        try {
            return mapper.writeValueAsString(o);
        }
        catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }

    public static void write(OutputStream outs, Object o){
        try {
            mapper.writeValue(outs,o);
        }
        catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }

    public static void write(Writer writer, Object o){
        try {
            mapper.writeValue(writer,o);
        }
        catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }

    public static String toString(Object o){
        try {
            return mapper.writeValueAsString(o);
        }
        catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }

    public static String toString(Object o, Class<?> clz){
        try {
            return mapper.writerWithType(clz).writeValueAsString(o);
        }
        catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }

    public static byte[] toBytes(Object o){
        try {
            return mapper.writeValueAsBytes(o);
        }
        catch (Exception e) {
            throw new IllegalStateException(e);
        }
    }

}
