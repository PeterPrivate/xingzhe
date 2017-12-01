package com.gxy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.gxy.entity.Role;

import java.util.List;

/**
 * <p>
  * 角色 Mapper 接口
 * </p>
 *
 * @author guanxy
 * @since 2017-11-14
 */
public interface RoleMapper extends BaseMapper<Role> {

    List<Role> selectRoleListByUserId(Long userId);

    List<Long> selectResourceIdListByRoleId(Long id);

    List<String> selectNameListById(Long id);
}