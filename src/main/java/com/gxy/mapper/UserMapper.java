package com.gxy.mapper;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import com.gxy.entity.User;

import java.util.List;

/**
 * <p>
  * 用户 Mapper 接口
 * </p>
 *
 * @author guanxy
 * @since 2017-11-14
 */
public interface UserMapper extends BaseMapper<User> {
    List<Long> selectRoleIds(Long id);
}