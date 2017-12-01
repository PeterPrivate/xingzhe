package com.gxy.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.gxy.common.MsgCode;
import com.gxy.common.MsgResponse;
import com.gxy.entity.Organization;
import com.gxy.mapper.OrganizationMapper;
import com.gxy.service.IOrganizationService;
import com.gxy.vo.OrganizationVo;
import com.gxy.vo.TreeVo;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 组织机构 服务实现类
 * </p>
 *
 * @author guanxy
 * @since 2017-11-19
 */
@Service
public class OrganizationServiceImpl extends ServiceImpl<OrganizationMapper, Organization> implements IOrganizationService {


    public List<OrganizationVo> selectTreeGrid() {
        List<Organization> organizationList = super.selectList(new EntityWrapper<Organization>());
        List<OrganizationVo> list = new ArrayList<OrganizationVo>();
        for (Organization organization:organizationList) {
            OrganizationVo vo = new OrganizationVo();
            BeanUtils.copyProperties(organization,vo);
            vo.setIconCls(organization.getIcon());
            list.add(vo);
        }
        return list;
    }

    public MsgResponse addOrganization(Organization organization){
        Organization o = super.selectOne(new EntityWrapper<Organization>().eq("name", organization.getName()));
        if (o==null){
            boolean b = super.insert(organization);
            return new MsgResponse(b, MsgCode.ADDSUCCESS);
        }else{
            return new MsgResponse(false,"组织名已存在！");
        }
    }

    public List<TreeVo> selectTree(){
        List<Organization> organizationList = super.selectList(new EntityWrapper<Organization>());
        List<TreeVo> voList = new ArrayList<TreeVo>();
        for (Organization or:organizationList) {
            TreeVo vo = new TreeVo();
            BeanUtils.copyProperties(or,vo);
            vo.setChecked(false);
            vo.setIconCls(or.getIcon());
            vo.setText(or.getName());
            vo.setState("open");
            voList.add(vo);
        }
        return voList;
    }
}
