package com.gxy.controller;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.gxy.common.GetRequest;
import com.gxy.common.MsgCode;
import com.gxy.common.MsgResponse;
import com.gxy.common.ObjResponse;
import com.gxy.entity.User;
import com.gxy.service.IUserService;
import com.gxy.vo.UserOrgVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Arrays;
import java.util.List;

/**
 * <p>
 * 用户 前端控制器
 * </p>
 *
 * @author guanxy
 * @since 2017-11-14
 */
@Controller
@RequestMapping("/user")
public class UserController {

    @Autowired
    private IUserService userService;

    @PostMapping("dataGrid")
    @ResponseBody
    public ObjResponse dataGrid(User user,GetRequest getRequest) {
        List<UserOrgVo> list = userService.selectDataGrid(user,getRequest);
        List<UserOrgVo> list1;
        if (list.size() > getRequest.getPage()*getRequest.getRows()) {
            list1 = list.subList((getRequest.getPage() - 1) * getRequest.getRows(), (getRequest.getPage() - 1) * getRequest.getRows() + getRequest.getRows());
        } else {
            list1 = list.subList((getRequest.getPage() - 1) * getRequest.getRows(),list.size());
        }
        int count = userService.selectCount(new EntityWrapper<User>(user));
        return new ObjResponse(count, list1);
    }

    @GetMapping("addPage")
    public String addPage() {
        return "admin/user/userAdd";
    }

    @PostMapping("add")
    @ResponseBody
    public MsgResponse add(User user,Long[] roleIds) {
        List<Long> list = Arrays.asList(roleIds);
        return userService.addUser(user,list);
    }

    @GetMapping("editPage")
    public String editPage(Model model,Long id) {
        User user = userService.selectById(id);
        List<Long> roleIds = userService.selectRoleIds(id);
        model.addAttribute(user);
        model.addAttribute("roleIds",roleIds);
        return "admin/user/userEdit";
    }

    @PostMapping("edit")
    @ResponseBody
    public MsgResponse edit(User user,Long[] roleIds) {
        List<Long> list = Arrays.asList(roleIds);
        return userService.editUser(user,list);
    }

    @PostMapping("delete")
    @ResponseBody
    public MsgResponse delete(User user) {
        boolean b = userService.delete(new EntityWrapper<User>(user));
        if (b) {
            return new MsgResponse(b, MsgCode.DELSUCCESS);
        } else {
            return new MsgResponse(b, MsgCode.DELFAIL);
        }
    }

    @GetMapping("manager")
    public String manager(){
        return "admin/user/user";
    }


}
