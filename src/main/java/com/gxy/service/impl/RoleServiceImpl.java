package com.gxy.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.gxy.common.MsgCode;
import com.gxy.common.MsgResponse;
import com.gxy.entity.Role;
import com.gxy.entity.RoleResource;
import com.gxy.mapper.RoleMapper;
import com.gxy.mapper.RoleResourceMapper;
import com.gxy.service.IRoleService;
import com.gxy.vo.TreeVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * <p>
 * 角色 服务实现类
 * </p>
 *
 * @author guanxy
 * @since 2017-11-14
 */
@Service
public class RoleServiceImpl extends ServiceImpl<RoleMapper, Role> implements IRoleService {

    @Autowired
    private RoleResourceMapper roleResourceMapper;

    public List<Role> selectRoleListByUserId(Long userId) {
        return baseMapper.selectRoleListByUserId(userId);
    }

    public List<Long> selectResourceIdListByRoleId(Long id) {
        return baseMapper.selectResourceIdListByRoleId(id);
    }

    public List<TreeVo> selectTree(){
        List<Role> organizationList = super.selectList(new EntityWrapper<Role>());
        List<TreeVo> voList = new ArrayList<TreeVo>();
        for (Role r:organizationList) {
            TreeVo vo = new TreeVo();
            BeanUtils.copyProperties(r,vo);
            vo.setChecked(false);
            vo.setText(r.getName());
            vo.setState("open");
            voList.add(vo);
        }
        return voList;
    }

    public MsgResponse grant(Long id,Long[] resourceIds){
        List<Long> list = baseMapper.selectResourceIdListByRoleId(id);
        List<Long> longs = Arrays.asList(resourceIds);
        List<Long> add = compare(list, longs);
        List<Long> del = compare(longs, list);
        for (Long rid:add) {
            RoleResource roleResource = new RoleResource();
            roleResource.setResourceId(rid);
            roleResource.setRoleId(id);
            roleResourceMapper.insert(roleResource);
        }
        for (Long rid:del) {
            roleResourceMapper.delete(new EntityWrapper<RoleResource>().eq("role_id",id).eq("resource_id",rid));
        }
        return new MsgResponse(true, MsgCode.GRANTSUCCESS);
    }

    private <T> List<T> compare(List<T> t1, List<T> t2) {
        List<T> list = new ArrayList<T>();
        for (T t : t2) {
            if (!t1.contains(t)) {
                list.add(t);
            }
        }
        return list;
    }
}
