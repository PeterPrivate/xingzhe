package com.gxy.entity;

import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.enums.FieldFill;
import com.baomidou.mybatisplus.enums.IdType;
import com.fasterxml.jackson.annotation.JsonFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * <p>
 * 组织机构
 * </p>
 *
 * @author guanxy
 * @since 2017-11-19
 */
public class Organization extends Model<Organization> {

    private static final long serialVersionUID = 1L;

    /**
     * 主键id
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 组织名
     */
	private String name;
    /**
     * 地址
     */
	private String address;
    /**
     * 编号
     */
	private String code;
    /**
     * 图标
     */
	private String icon;
    /**
     * 父级主键
     */
	private Long pid;
    /**
     * 排序
     */
	private Integer seq;
    /**
     * 创建时间
     */
	@TableField(value = "create_time" ,fill = FieldFill.INSERT)
	@JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss.SSSZ", locale = "zh", timezone = "GMT+8")
	private Date createTime;


	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getAddress() {
		return address;
	}

	public void setAddress(String address) {
		this.address = address;
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getIcon() {
		return icon;
	}

	public void setIcon(String icon) {
		this.icon = icon;
	}

	public Long getPid() {
		return pid;
	}

	public void setPid(Long pid) {
		this.pid = pid;
	}

	public Integer getSeq() {
		return seq;
	}

	public void setSeq(Integer seq) {
		this.seq = seq;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

	@Override
	public String toString() {
		return "Organization{" +
			"id=" + id +
			", name=" + name +
			", address=" + address +
			", code=" + code +
			", icon=" + icon +
			", pid=" + pid +
			", seq=" + seq +
			", createTime=" + createTime +
			"}";
	}
}
