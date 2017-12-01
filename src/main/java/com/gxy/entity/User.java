package com.gxy.entity;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.FieldFill;
import com.baomidou.mybatisplus.enums.IdType;
import com.fasterxml.jackson.annotation.JsonFormat;
import lombok.Data;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 用户
 * </p>
 *
 * @author guanxy
 * @since 2017-11-14
 */
@Data
public class User extends Model<User> {

    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 登陆名
     */
	@TableField("login_name")
	private String loginName;
    /**
     * 用户名
     */
	private String name;
    /**
     * 密码
     */
	private String password;
    /**
     * 密码加密盐
     */
	private String salt;
    /**
     * 性别
     */
	private Integer sex;
    /**
     * 年龄
     */
	private Integer age;
    /**
     * 手机号
     */
	private String phone;
    /**
     * 用户类别
     */
	@TableField("user_type")
	private Integer userType;
    /**
     * 用户状态
     */
	private Integer status;
    /**
     * 所属机构
     */
	@TableField("organization_id")
	private Integer organizationId;
    /**
     * 创建时间
     */
	@TableField(value = "create_time",fill = FieldFill.INSERT)
	@JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSZ", locale = "zh", timezone = "GMT+8")
	private Date createTime;


	protected Serializable pkVal() {
		return this.id;
	}

	public User() {
	}

	public User(String loginName) {

		this.loginName = loginName;
	}
}
