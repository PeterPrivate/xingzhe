package com.gxy.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.gxy.entity.Resource;
import com.gxy.mapper.ResourceMapper;
import com.gxy.service.IResourceService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.gxy.vo.ResourceVo;
import com.gxy.vo.TreeVo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 资源 服务实现类
 * </p>
 *
 * @author guanxy
 * @since 2017-11-14
 */
@Service
public class ResourceServiceImpl extends ServiceImpl<ResourceMapper, Resource> implements IResourceService {

    public List<Resource> selectResourceListInRoleId(List<Long> roleId) {
        return baseMapper.selectResourceListInRoleId(roleId);
    }

    public List<ResourceVo> selectResourceVoList() {
        List<Resource> list = super.selectList(new EntityWrapper<Resource>());
        return changeToVo(list);
    }

    public List<TreeVo> selectResourceVoListByType(){
        List<Resource> list = super.selectList(new EntityWrapper<Resource>().eq("resource_type",0));
        return changeToTree(list);
    }

    private List<ResourceVo> changeToVo(List<Resource> list){
        List<ResourceVo> voList = new ArrayList<ResourceVo>();
        for (Resource resource:list) {
            ResourceVo resourceVo = new ResourceVo();
            BeanUtils.copyProperties(resource,resourceVo);
            resourceVo.setIconCls(resource.getIcon());
            voList.add(resourceVo);
        }
        return voList;
    }

    public List<TreeVo> selectResourceTree(){
        List<Resource> resources = super.selectList(new EntityWrapper<Resource>().eq("resource_type",0));
        return changeToTree(resources);
    }

    public List<TreeVo> selectAllTrees(){
        List<Resource> resources = super.selectList(new EntityWrapper<Resource>());
        return changeToTree(resources);
    }

    private List<TreeVo> changeToTree(List<Resource> resources){
        List<TreeVo> list = new ArrayList<TreeVo>();
        for (Resource resource:resources) {
            TreeVo vo = new TreeVo();
            BeanUtils.copyProperties(resource,vo);
            vo.setText(resource.getName());
            vo.setChecked(resource.getStatus()!=0);
            vo.setState(resource.getOpened()==1?"open":"close");
            vo.setAttributes(resource.getUrl());
            vo.setIconCls(resource.getIcon());
            list.add(vo);
        }
        return list;
    }


}
