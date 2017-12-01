package com.gxy.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.gxy.common.GetRequest;
import com.gxy.common.MsgCode;
import com.gxy.common.MsgResponse;
import com.gxy.entity.User;
import com.gxy.entity.UserRole;
import com.gxy.mapper.OrganizationMapper;
import com.gxy.mapper.RoleMapper;
import com.gxy.mapper.UserMapper;
import com.gxy.mapper.UserRoleMapper;
import com.gxy.service.IUserService;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import com.gxy.vo.UserOrgVo;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

/**
 * <p>
 * 用户 服务实现类
 * </p>
 *
 * @author guanxy
 * @since 2017-11-14
 */
@Service
public class UserServiceImpl extends ServiceImpl<UserMapper, User> implements IUserService {

    @Autowired
    private OrganizationMapper organizationMapper;
    @Autowired
    private RoleMapper roleMapper;
    @Autowired
    private UserRoleMapper userRoleMapper;

    public List<UserOrgVo> selectDataGrid(User user,GetRequest getRequest) {
        List<User> userList = super.selectList(new EntityWrapper<User>(user).orderBy(getRequest.getSort(),getRequest.getOrder().equals("asc")));
        List<UserOrgVo> listVo = new ArrayList<UserOrgVo>();
        for (User u:userList) {
            UserOrgVo userOrgVo = new UserOrgVo();
            BeanUtils.copyProperties(u,userOrgVo);
            Long id = new Long(u.getOrganizationId());
            String organizationName = organizationMapper.selectNameById(id);
            userOrgVo.setOrganizationName(organizationName);
            userOrgVo.setRolesList(roleMapper.selectNameListById(u.getId()));
            listVo.add(userOrgVo);
        }
        return listVo;
    }

    public MsgResponse addUser(User user,List<Long> roleIds){
        User u = super.selectOne(new EntityWrapper<User>().eq("login_name", user.getLoginName()));
        if (u==null){
            boolean b = super.insert(user);
            insertUserRole(user,roleIds);
            return new MsgResponse(b, MsgCode.ADDSUCCESS);
        }else{
            return new MsgResponse(false,"登录名已存在！");
        }
    }

    private void insertUserRole(User user,List<Long> roleIds){
        for (Long roleId:roleIds) {
            UserRole ur = new UserRole();
            ur.setRoleId(roleId);
            ur.setUserId(user.getId());
            userRoleMapper.insert(ur);
        }
    }

    public MsgResponse editUser(User user,List<Long> roleIds){
        boolean b = super.updateById(user);
        if (b){
            userRoleMapper.delete(new EntityWrapper<UserRole>().eq("user_id",user.getId()));
            insertUserRole(user,roleIds);
            return new MsgResponse(b,MsgCode.EDITSUCCESS);
        }else{
            return new MsgResponse(b,MsgCode.EDITFAIL);
        }
    }

    public List<Long> selectRoleIds(Long id){
        return baseMapper.selectRoleIds(id);
    }


}
