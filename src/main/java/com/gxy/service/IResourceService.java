package com.gxy.service;

import com.baomidou.mybatisplus.service.IService;
import com.gxy.entity.Resource;
import com.gxy.vo.ResourceVo;
import com.gxy.vo.TreeVo;

import java.util.List;

/**
 * <p>
 * 资源 服务类
 * </p>
 *
 * @author guanxy
 * @since 2017-11-14
 */
public interface IResourceService extends IService<Resource> {

    List<Resource> selectResourceListInRoleId(List<Long> roleId);

    List<ResourceVo> selectResourceVoList();

    List<TreeVo> selectResourceVoListByType();

    List<TreeVo> selectResourceTree();

    List<TreeVo> selectAllTrees();
}
