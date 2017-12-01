package com.gxy.common;

import lombok.Data;

/**
 * Created by guanxy on 2017/11/22.
 */
@Data
public class GetRequest {
    private String name;
    private String createdateStart;
    private String createdateEnd;
    private Integer page;
    private Integer rows;
    private String sort;
    private String order;
}
