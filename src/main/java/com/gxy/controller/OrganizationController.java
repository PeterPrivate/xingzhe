package com.gxy.controller;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.gxy.common.MsgCode;
import com.gxy.common.MsgResponse;
import com.gxy.entity.Organization;
import com.gxy.service.IOrganizationService;
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
 * 组织机构 前端控制器
 * </p>
 *
 * @author guanxy
 * @since 2017-11-19
 */
@Controller
@RequestMapping("/organization")
public class OrganizationController {

    @Autowired
    private IOrganizationService organizationService;

    @RequestMapping("treeGrid")
    @ResponseBody
    public List treeGrid(){
        return organizationService.selectTreeGrid();
    }

    @GetMapping("addPage")
    public String addPage(){
        return "admin/organization/organizationAdd";
    }

    @PostMapping("add")
    @ResponseBody
    public MsgResponse add(Organization organization){
        return organizationService.addOrganization(organization);
    }

    @GetMapping("editPage")
    public String editPage(Model model,Long id){
        Organization organization = organizationService.selectById(id);
        model.addAttribute(organization);
        return "admin/organization/organizationEdit";
    }

    @PostMapping("edit")
    @ResponseBody
    public MsgResponse edit(Organization organization){
        boolean b = organizationService.updateById(organization);
        if (b){
            return new MsgResponse(b,MsgCode.EDITSUCCESS);
        }else{
            return new MsgResponse(b,MsgCode.EDITFAIL);
        }
    }

    @PostMapping("delete")
    @ResponseBody
    public MsgResponse delete(Organization organization){
        boolean b = organizationService.delete(new EntityWrapper<Organization>(organization));
        if (b){
            return new MsgResponse(b, MsgCode.DELSUCCESS);
        }else{
            return new MsgResponse(b, MsgCode.DELFAIL);
        }
    }

    @PostMapping("tree")
    @ResponseBody
    public List<TreeVo> tree(){
        return organizationService.selectTree();
    }


    @GetMapping("manager")
    public String manager(){
        return "admin/organization/organization";
    }

}
