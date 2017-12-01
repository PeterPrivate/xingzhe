package com.gxy.service.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.gxy.entity.TbTutor;
import com.gxy.service.ITbTutorService;
import org.junit.Before;
import org.junit.Test;
import org.springframework.context.support.ClassPathXmlApplicationContext;

import static org.junit.Assert.*;

/**
 * Created by guanxy on 2017/11/19.
 */
public class TbTutorServiceImplTest {
    ClassPathXmlApplicationContext context;
    @Before
    public void setUp() throws Exception {
        context = new ClassPathXmlApplicationContext("classpath:spring/spring-config.xml");
    }

    @Test
    public void test(){
        ITbTutorService tbTutorServiceImpl = (ITbTutorService) context.getBean("tbTutorServiceImpl");
        int i = tbTutorServiceImpl.selectCount(new EntityWrapper<TbTutor>());
        System.out.println(i);
    }

}