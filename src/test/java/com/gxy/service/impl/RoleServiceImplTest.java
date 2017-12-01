package com.gxy.service.impl;

import com.gxy.service.IRoleService;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

/**
 * Created by guanxy on 2017/11/21.
 */
public class RoleServiceImplTest {
    ClassPathXmlApplicationContext context;

    @Before
    public void setUp() throws Exception {
        context = new ClassPathXmlApplicationContext("classpath:spring/spring-config.xml");
    }

    @Test
    public void test() throws Exception {
        IRoleService service = (IRoleService) context.getBean("roleServiceImpl");
        List<Long> list = service.selectResourceIdListByRoleId((long) 1);
        System.out.println(list);
    }
}