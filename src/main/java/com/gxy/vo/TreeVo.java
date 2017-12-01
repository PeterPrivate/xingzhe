package com.gxy.vo;

import lombok.Data;

/**
 * Created by guanxy on 2017/11/20.
 */
@Data
public class TreeVo {
    private Long id;
    private String text;
    private String state;
    private boolean checked;
    private String attributes;
    private String iconCls;
    private Long pid;
    private String openMode;
}
