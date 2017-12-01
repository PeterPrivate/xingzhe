package com.gxy.controller;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.plugins.Page;
import com.gxy.common.GetRequest;
import com.gxy.common.MsgCode;
import com.gxy.common.MsgResponse;
import com.gxy.common.ObjResponse;
import com.gxy.entity.Role;
import com.gxy.service.IRoleService;
import com.gxy.vo.TreeVo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.List;

/**
 * <p>
 * 角色 前端控制器
 * </p>
 *
 * @author guanxy
 * @since 2017-11-14
 */
@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private IRoleService roleService;

    @PostMapping("findResourceIdListByRoleId")
    @ResponseBody
    public MsgResponse findResourceIdListByRoleId(Long id) {
        List<Long> list = roleService.selectResourceIdListByRoleId(id);
        return new MsgResponse(true, "", list);
    }

    @PostMapping("dataGrid")
    @ResponseBody
    public ObjResponse dataGrid(GetRequest getRequest) {

        Page<Role> page = roleService.selectPage(new Page<Role>(getRequest.getPage(), getRequest.getRows()), new EntityWrapper<Role>().orderBy(getRequest.getSort(), getRequest.getOrder().equals("asc")));


        //int count = roleService.selectCount(new EntityWrapper<Role>());
        return new ObjResponse<List>(page.getTotal(), page.getRecords());
    }

    @PostMapping("add")
    @ResponseBody
    public MsgResponse add(Role role) {
        boolean b = roleService.insert(role);
        if (b) {
            return new MsgResponse(b, MsgCode.ADDSUCCESS);
        } else {
            return new MsgResponse(b, MsgCode.ADDFAIL);
        }
    }


    @GetMapping("addPage")
    public String addPage() {
        return "admin/role/roleAdd";
    }

    @GetMapping("editPage")
    public String editPage(Model model, Long id) {
        Role role = roleService.selectById(id);
        model.addAttribute(role);
        return "admin/role/roleEdit";
    }

    @PostMapping("edit")
    @ResponseBody
    public MsgResponse edit(Role role) {
        boolean b = roleService.updateById(role);
        if (b) {
            return new MsgResponse(b, MsgCode.EDITSUCCESS);
        } else {
            return new MsgResponse(b, MsgCode.EDITFAIL);
        }
    }

    @PostMapping("delete")
    @ResponseBody
    public MsgResponse delete(Role role) {
        boolean b = roleService.delete(new EntityWrapper<Role>(role));
        if (b) {
            return new MsgResponse(b, MsgCode.DELSUCCESS);
        } else {
            return new MsgResponse(b, MsgCode.DELFAIL);
        }
    }

    @GetMapping("manager")
    public String manager() {
        return "admin/role/role";
    }


    @PostMapping("tree")
    @ResponseBody
    public List<TreeVo> tree() {
        return roleService.selectTree();
    }

    @GetMapping("grantPage")
    public String grantPage(Model model, Long id) {
        model.addAttribute("id", id);
        return "admin/role/roleGrant";
    }

    @PostMapping("grant")
    @ResponseBody
    public MsgResponse grant(Long id, Long[] resourceIds) {
        return roleService.grant(id, resourceIds);
    }

}
