package com.gxy.service;

import com.baomidou.mybatisplus.service.IService;
import com.gxy.common.MsgResponse;
import com.gxy.entity.Role;
import com.gxy.vo.TreeVo;

import java.util.List;

/**
 * <p>
 * 角色 服务类
 * </p>
 *
 * @author guanxy
 * @since 2017-11-14
 */
public interface IRoleService extends IService<Role> {

    List<Role> selectRoleListByUserId(Long userId);

    List<Long> selectResourceIdListByRoleId(Long id);

    List<TreeVo> selectTree();

    MsgResponse grant(Long id, Long[] resourceIds);
}
