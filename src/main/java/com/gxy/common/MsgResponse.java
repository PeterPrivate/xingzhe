package com.gxy.common;

import lombok.Data;

/**
 * Created by guanxy on 2017/11/19.
 */
@Data
//@JsonInclude(JsonInclude.Include.NON_NULL)
public class MsgResponse<T> {
    private boolean success;
    private String msg;
    private T obj;

    public MsgResponse() {
    }

    public MsgResponse(boolean success, String msg, T obj) {

        this.success = success;
        this.msg = msg;
        this.obj = obj;
    }

    public MsgResponse(boolean success, String msg) {
        this.success = success;
        this.msg = msg;
    }

    public MsgResponse(boolean success) {
        this.success = success;
    }
}
