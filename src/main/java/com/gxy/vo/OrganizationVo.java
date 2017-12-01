package com.gxy.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;

/**
 * Created by guanxy on 2017/11/19.
 */
@Data
public class OrganizationVo {
    private Long id;
    private String name;
    private String address;
    private String code;
    private Long pid;
    private Integer seq;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSZ", locale = "zh", timezone = "GMT+8")
    private Date createTime;
    private String iconCls;
}
