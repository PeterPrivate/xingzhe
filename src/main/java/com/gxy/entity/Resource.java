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
 * 资源
 * </p>
 *
 * @author guanxy
 * @since 2017-11-14
 */
public class Resource extends Model<Resource> {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 资源名称
     */
	private String name;
    /**
     * 资源路径
     */
	private String url;
    /**
     * 打开方式 ajax,iframe
     */
	@TableField("open_mode")
	private String openMode;
    /**
     * 资源介绍
     */
	private String description;
    /**
     * 资源图标
     */
	private String icon;
    /**
     * 父级资源id
     */
	private Long pid;
    /**
     * 排序
     */
	private Integer seq;
    /**
     * 状态
     */
	private Integer status;
    /**
     * 打开状态
     */
	private Integer opened;
    /**
     * 资源类别
     */
	@TableField("resource_type")
	private Integer resourceType;
    /**
     * 创建时间
     */
	@TableField(value = "create_time",fill = FieldFill.INSERT)
	@JsonFormat(pattern = "yyyy-MM-dd'T'HH:mm:ss", locale = "zh", timezone = "GMT+8")
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

	public String getUrl() {
		return url;
	}

	public void setUrl(String url) {
		this.url = url;
	}

	public String getOpenMode() {
		return openMode;
	}

	public void setOpenMode(String openMode) {
		this.openMode = openMode;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
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

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	public Integer getOpened() {
		return opened;
	}

	public void setOpened(Integer opened) {
		this.opened = opened;
	}

	public Integer getResourceType() {
		return resourceType;
	}

	public void setResourceType(Integer resourceType) {
		this.resourceType = resourceType;
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
		return "Resource{" +
			"id=" + id +
			", name=" + name +
			", url=" + url +
			", openMode=" + openMode +
			", description=" + description +
			", icon=" + icon +
			", pid=" + pid +
			", seq=" + seq +
			", status=" + status +
			", opened=" + opened +
			", resourceType=" + resourceType +
			", createTime=" + createTime +
			"}";
	}
}
