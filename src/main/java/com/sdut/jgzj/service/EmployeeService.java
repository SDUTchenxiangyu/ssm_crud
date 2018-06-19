package com.sdut.jgzj.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.sdut.jgzj.bean.Employee;
import com.sdut.jgzj.bean.EmployeeExample;
import com.sdut.jgzj.bean.EmployeeExample.Criteria;
import com.sdut.jgzj.dao.EmployeeMapper;
@Service
public class EmployeeService {
	@Autowired
	EmployeeMapper employeeMapper;
	
	public List<Employee> getAll() {
		// TODO Auto-generated method stub
		return employeeMapper.selectByExampleWithDept(null);
	}

	public void saveEmp(Employee employee) {
		// TODO Auto-generated method stub
		employeeMapper.insertSelective(employee);
	}

	public boolean checkUser(String empName) {
		// TODO Auto-generated method stub
		EmployeeExample example = new EmployeeExample();
		Criteria criteria =  example.createCriteria();
		criteria.andEmpNameEqualTo(empName);
		long count = employeeMapper.countByExample(example);
		return count == 0;
	}

}
