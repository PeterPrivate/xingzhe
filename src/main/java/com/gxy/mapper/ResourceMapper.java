package com.gxy.mapper;

import com.gxy.entity.Resource;
import com.baomidou.mybatisplus.mapper.BaseMapper;

import java.util.List;

/**
 * <p>
  * 资源 Mapper 接口
 * </p>
 *
 * @author guanxy
 * @since 2017-11-14
 */
public interface ResourceMapper extends BaseMapper<Resource> {

    List<Resource> selectResourceListInRoleId(List<Long> roleId);


}