<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 李伟杰
  - Date: 2021-03-30 10:42:05
  - Description:
-->
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=equipment-width, initial-scale=1.0, minimum-scale=1.0, maximum-scale=1.0, user-scalable=0">
<title>修改用户</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
	<style>
		.layui-form-label {
			width: 120px;
		}

		.layui-input-block {
			margin-left: 150px;
			min-height: 30px
		}
		.layui-textarea{
			height: 5px!important;
			/*min-height: 60px!important;*/
		}
	</style>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
	 style="padding: 20px 30px 0 0 ">
	<input type="hidden" name="operatorId" value="default">
	<input type="hidden" name="password" value="default">
		<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label" ><span style="color:red">*</span>用户登录账号名：</label>
			<div class="layui-input-block">
				<input id="userId" type="text" name="userId" lay-verify="required|checkUserId" placeholder="用户登录名(必填)" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label" ><span style="color:red">*</span>用户名称：</label>
			<div class="layui-input-block">
				<input id="userName" type="text" name="userName" lay-verify="required|userName" placeholder="角色名称(必填)" autocomplete="off" class="layui-input">
			</div>
		</div>
	</div>
	
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label">密码失效日期：</label>
			<div class="layui-input-block">
	  			<input type="text" name="invalDate" id="invaldate" autocomplete="off" class="layui-input" lay-verify="required">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label"><span style="color:red">*</span>用户状态：</label>
			<div class="layui-input-block">
				<%--下拉选择框--%>
				<select name="status" id="status" lay-filter="status" lay-verify="required">
				</select>
			</div>
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label"><span style="color:red">*</span>用户类型：</label>
			<div class="layui-input-block">
				<%--下拉选择框--%>
				<select name="userType" id="userType" lay-filter="userType" lay-verify="required">
				</select>
			</div>
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label" >有效开始时间：</label>
			<div class="layui-input-block">
	  			<input type="text" name="startDate" id="startdate" autocomplete="off" class="layui-input" lay-verify="required" >
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label" >有效截止时间：</label>
			<div class="layui-input-block">
	  			<input type="text" name="endDate" id="enddate" autocomplete="off" class="layui-input" lay-verify="required" >
			</div>
		</div>
	</div>
	
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm6">
			<label class="layui-form-label">手机号：</label>
			<div class="layui-input-block">
				<input type="text" name="userPhone" id="userPhone" lay-verify="phone" autocomplete="off" class="layui-input">
			</div>
		</div>
		<div class="layui-col-sm6">
			<label class="layui-form-label" >邮箱地址：</label>
			<div class="layui-input-block">
				<input type="text" name="email" id="email" lay-verify="checkEmail" autocomplete="off" class="layui-input">
			</div>
		</div>
	</div>
	<div class="layui-form-item layui-row layui-col-space10">
		<div class="layui-col-sm12">
			<label class="layui-form-label">用户描述：</label>
			<div class="layui-input-block">
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="userDescription" id="userDescription"
					  autocomplete="off"
					  class="layui-textarea" lay-verify="userDescription" ></textarea>
			</div>
		</div>
	</div>
	<div class="layui-form-item layui-hide">
		<input type="button" lay-submit lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit" value="确认编辑">
	</div>
</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
	layui.config({
		base: "<%=request.getContextPath()%>/"
	});
</script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
	
