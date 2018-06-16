package com.sdut.jgzj.test;

import java.util.UUID;

import org.apache.ibatis.session.SqlSession;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.sdut.jgzj.bean.Department;
import com.sdut.jgzj.bean.Employee;
import com.sdut.jgzj.dao.DepartmentMapper;
import com.sdut.jgzj.dao.EmployeeMapper;

public class MapperTest {
//	@Autowired
//	SqlSession sqlSession;
//	@Autowired
//	EmployeeMapper employeeMapper;
	@Test
	public void testCRUD() {
		ApplicationContext ioc = new ClassPathXmlApplicationContext("applicationContext.xml");
		DepartmentMapper beans = ioc.getBean(DepartmentMapper.class);
//		beans.insertSelective(new Department(null,"开发部"));
//		beans.insertSelective(new Department(null,"测试部"));
		EmployeeMapper employeeMapper = ioc.getBean(EmployeeMapper.class);
		SqlSession sqlSession = ioc.getBean(SqlSession.class);
//		employeeMapper.insertSelective(new Employee(null, "陈翔宇", "M", "17864309139@163.com", 1));
		EmployeeMapper mapper = sqlSession.getMapper(EmployeeMapper.class);
		for(int i = 0 ; i < 1000 ; i++ ) {
			String uid = UUID.randomUUID().toString().substring(0, 5) + i;
			mapper.insertSelective(new Employee(null, uid, "M", uid+"@163.com", 1));
		}
		System.out.println("批量结束！");
	}
}
