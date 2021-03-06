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
	<div class="modal fade" id="empAddModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
	  	<div class="modal-dialog" role="document">
	    	<div class="modal-content">
	      		<div class="modal-header">
	        		<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	        		<h4 class="modal-title" id="myModalLabel">添加员工</h4>
	      		</div>
	      		<div class="modal-body">
	        		<form class="form-horizontal">
  						<div class="form-group">
    						<label for="empName_add_input" class="col-sm-2 control-label">empName</label>
    						<div class="col-sm-10">
      							<input type="text" name="empName" class="form-control" id="empName_add_input" placeholder="empName">
      							<span class="help-block"></span> 
    						</div>
  						</div>
  						<div class="form-group">
    						<label for="email_add_input" class="col-sm-2 control-label">email</label>
    						<div class="col-sm-10">
      							<input type="text" name="email" class="form-control" id="email_add_input" placeholder="Email@163.com">
      							<span class="help-block"></span> 
    						</div>
  						</div>
  						<div class="form-group">
    						<label for="email_add_input" class="col-sm-2 control-label">gender</label>
    						<div class="col-sm-10">
      							<label class="radio-inline">
  									<input type="radio" name="gender" id="gender1_add_input" value="M"> 男
								</label>
								<label class="radio-inline">
									<input type="radio" name="gender" id="gender2_add_input" value="F"> 女
								</label>
    						</div>
  						</div>
  						<div class="form-group">
    						<label for="email_add_input" class="col-sm-2 control-label">deptName</label>
    						<div class="col-sm-4">
      							<select class="form-control" name="dId" id="dept_add_select"></select>
    						</div>
  						</div>
					</form>
	      		</div>
	      		<div class="modal-footer">
	        		<button type="button" class="btn btn-default" data-dismiss="modal">关闭</button>
	        		<button type="button" class="btn btn-primary" id="emp_save_btn">保存</button>
	      		</div>
	    	</div>
	  	</div>
	</div>
	<div class="container">
		<div class="row">
			<div class="col-md-12">
				<h1>SSM-CRUD</h1>
			</div>
		</div>
		<div class="row">
			<div class="col-md-4 col-md-offset-8">
				<button class="btn btn-primary" id="emp_add_modal_btn">新增</button>
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
		var totalRecord;
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
			totalRecord = result.extend.pageInfo.total;
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
		function reset_form(ele){
			$(ele)[0].reset();
			$(ele).find("*").removeClass("has-error has-success");
			$(ele).find(".help-block").text("");
		}
		$("#emp_add_modal_btn").click(function(){
			reset_form("#empAddModal form");
			$("#empAddModal form")[0].reset();
			getDepts();
			$('#empAddModal').modal({
					backdrop:"static"
			});
		});
		function getDepts(){
			$.ajax({
				url:"${APP_PATH}/depts",
				type:"GET",
				success:function(result){
					$.each(result.extend.depts,function(){
						var optionEle = $("<option></option>").append(this.deptName).attr("value",this.deptId);
						optionEle.appendTo("#dept_add_select");
					});
				}
			});
		}
		function validate_add_from(){
			var empName = $("#empName_add_input").val();
			var regName = /(^[a-zA-Z0-9_-]{6,16}$)|(^[\u2E80-\u9FFF]{2,5})/;
			if(!regName.test(empName)){
				show_validate_msg("#empName_add_input","error","用户名只能是2-5位中文或6-16位英文！");
				return false;
			}else{
				show_validate_msg("#empName_add_input","success","");
			}
			var email = $("#email_add_input").val();
			var regEmail = /^([a-z0-9_\.-]+)@([\da-z\.-]+)\.([a-z\.]{2,6})$/;
			if(!regEmail.test(email)){
				show_validate_msg("#email_add_input","error","邮箱格式不正确！");
				return false;
			}else{
				show_validate_msg("#email_add_input","success","");
			}
			return true;
		}
		function show_validate_msg(ele,status,msg){
			$(ele).parent().removeClass("has-success has-error");
			$(ele).next("span").text("");
			if("success" == status){
				$(ele).parent().addClass("has-success");
				$(ele).next("span").text(msg);
			}else if("error" == status){
				$(ele).parent().addClass("has-error");
				$(ele).next("span").text(msg);
			}
		}
		$("#empName_add_input").change(function(){
			var empName = this.value;
			$.ajax({
				url:"${APP_PATH}/checkuser",
				data:"empName=" + empName,
				type:"POST",
				success:function(result){
					if(result.code == 100){
						show_validate_msg("#empName_add_input","success","用户名可用");
						$("#emp_save_btn").attr("ajax-va","success");
					}else{
						show_validate_msg("#empName_add_input","error",result.extend.va_msg);
						$("#emp_save_btn").attr("ajax-va","error");
					}
				}
			})
		});
		$("#emp_save_btn").click(function(){
			if(!validate_add_from()){
				return false;
			}
			if($(this).attr("ajax-va")=="error"){
				return false;
			}
			$.ajax({
				url:"${APP_PATH}/emp",
				type:"POST",
				data:$("#empAddModal form").serialize(),
				success:function(result){
					$("#empAddModal").modal('hide');
					to_page(totalRecord);
				}
			});
		});
	</script>
</body>
</html>