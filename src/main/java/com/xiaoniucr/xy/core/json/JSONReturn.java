package com.xiaoniucr.xy.core.json;

import java.io.Serializable;


public class JSONReturn implements Serializable {

    private static final long serialVersionUID = -9040660305368048213L;

    //success
    private static final int CODE_SUCCESS = 200;

    //failure
    private static final int CODE_FAILED = 500;

    //Return status code
    private int code;
    //Return the message body
    private Object body;

    /**
     * Original structure
     */
    public JSONReturn() {
    }

    /**
     * With parameter structure
     * @param code
     * @param body
     */
    public JSONReturn(int code, Object body) {
        super();
        this.code = code;
        this.body = body;
    }

    /**
     * Return messages based on status code and content
     * @param code status code
     * @param body message body
     * @return
     */
    public static JSONReturn build(int code, Object body){
        return new JSONReturn(code,body);
    }

    /**
     * Return success
     * @param body Success message body
     * @return
     */
    public static JSONReturn buildSuccess(Object body){
        return new JSONReturn(CODE_SUCCESS,body);
    }

    /**
     * Return failed
     * @param body Failure message body
     * @return
     */
    public static JSONReturn buildFailure(Object body){
        return new JSONReturn(CODE_FAILED,body);
    }



    public int getCode() {
        return code;
    }

    public void setCode(int code) {
        this.code = code;
    }

    public Object getBody() {
        return body;
    }

    public void setBody(Object body) {
        this.body = body;
    }
}
