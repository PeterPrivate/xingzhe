package com.gxy.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * Created by guanxy on 2017/11/19.
 */
@Data
public class ResourceVo {
    private Long id;
    private String name;
    private String url;
    private String openMode;
    private String description;
    private Long pid;
    private Integer seq;
    private Integer status;
    private Integer opened;
    private Integer resourceType;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSZ", locale = "zh", timezone = "GMT+8")
    private Date createTime;
    private String iconCls;
}
