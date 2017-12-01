package com.gxy.entity;

import java.io.Serializable;

import com.baomidou.mybatisplus.enums.IdType;
import java.math.BigDecimal;
import java.util.Date;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;

/**
 * <p>
 * 邀请函
 * </p>
 *
 * @author guanxy
 * @since 2017-11-19
 */
@TableName("tb_invitation")
public class TbInvitation extends Model<TbInvitation> {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 主办方
     */
	private String sponsor;
    /**
     * 联系人
     */
	private String linkman;
    /**
     * 手机号
     */
	private String phone;
    /**
     * 需求描述
     */
	private String desc;
    /**
     * 预算
     */
	private BigDecimal budget;
    /**
     * 导师id
     */
	@TableField("tutor_id")
	private Long tutorId;
    /**
     * 0-未处理，1-已处理
     */
	@TableField("handle_status")
	private Integer handleStatus;
    /**
     * 处理备注
     */
	@TableField("handle_remarks")
	private String handleRemarks;
	@TableField("create_time")
	private Date createTime;
	@TableField("update_time")
	private Date updateTime;
    /**
     * 0-正常，1-删除
     */
	@TableField("delete_flag")
	private Integer deleteFlag;
    /**
     * 0-正常，1-停用
     */
	private Integer status;


	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getSponsor() {
		return sponsor;
	}

	public void setSponsor(String sponsor) {
		this.sponsor = sponsor;
	}

	public String getLinkman() {
		return linkman;
	}

	public void setLinkman(String linkman) {
		this.linkman = linkman;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getDesc() {
		return desc;
	}

	public void setDesc(String desc) {
		this.desc = desc;
	}

	public BigDecimal getBudget() {
		return budget;
	}

	public void setBudget(BigDecimal budget) {
		this.budget = budget;
	}

	public Long getTutorId() {
		return tutorId;
	}

	public void setTutorId(Long tutorId) {
		this.tutorId = tutorId;
	}

	public Integer getHandleStatus() {
		return handleStatus;
	}

	public void setHandleStatus(Integer handleStatus) {
		this.handleStatus = handleStatus;
	}

	public String getHandleRemarks() {
		return handleRemarks;
	}

	public void setHandleRemarks(String handleRemarks) {
		this.handleRemarks = handleRemarks;
	}

	public Date getCreateTime() {
		return createTime;
	}

	public void setCreateTime(Date createTime) {
		this.createTime = createTime;
	}

	public Date getUpdateTime() {
		return updateTime;
	}

	public void setUpdateTime(Date updateTime) {
		this.updateTime = updateTime;
	}

	public Integer getDeleteFlag() {
		return deleteFlag;
	}

	public void setDeleteFlag(Integer deleteFlag) {
		this.deleteFlag = deleteFlag;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}

	@Override
	protected Serializable pkVal() {
		return this.id;
	}

	@Override
	public String toString() {
		return "TbInvitation{" +
			"id=" + id +
			", sponsor=" + sponsor +
			", linkman=" + linkman +
			", phone=" + phone +
			", desc=" + desc +
			", budget=" + budget +
			", tutorId=" + tutorId +
			", handleStatus=" + handleStatus +
			", handleRemarks=" + handleRemarks +
			", createTime=" + createTime +
			", updateTime=" + updateTime +
			", deleteFlag=" + deleteFlag +
			", status=" + status +
			"}";
	}
}
