package com.sdut.jgzj.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.sdut.jgzj.bean.Employee;
import com.sdut.jgzj.bean.Msg;
import com.sdut.jgzj.service.EmployeeService;

@Controller
public class EmployeeController {
	@Autowired
	EmployeeService employeeService;
	@RequestMapping("/emps")
	@ResponseBody
	public Msg getEmpWithJson(@RequestParam(value="pn",defaultValue="1")Integer pn) {
		PageHelper.startPage(pn, 5);
		List<Employee> employee = employeeService.getAll();
		PageInfo page = new PageInfo(employee,5);
		return Msg.success().add("pageInfo", page);
	}
//	@RequestMapping("/emps")
	public String getEmps(@RequestParam(value="pn",defaultValue="1")Integer pn,Model model) {
		PageHelper.startPage(pn, 5);
		List<Employee> employee = employeeService.getAll();
		PageInfo page = new PageInfo(employee,5);
		model.addAttribute("pageInfo", page);
		return "list";
	}
}
