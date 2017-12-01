package com.gxy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.gxy.common.MsgResponse;
import com.gxy.entity.Organization;

/**
 * <p>
  * 组织机构 Mapper 接口
 * </p>
 *
 * @author guanxy
 * @since 2017-11-19
 */
public interface OrganizationMapper extends BaseMapper<Organization> {
    String selectNameById(Long id);


}