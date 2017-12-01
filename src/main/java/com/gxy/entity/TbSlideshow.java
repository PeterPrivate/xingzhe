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
 * 轮播图
 * </p>
 *
 * @author guanxy
 * @since 2017-11-19
 */
@TableName("tb_slideshow")
public class TbSlideshow extends Model<TbSlideshow> {

    private static final long serialVersionUID = 1L;

    /**
     * 主键
     */
	@TableId(value="id", type= IdType.AUTO)
	private Long id;
    /**
     * 是否文章，0-是，1-否
     */
	@TableField("is_article")
	private Integer isArticle;
	@TableField("article_id")
	private Long articleId;
    /**
     * 轮播图名称
     */
	private String name;
    /**
     * 图片路径
     */
	@TableField("img_path")
	private String imgPath;
    /**
     * 图片指向的链接
     */
	@TableField("img_link")
	private String imgLink;
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

	public Integer getIsArticle() {
		return isArticle;
	}

	public void setIsArticle(Integer isArticle) {
		this.isArticle = isArticle;
	}

	public Long getArticleId() {
		return articleId;
	}

	public void setArticleId(Long articleId) {
		this.articleId = articleId;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getImgPath() {
		return imgPath;
	}

	public void setImgPath(String imgPath) {
		this.imgPath = imgPath;
	}

	public String getImgLink() {
		return imgLink;
	}

	public void setImgLink(String imgLink) {
		this.imgLink = imgLink;
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
		return "TbSlideshow{" +
			"id=" + id +
			", isArticle=" + isArticle +
			", articleId=" + articleId +
			", name=" + name +
			", imgPath=" + imgPath +
			", imgLink=" + imgLink +
			", createTime=" + createTime +
			", updateTime=" + updateTime +
			", deleteFlag=" + deleteFlag +
			", status=" + status +
			"}";
	}
}
