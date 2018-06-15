package com.sdut.jgzj.test;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.sdut.jgzj.bean.Department;
import com.sdut.jgzj.dao.DepartmentMapper;

public class MapperTest {
	@Test
	public void testCRUD() {
		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		DepartmentMapper beans = ioc.getBean(DepartmentMapper.class);
		beans.insertSelective(new Department(null,"开发部"));
		beans.insertSelective(new Department(null,"测试部"));
	}
}
