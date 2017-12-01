package com.gxy.service;

import com.baomidou.mybatisplus.service.IService;
import com.gxy.common.MsgResponse;
import com.gxy.entity.Organization;
import com.gxy.vo.OrganizationVo;
import com.gxy.vo.TreeVo;

import java.util.List;

/**
 * <p>
 * 组织机构 服务类
 * </p>
 *
 * @author guanxy
 * @since 2017-11-19
 */
public interface IOrganizationService extends IService<Organization> {

    List<OrganizationVo> selectTreeGrid();

    MsgResponse addOrganization(Organization organization);


    List<TreeVo> selectTree();
	
}
