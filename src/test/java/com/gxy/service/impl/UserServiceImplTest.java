package com.gxy.service.impl;

import com.gxy.service.IUserService;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import java.util.List;

/**
 * Created by guanxy on 2017/11/22.
 */
public class UserServiceImplTest {

    ClassPathXmlApplicationContext context;

    @Before
    public void setUp() throws Exception {
        context = new ClassPathXmlApplicationContext("classpath:spring/spring-config.xml");
    }

    @Test
    public void test() throws Exception {
        IUserService service = (IUserService) context.getBean("userServiceImpl");
        List<Long> roleIds = service.selectRoleIds((long) 1);
        System.out.println(roleIds);
    }
}