<script type="text/javascript">
	var layer = layui.layer;
	var form = layui.form;
	var laydate = layui.laydate;
	var $ = layui.jquery;
	var util = layui.util;

	var isExist = false;
	var submit = false;
	
 	layui.admin.renderDictSelect({    //获取用户状态的下拉值
  		elem: "#status",
  		dictTypeId: "COF_USERSTATUS"
    });

	layui.admin.renderDictSelect({    //获取用户状态的下拉值
		elem: "#userType",
		dictTypeId: "USER_TYPE"
	});
	form.render();
	//日期
	laydate.render({
 		elem: '#invaldate',
  		format: 'yyyy-MM-dd',
  		trigger: 'click',   //解决时间选择器一闪而过的情况
  	});
  	
  	 var startDate = laydate.render({
    	elem: '#startdate',
        type: 'date',//设置日期的类型
        trigger: 'click',
        //theme: '#2c78da',
        done: function(value, date) {
             if (value != "") {
                date.month = date.month - 1;
                date.date = date.date + 1;
                endDate.config.min = date;
              } else {
                endDate.config.min = startDate.config.min;
              }
         },
	});

	
    var endDate = laydate.render({
        elem: '#enddate',//绑定的控件名称
        type: 'date',//设置日期的类型
        //theme: '#2c78da',
        trigger: 'click',
        done: function (value, date) {
             if (value != "") {
                 date.month = date.month - 1;
                 date.date = date.date - 1;
                 startDate.config.max = date;
             } else {
                 startDate.config.max = endDate.config.max;
             }
         }
	});

    var operatorId ="";
	var win = null;
	function SetData(data) {
		win = data.win ? data.win : window;
	  	var data = data.data;
	  	 operatorId = data.operatorId
		form.val("layuiadmin-app-form-list", {
			//添加选项几个弄几个，包括一个主键
			"operatorId": data.operatorId,
		 	"userId": data.userId,
			"userName": data.userName,
			"invalDate": util.toDateString(data.invalDate, "yyyy-MM-dd"),
			"startDate": util.toDateString(data.startDate, "yyyy-MM-dd"),
			"endDate": util.toDateString(data.endDate, "yyyy-MM-dd"),
			"userType" : data.userType,
			"userPhone" : data.userPhone,
			"userDescription" : data.userDescription,
			"email": data.email,
			"status": data.status
		});

		if (data.enddate != null) {
			var startDate = laydate.render({
				elem: '#startdate',
		    	type: 'date',//设置日期的类型
		    	max: data.enddate,
		    	trigger: 'click',
		    	done: function(value, date) {
			    	if (value != "") {
						date.month = date.month - 1;
						date.date = date.date + 1;
						endDate.config.min = date;
					} else {
						endDate.config.min = startDate.config.min;
					}
				}
			});
		}
		
		if (data.startdate != null) {
			var endDate = laydate.render({
		    	elem: '#enddate',//绑定的控件名称
		    	type: 'date',//设置日期的类型
		   	 	min: data.startdate,
		    	trigger: 'click',
		    	done: function(value, date) {
			   		if (value != "") {
			        	date.month = date.month - 1;
			         	date.date = date.date - 1;
			         	startDate.config.max = date;
			     	} else {
			         	startDate.config.max = endDate.config.max;
			     	}
		     	}
			});
		}
	}
	//判断字符
	form.verify({
		checkUserId: function (value, item) {

			if (!new RegExp("^[a-zA-Z0-9_]+$").test(value)) {
				return "输入用户登录名称有误，只能输入英文字母、数字、下划线";
			}
			if (value.length > 20) {
				return "输入用户登录名称有误，不能超过20个字符";
			}
			var checkResult = "";
			var flag = "0";
			$.ajax({
				url: "<%=request.getContextPath()%>/user/check/isExist?userId=" + value + "&flag=" + flag+ "&operatorId=" + operatorId,
				type: "GET",
				// data: json,
				// data: userId,
				async: false,
				contentType: "text/json",
				cache: false,
				success: function (text) {

					if (text.code == "1") {
						checkResult = "登录名账号名已存在";
					}
				},
				error: function () {
				}
			});
			return checkResult;
		},
		userName: function (value, item) {

			if (!new RegExp("^[a-zA-Z0-9\u4e00-\u9fa5]+$").test(value)) {
				return "输入用户名称名称有误，只能输入汉字+英文+数字";
			}
			if (value.length > 20) {
				return "用户名称不能超过20个字符";
			}
		},
		checkEmail: function (value, item) {
			if (value != "") {
				if (!new RegExp("^[A-Za-z0-9\u4e00-\u9fa5]+@[a-zA-Z0-9_-]+(\.[a-zA-Z0-9_-]+)+$").test(value)) {
					return "邮箱格式有误";
				}
			}
		},
		userDescription: function (value, item) {
			if (value.length > 255) {
				return "备注不能超过255个字符";
			}
		}
	});

	//判断角色是否已存在
	$("#userId").blur(function() {
		var userId = $("#userId").val();
		if (userId != null && userId != "") {
			$.ajax({
				url: "<%=request.getContextPath()%>/user/check/isExist",
				type: "GET",
				cache: false,
				contentType: "text/json",
				cache: false,
				success: function(text) {
					console.log(text);
					if (text.code == "1") {
						isExist = true;
					} else {
						isExist = false;
					}
				}
			});
		} else {
			return;
		}
	});
	
	//监听提交
	form.on("submit(layuiadmin-app-form-edit)", function(data) {
		delete data.field.password;
		var submitData = JSON.stringify(data.field);
		if (submit == false) {
			submit = true;
			if (isExist == false) {
				$.ajax({
					url: "<%=request.getContextPath()%>/user/update",
					type: "POST",
					data: submitData,
					cache: false,
					contentType: "text/json",
					success: function(result) {
						layer.msg("修改成功", {
							icon: 1,
							time: 2000
						}, function() {
							var index = parent.layer.getFrameIndex(window.name);
							win.layui.table.reload('LAY-app-user-list-reload');
							top.layer.close(index); 
	    				});
					}
				});	
			} else if(isExist == true) {
				submit = false;
				layer.msg("用户已存在，请重新输入", {
					icon: 2,
					time: 2000
				});
			}
		} else {
			layer.msg("请稍等");
		}
		return false;                
	});
</script>
</body>
</html>