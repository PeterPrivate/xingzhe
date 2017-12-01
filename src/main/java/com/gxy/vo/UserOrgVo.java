package com.gxy.vo;

import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.util.Date;
import java.util.List;

/**
 * Created by guanxy on 2017/11/19.
 */
@Data
public class UserOrgVo {
    private String organizationName;
    private Integer sex;
    private Integer organizationId;
    private String password;
    private List rolesList;
    private String phone;
    @JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSZ", locale = "zh", timezone = "GMT+8")
    private Date createTime;
    private String loginName;
    private String name;
    private Long id;
    private Integer userType;
    private Integer age;
    private Integer status;
}
