package com.gxy.controller;


import com.gxy.common.MsgCode;
import com.gxy.common.MsgResponse;
import com.gxy.entity.Resource;
import com.gxy.service.IResourceService;
import com.gxy.vo.ResourceVo;
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
 * 资源 前端控制器
 * </p>
 *
 * @author guanxy
 * @since 2017-11-14
 */
@Controller
@RequestMapping("/resource")
public class ResourceController {

    @Autowired
    private IResourceService resourceService;

    @PostMapping("treeGrid")
    @ResponseBody
    public List<ResourceVo> treeGrid() {
        return resourceService.selectResourceVoList();
    }

    @PostMapping("allTrees")
    @ResponseBody
    public List<TreeVo> allTrees() {
        return resourceService.selectAllTrees();
    }

    @PostMapping("allTree")
    @ResponseBody
    public List<TreeVo> allTree(){ return resourceService.selectResourceVoListByType(); }

    @PostMapping("tree")
    @ResponseBody
    public List<TreeVo> tree() {
        return resourceService.selectResourceTree();
    }

    @GetMapping("addPage")
    public String addPage(){
        return "admin/resource/resourceAdd";
    }

    @PostMapping("add")
    @ResponseBody
    public MsgResponse add(Resource resource) {
        boolean b = resourceService.insert(resource);
        if (b) {
            return new MsgResponse(b, MsgCode.ADDSUCCESS);
        } else {
            return new MsgResponse(b, MsgCode.ADDFAIL);
        }
    }

    @GetMapping("editPage")
    public String editPage(Model model,Long id){
        Resource resource = resourceService.selectById(id);
        model.addAttribute(resource);
        return "admin/resource/resourceEdit";
    }

    @PostMapping("edit")
    @ResponseBody
    public MsgResponse edit(Resource resource) {
        boolean b = resourceService.updateById(resource);
        if (b) {
            return new MsgResponse(b, MsgCode.EDITSUCCESS);
        } else {
            return new MsgResponse(b, MsgCode.EDITFAIL);
        }
    }

    @PostMapping("delete")
    @ResponseBody
    public MsgResponse deleteById(Long id){
        boolean b = resourceService.deleteById(id);
        if (b){
            return new MsgResponse(b,MsgCode.DELSUCCESS);
        }else{
            return new MsgResponse(b,MsgCode.ADDFAIL);
        }
    }

    @GetMapping("manager")
    public String manager(){
        return "admin/resource/resource";
    }



}
