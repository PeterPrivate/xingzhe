package com.gxy.service.impl;


import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.gxy.entity.Resource;
import com.gxy.service.IResourceService;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by guanxy on 2017/11/15.
 */
public class ResourceServiceImplTest {
    ClassPathXmlApplicationContext context;
    @Before
    public void setUp() throws Exception {
        context = new ClassPathXmlApplicationContext("classpath:spring/spring-config.xml");
    }

    @Test
    public void selectResourceListInRoleId() throws Exception {
        IResourceService resourceService = (IResourceService) context.getBean("resourceServiceImpl");
        List list = new ArrayList();
        list.add(1);
        list.add(2);
        List<Resource> list1 = resourceService.selectResourceListInRoleId(list);
        for (Resource resource: list1) {
            System.out.println(resource.getUrl());
        }
    }

    @Test
    public void test() throws Exception {
        IResourceService resourceService = (IResourceService) context.getBean("resourceServiceImpl");
        List<Resource> list = resourceService.selectList(new EntityWrapper<Resource>().eq("resource_type", 0));
        for (Resource r:list) {
            System.out.println(r.getName());
        }
    }

}
