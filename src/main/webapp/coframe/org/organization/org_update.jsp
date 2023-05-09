<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<meta http-equiv="content-type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css" media="all">
<link rel="stylesheet" href="<%=request.getContextPath()%>/common/layui/css/layui.css">
<title>编辑机构</title>
</head>
<body>
	<div style="padding: 0 10px;margin-top: 10px" class="mcolor"></div>	
	<div class="layui-fluid">
		<div class="layui-card">			    
			<form class="layui-form" method="post" lay-filter="editform">
				<div class="page-form">
					<input type="hidden" name="orgId" id="orgId"/>
					<input type="hidden" name="organization/orgId" id="organization/orgId"/>
					<input type="hidden" name="organization/orgLevel" id="organization/orgLevel"/>
					<input type="hidden" name="organization/orgSeq" id="organization/orgSeq"/>
					
					<div class="layui-row layui-col-space10 layui-form-item">
						<div class="layui-col-sm6">
							<label class="layui-form-label">机构名称：<span style="color:red">*</span></label>
							<div class="layui-input-block">
								<input type="text" class="layui-input" name="orgName" id="orgName"  lay-verify="required" autocomplete="off" placeholder="">
							</div>
						</div>
						<div class="layui-col-sm6">
							<label class="layui-form-label">机构代码：<span style="color:red">*</span></label>
							<div class="layui-input-block">
								<input type="text" class="layui-input" name="orgCode" id="orgCode" lay-verify="required" autocomplete="off"   onvalidation="onCheck" placeholder="">
							</div>
						</div>
					</div>
					
					<div class="layui-row layui-col-space10 layui-form-item">
						<div class="layui-col-sm6">
							<label class="layui-form-label">上级机构：</label>
					        <div class="layui-input-block">
								<input type="text" name="parentName" id="parentName" lay-verify="" autocomplete="off" class="layui-input" disabled="">
								<input type="hidden" name="parentOrgId" id="parentOrgId" lay-verify="" autocomplete="off" class="layui-input" disabled="">
							</div>
						</div>
						<div class="layui-col-sm6">
							<label class="layui-form-label">机构类型：<span style="color:red">*</span></label>
						    <div class="layui-input-block">
								<select name="orgType" id="orgType" lay-verify="required"></select>
							</div>
						</div>
					</div> 	
					
					<div class="layui-row layui-col-space10 layui-form-item">
						<div class="layui-col-sm6">
							<label class="layui-form-label">机构等级：<span style="color:red">*</span></label>
							<div class="layui-input-block">
						    	<select name="orgDegree" id="orgDegree" lay-verify="required"></select>
							</div>
						</div>
						<div class="layui-col-sm6">
						    <label class="layui-form-label">机构状态：<span style="color:red">*</span></label>
						    <div class="layui-input-block">
								<select name="status" id="status" lay-verify="required"></select>
							</div>
						</div>
					</div>
						
					<div class="layui-row layui-col-space10 layui-form-item">
						<div class="layui-col-sm6">
					      	<label class="layui-form-label">排列顺序：</label>
					        <div class="layui-input-block">
			  					<input type="text" name="sortNo" id="sortNo" autocomplete="off" class="layui-input" lay-verify="">
			  				</div>
			  			</div>
			  			<div class="layui-col-sm6">
							<label class="layui-form-label">所属地域：</label>
					        <div class="layui-input-block">
			  					<input type="text" name="area" id="area" autocomplete="off" class="layui-input">
			  				</div>
			  			</div>
					</div>
					
					<div class="layui-row layui-col-space10 layui-form-item">
						<div class="layui-col-sm6">
					      	<label class="layui-form-label">机构地址：</label>
					        <div class="layui-input-block">
			  					<input type="text" name="orgAddr" id="orgAddr" autocomplete="off" class="layui-input">
			  				</div>
			  			</div>
			  			<div class="layui-col-sm6">
							<label class="layui-form-label">邮编：</label>
					        <div class="layui-input-block">
			  					<input type="text" name="zipCode" id="zipCode" autocomplete="off" class="layui-input">
			  				</div>
			  			</div>
					</div>		
							
					<div class="layui-row layui-col-space10 layui-form-item">
						<div class="layui-col-sm6">
							<label class="layui-form-label">联系人：</label>
							<div class="layui-input-block">
			       				<input type="text" name="linkMan" id="linkMan" lay-verify="" autocomplete="off" class="layui-input">
			     			</div>
			     		</div>
			     		<div class="layui-col-sm6">
					      	<label class="layui-form-label">联系电话：</label>
							<div class="layui-input-block">
			       				<input type="text" name="linkTel" id="linkTel" lay-verify="" autocomplete="off" class="layui-input">
			     			</div>
			     		</div>
					</div>
					
					<div class="layui-row layui-col-space10 layui-form-item">
						<div class="layui-col-sm6">
							<label class="layui-form-label">电子邮件：</label>
							<div class="layui-input-block">
			       				<input type="text" name="email" id="email" lay-verify="" autocomplete="off" class="layui-input">
			     			</div>
			     		</div>
			     		<div class="layui-col-sm6">
					      	<label class="layui-form-label">网站地址：</label>
							<div class="layui-input-block">
			       				<input type="text" name="webUrl" id="webUrl" lay-verify="" autocomplete="off" class="layui-input">
			     			</div>
			     		</div>
					</div>
					
					<div class="layui-row layui-col-space10 layui-form-item">
						<div class="layui-col-sm6">
					      	<label class="layui-form-label">生效日期：</label>
					        <div class="layui-input-block">
			  					<input type="text" name="startDate" id="startDate" autocomplete="off" class="layui-input" lay-verify="">
			  				</div>
			  			</div>
			  			<div class="layui-col-sm6">
							<label class="layui-form-label">失效日期：</label>
					        <div class="layui-input-block">
			  					<input type="text" name="endDate" id="endDate" autocomplete="off" class="layui-input" lay-verify="">
			  				</div>
			  			</div>
					</div>
								
					<div class="layui-row layui-col-space10 layui-form-item">
			        	<label class="layui-form-label">备注：</label>
			        	<div class="layui-input-block">
			        		<textarea name="remark" id="remark" placeholder="请输入内容" class="layui-textarea"></textarea>
			        	</div>
	        		</div>	
					
					<div class="layui-form-item layui-hide">
						<button type="button" lay-submit id="save_data" lay-filter="save_data"></button>
					</div>
				</div>
			</form>
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
  	  //无需再执行layui.use()方法加载模块，直接使用即可
	var layer = layui.layer ,//弹层
	table = layui.table, //表格
	form = layui.form, //表单
	laydate = layui.laydate, //日期
	$ = layui.jquery; //jquery
	var submit = false;
	form.render();
	  
	layui.admin.renderDictSelect({    	//机构类型
		elem: "#orgType",
	  	dictTypeId: "COF_ORGTYPE"
	});
	layui.admin.renderDictSelect({	 	//机构等级
	  	elem: "#orgDegree", 
	  	dictTypeId: "COF_ORGDEGREE"
	});
	layui.admin.renderDictSelect({	   	//机构状态
  		elem: "#status",
	  	dictTypeId: "COF_ORGSTATUS"
	});
	  	  
	//日期
	laydate.render({
		elem: "#openDate",
		type: "date",
		trigger: "click",
		theme: "#2c78da"
	});

	var win=null;  
	function SetData(data,iframe) {
		win = iframe ? iframe : window;
		var parent_json = $.parseJSON(data); 
		var parentId = "";
	 	var parentSeq = "";
		var parentLevel = "";
		var parentName = "";
		if (parent_json.organization == null) {
			parentId = null;
		  	parentSeq = null;
		  	parentLevel = null;
		  	parentName = null;
		} else {
			parentId = parent_json.organization.orgId;
		  	parentName = parent_json.organization.orgName;
		  	parentSeq = parent_json.organization.orgSeq;
		  	parentLevel = parent_json.organization.orgLevel;
		}
		//表格默认值赋值
		form.val('editform', {
			"organization/orgId": parentId,
			"organization/orgSeq": parentSeq,
			"organization/orgLevel": parentLevel,
		  	"orgId": parent_json.orgId,
		  	"orgName": parent_json.orgName,
			"orgCode": parent_json.orgCode,
			"parentOrgId": parentId,
			"parentName": parentName,
			"orgType": parent_json.orgType,
			"orgDegree": parent_json.orgDegree,
			"status": parent_json.status,
			"sortNo": parent_json.sortNo,
			"area": parent_json.area,
			"orgAddr": parent_json.orgAddr,
			"zipCode": parent_json.zipCode,
			"linkMan": parent_json.linkMan,
			"linkTel": parent_json.linkTel,
			"email": parent_json.email,
			"webUrl": parent_json.webUrl,
			"startDate": parent_json.startDate,
			"endDate": parent_json.endDate,		
			"remark": parent_json.remark
		});
		if (parent_json.enddate != null) {
			var startDate = laydate.render({
				elem: '#startDate',
		        type: 'date',//设置日期的类型
		        max: parent_json.enddate,
		        trigger: 'click',
		        done: function(value, date) {
					if (value != "") {
						date.month = date.month - 1;           
		                endDate.config.min = date;
					} else {
	                	endDate.config.min = startDate.config.min;
					}
				}
			});
		} else {
			var startDate = laydate.render({
	    	elem: '#startDate',
		    type: 'date',//设置日期的类型
		    trigger:'click',
		    done: function (value, date) {
	      	if (value != "") {
		        date.month = date.month - 1;           
		        endDate.config.min = date;
	        } else {
	          endDate.config.min = startDate.config.min;
	        }
	     	}
			});
		}
		if (parent_json.enddate != null) {
			var endDate = laydate.render({
			    elem: '#endDate',//绑定的控件名称
			    type: 'date',//设置日期的类型
			   	min: parent_json.enddate,
			    trigger: 'click',
			    done: function(value, date) {
					if (value != "") {
						date.month = date.month - 1;             
						startDate.config.max = date;
					} else {
						startDate.config.max = endDate.config.max;
					}
			    }
			});
		} else {
			var endDate = laydate.render({
			    elem: '#endDate',//绑定的控件名称
			    type: 'date',//设置日期的类型
			    trigger: 'click',
			    done: function(value, date) {
				    if (value != "") {
				        date.month = date.month - 1;             
				        startDate.config.max = date;
					} else {
				        startDate.config.max = endDate.config.max;
					}
			    }
			});
		}
	}
	
 	//提交
	form.on('submit(save_data)', function(data) {	  //根据 lay-filter
		if (submit == false) {
			submit = true;
			var submitData=JSON.stringify({
				organization: data.field
			});  //获取name的value
			$.ajax({
				url: "com.zimax.components.coframe.org.Organization.updateOrg.biz.ext",
				type: 'POST',
				data: submitData,
				cache: false,
				contentType: 'text/json',
				success: function(result) {
					if (result.response.flag) {
						layer.msg('修改成功', {icon: 1,time: 2000}, function() {
							var index = top.layer.getFrameIndex(window.name);
							win.layui.table.reload("org-list");
							top.layer.close(index); 
							win.window.updateOrgSelect();
						});
			        } else {
			        	submit = false;
			        	layer.msg(result.response.message, {
							icon: 2,
							time: 2000
						});
			        }
				}
			});		
		} else {
			layer.msg("请稍等");
		}	
		return false; 
	});	  
	  		
	//取消按钮
	function formCancel() {
		var index = top.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
		top.layer.close(index); //再执行关闭    		
	}
</script>
</body>
</html>