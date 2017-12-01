package com.gxy.entity;

import java.io.Serializable;

import com.baomidou.mybatisplus.enums.IdType;
import java.util.Date;
import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableField;
import com.baomidou.mybatisplus.activerecord.Model;
import com.baomidou.mybatisplus.annotations.TableName;
import java.io.Serializable;

/**
 * <p>
 * 导师
 * </p>
 *
 * @author guanxy
 * @since 2017-11-19
 */
@TableName("tb_tutor")
public class TbTutor extends Model<TbTutor> {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 姓名
     */
	private String name;
    /**
     * 姓名全拼（包含英文字母不处理）
     */
	@TableField("name_pinyin")
	private String namePinyin;
    /**
     * 姓名首字母
     */
	@TableField("name_initial")
	private String nameInitial;
    /**
     * 头像路径
     */
	@TableField("head_img")
	private String headImg;
    /**
     * 是否首页展示，0-是，1-否
     */
	@TableField("is_home_display")
	private Integer isHomeDisplay;
    /**
     * 头像路径（额外的首页展示）
     */
	@TableField("head_img_extra")
	private String headImgExtra;
    /**
     * 公司
     */
	private String company;
    /**
     * 职位
     */
	private String position;
    /**
     * 常驻地
     */
	@TableField("permanent_land")
	private String permanentLand;
    /**
     * 简短简介
     */
	@TableField("short_intro")
	private String shortIntro;
    /**
     * 简介
     */
	private String intro;
    /**
     * 是否大咖，0-是，1-否
     */
	@TableField("is_master")
	private Integer isMaster;
    /**
     * 领域类型id,如：,1,2,
     */
	@TableField("domain_type")
	private String domainType;
    /**
     * 排序值，值越大排越前
     */
	@TableField("sort_value")
	private Integer sortValue;
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

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getNamePinyin() {
		return namePinyin;
	}

	public void setNamePinyin(String namePinyin) {
		this.namePinyin = namePinyin;
	}

	public String getNameInitial() {
		return nameInitial;
	}

	public void setNameInitial(String nameInitial) {
		this.nameInitial = nameInitial;
	}

	public String getHeadImg() {
		return headImg;
	}

	public void setHeadImg(String headImg) {
		this.headImg = headImg;
	}

	public Integer getIsHomeDisplay() {
		return isHomeDisplay;
	}

	public void setIsHomeDisplay(Integer isHomeDisplay) {
		this.isHomeDisplay = isHomeDisplay;
	}

	public String getHeadImgExtra() {
		return headImgExtra;
	}

	public void setHeadImgExtra(String headImgExtra) {
		this.headImgExtra = headImgExtra;
	}

	public String getCompany() {
		return company;
	}

	public void setCompany(String company) {
		this.company = company;
	}

	public String getPosition() {
		return position;
	}

	public void setPosition(String position) {
		this.position = position;
	}

	public String getPermanentLand() {
		return permanentLand;
	}

	public void setPermanentLand(String permanentLand) {
		this.permanentLand = permanentLand;
	}

	public String getShortIntro() {
		return shortIntro;
	}

	public void setShortIntro(String shortIntro) {
		this.shortIntro = shortIntro;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public Integer getIsMaster() {
		return isMaster;
	}

	public void setIsMaster(Integer isMaster) {
		this.isMaster = isMaster;
	}

	public String getDomainType() {
		return domainType;
	}

	public void setDomainType(String domainType) {
		this.domainType = domainType;
	}

	public Integer getSortValue() {
		return sortValue;
	}

	public void setSortValue(Integer sortValue) {
		this.sortValue = sortValue;
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
		return "TbTutor{" +
			"id=" + id +
			", name=" + name +
			", namePinyin=" + namePinyin +
			", nameInitial=" + nameInitial +
			", headImg=" + headImg +
			", isHomeDisplay=" + isHomeDisplay +
			", headImgExtra=" + headImgExtra +
			", company=" + company +
			", position=" + position +
			", permanentLand=" + permanentLand +
			", shortIntro=" + shortIntro +
			", intro=" + intro +
			", isMaster=" + isMaster +
			", domainType=" + domainType +
			", sortValue=" + sortValue +
			", createTime=" + createTime +
			", updateTime=" + updateTime +
			", deleteFlag=" + deleteFlag +
			", status=" + status +
			"}";
	}
}
