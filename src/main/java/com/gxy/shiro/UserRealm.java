package com.gxy.shiro;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.gxy.entity.Resource;
import com.gxy.entity.Role;
import com.gxy.entity.User;
import com.gxy.service.IResourceService;
import com.gxy.service.IRoleService;
import com.gxy.service.IUserService;
import org.apache.shiro.authc.AuthenticationException;
import org.apache.shiro.authc.AuthenticationInfo;
import org.apache.shiro.authc.AuthenticationToken;
import org.apache.shiro.authc.SimpleAuthenticationInfo;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by guanxy on 2017/11/14.
 */
public class UserRealm extends AuthorizingRealm{
    private String salt = "test";
    @Autowired
    private IUserService userService;
    @Autowired
    private IRoleService roleService;
    @Autowired
    private IResourceService resourceService;

    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principalCollection) {
        String username = (String) principalCollection.getPrimaryPrincipal();
        User user = userService.selectOne(new EntityWrapper<User>(new User(username)));
        //根据userId获取所有的role
        List<Role> roleList = roleService.selectRoleListByUserId(user.getId());
        List<Long> roleIdList = new ArrayList<Long>();
        Set<String> roleNameList = new HashSet<String>();
        for (Role role:roleList) {
            roleIdList.add(role.getId());
            roleNameList.add(role.getName());
        }
        List<Resource> resourceList = resourceService.selectResourceListInRoleId(roleIdList);
        Set<String> urlSet = new HashSet<String>();
        for (Resource re: resourceList) {
            urlSet.add(re.getUrl());
        }
        SimpleAuthorizationInfo info = new SimpleAuthorizationInfo();
        info.setRoles(roleNameList);
        info.addStringPermissions(urlSet);
        return info;
    }

    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken authenticationToken) throws AuthenticationException {
        String username = (String) authenticationToken.getPrincipal();
        User user = userService.selectOne(new EntityWrapper<User>(new User(username)));
        return new SimpleAuthenticationInfo(user.getLoginName(),user.getPassword(), ByteSource.Util.bytes(salt),getName());
    }
}
