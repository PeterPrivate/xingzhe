package com.gxy.service;

import com.baomidou.mybatisplus.service.IService;
import com.gxy.common.GetRequest;
import com.gxy.common.MsgResponse;
import com.gxy.entity.User;
import com.gxy.vo.UserOrgVo;

import java.util.List;

/**
 * <p>
 * 用户 服务类
 * </p>
 *
 * @author guanxy
 * @since 2017-11-14
 */
public interface IUserService extends IService<User> {
    List<UserOrgVo> selectDataGrid(User user,GetRequest getRequest);

    MsgResponse addUser(User user,List<Long> roleIds);

    MsgResponse editUser(User user,List<Long> roleIds);

    List<Long> selectRoleIds(Long id);

}
