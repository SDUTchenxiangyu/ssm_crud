<%@page import="javax.servlet.descriptor.TaglibDescriptor"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>员工列表</title>
<%
	pageContext.setAttribute("APP_PATH", request.getContextPath());
%>
<script type="text/javascript"
	src="${APP_PATH }/static/jquery/jquery-3.3.1.min.js"></script>
<link
	href="${APP_PATH }/static/bootstrap-3.3.7-dist/css/bootstrap.min.css"
	rel="stylesheet">
<script type="text/javascript"
	src="${APP_PATH }/static/bootstrap-3.3.7-dist/js/bootstrap.min.js"></script>

</head>
<body>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary">新增</button>
				<button class="btn btn-danger">删除</button>
			</div>
		</div>
		<div class="row">
			<div class="col-md-12">
				<table class="table table-hover" id="emps_table">
					<thead>
						<tr>
							<th>#</th>
							<th>empName</th>
							<th>gender</th>
							<th>email</th>
							<th>deptName</th>
							<th>操作</th>
						</tr>
					</thead>
					<tbody>
					
					</tbody>


				</table>
			</div>
		</div>
		<div class="row">
			<div class="col-md-6" id="page_info_area"></div>
			<div class="col-md-6" id="page_nav_area"></div>
		</div>
	</div>
	<script type="text/javascript">
		$(function() {
			to_page(1);
		})
		function to_page(pn){
			$.ajax({
				url : "${APP_PATH}/emps",
				data : "pn="+pn,
				type : "get",
				success : function(result) {
					build_emps_table(result);
					build_page_info(result);
					build_page_nav(result);
				}
			})
		}
		function build_emps_table(result) {
			$("#emps_table tbody").empty();
			var emps = result.extend.pageInfo.list;
			$.each(emps, function(index, item) {
				var empIdTd = $("<td></td>").append(item.empId);
				var empNameTd = $("<td></td>").append(item.empName);
				var gender = item.gender == "M" ? "男" : "女";
				var genderTd = $("<td></td>").append(gender);
				var emailTd = $("<td></td>").append(item.email);
				var departmentTd = $("<td></td>").append(
						item.department.deptName);
				var editBtn = $("<button></button>").addClass("btn btn-primary btn-sm").append($("<span></span>").addClass("glyphicon glyphicon-pencil")).append("编辑");
				var delBtn = $("<button></button>").addClass("btn btn-danger btn-sm").append($("<span></span>").addClass("glyphicon glyphicon-trash")).append("删除");
				var btnTd = $("<td></td>").append(editBtn).append(" ").append(delBtn);
				$("<tr></tr>").append(empIdTd).append(empNameTd).append(
						genderTd).append(emailTd).append(departmentTd)
						.append(btnTd).appendTo("#emps_table tbody");
			})
		}
		function build_page_info(result){
			$("#page_info_area").empty();
			$("#page_info_area").append("当前页数：" + result.extend.pageInfo.pageNum + ",总页数：" + result.extend.pageInfo.pages + ",共" + result.extend.pageInfo.total + "条数据。");
		}
		function build_page_nav(result) {
			$("#page_nav_area").empty();
			var ul = $("<ul></ul>").addClass("pagination");
			var firstPageLi = $("<li></li>").append($("<a></a>").append("首页"));
			var prePageLi = $("<li></li>").append($("<a></a>").append("&laquo;").attr("href","#"));
			firstPageLi.click(function(){
				to_page(1);
			});
			prePageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum - 1);
			});
			if(result.extend.pageInfo.hasPreviousPage == false){
				firstPageLi.addClass("disabled");
				prePageLi.addClass("disabled");
			}
			
			var nextPageLi = $("<li></li>").append($("<a></a>").append("&raquo;").attr("href","#"));
			var lastPageLi = $("<li></li>").append($("<a></a>").append("尾页").attr("href","#"));
			nextPageLi.click(function(){
				to_page(result.extend.pageInfo.pageNum + 1);
			});
			lastPageLi.click(function(){
				to_page(result.extend.pageInfo.pages);
			});
			if(result.extend.pageInfo.hasNextPage == false){
				nextPageLi.addClass("disabled");
				lastPageLi.addClass("disabled");
			}
			ul.append(firstPageLi).append(prePageLi);
			$.each(result.extend.pageInfo.navigatepageNums,function(index,item){
				var numLi = $("<li></li>").append($("<a></a>").append(item));
				if(result.extend.pageInfo.pageNum == item){
					numLi.addClass("active");
				}
				numLi.click(function(){
					to_page(item);
				})
				ul.append(numLi);
			})
			ul.append(nextPageLi).append(lastPageLi);
			var navEle = $("<nav></nav>").append(ul);
			navEle.appendTo("#page_nav_area");
		}
	</script>
</body>
</html>