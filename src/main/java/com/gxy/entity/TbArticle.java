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
 * 
 * </p>
 *
 * @author guanxy
 * @since 2017-11-19
 */
@TableName("tb_article")
public class TbArticle extends Model<TbArticle> {

    private static final long serialVersionUID = 1L;

	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 标题
     */
	private String title;
    /**
     * 显示时间
     */
	@TableField("show_time")
	private Date showTime;
    /**
     * 标题图片
     */
	@TableField("title_img")
	private String titleImg;
    /**
     * 来源类型id
     */
	@TableField("source_type")
	private Integer sourceType;
    /**
     * 简介
     */
	private String intro;
    /**
     * 信息内容
     */
	private String content;
    /**
     * 信息类型id
     */
	@TableField("article_type")
	private Integer articleType;
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

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public Date getShowTime() {
		return showTime;
	}

	public void setShowTime(Date showTime) {
		this.showTime = showTime;
	}

	public String getTitleImg() {
		return titleImg;
	}

	public void setTitleImg(String titleImg) {
		this.titleImg = titleImg;
	}

	public Integer getSourceType() {
		return sourceType;
	}

	public void setSourceType(Integer sourceType) {
		this.sourceType = sourceType;
	}

	public String getIntro() {
		return intro;
	}

	public void setIntro(String intro) {
		this.intro = intro;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public Integer getArticleType() {
		return articleType;
	}

	public void setArticleType(Integer articleType) {
		this.articleType = articleType;
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
		return "TbArticle{" +
			"id=" + id +
			", title=" + title +
			", showTime=" + showTime +
			", titleImg=" + titleImg +
			", sourceType=" + sourceType +
			", intro=" + intro +
			", content=" + content +
			", articleType=" + articleType +
			", sortValue=" + sortValue +
			", createTime=" + createTime +
			", updateTime=" + updateTime +
			", deleteFlag=" + deleteFlag +
			", status=" + status +
			"}";
	}
}
