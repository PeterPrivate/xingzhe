package com.gxy.common;

import lombok.Data;

/**
 * Created by guanxy on 2017/11/19.
 */
@Data
public class ObjResponse<T> {
    private Integer total;
    private T rows;

    public ObjResponse(){

    }

    public ObjResponse(Integer total,T rows){
        this.total = total;
        this.rows = rows;
    }
}
