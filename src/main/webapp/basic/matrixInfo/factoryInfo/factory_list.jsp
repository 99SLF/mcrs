<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.zimax.cap.party.IUserObject" %>
<%@ page import="com.zimax.cap.datacontext.DataContextManager" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
		 pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 王广玉
  - Date: 2022-12-21 22:10:17
  - Description:
-->
<head>
	<meta charset="utf-8">
	<meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
	<title>基础基地数据</title>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
	<style>
		.layui-form-label {
			width: 120px;
		}

		.layui-input-block {
			margin-left: 150px;
			min-height: 36px
		}
	</style>
</head>
<body>
<div class="layui-fluid">
	<div class="layui-card-body">
		<div class="layui-row layui-col-space10">
			<div class="layui-col-md12">
				<div class="layui-form" lay-filter="factory-add" id="factory-add" style="padding:20px;">
					<input type="hidden" name="processingMaterials" value="0"/>
					<input type="hidden" name="supplierId" id="supplierId"/>
					<div class="layui-row layui-col-space10 layui-form-item">
						<div class="layui-col-sm4">
							<label class="layui-form-label" ><h1>工厂详情</h1></label>
						</div>
						<div class="layui-col-sm4">

						</div>
						<div class="layui-col-sm2">

						</div>
						<div class="layui-col-sm2">
							<button class="layui-btn " id='save_data' lay-submit lay-filter="save_data">保存</button>
							<button class="layui-btn " id='canle' lay-submit lay-filter="canle">取消</button>
						</div>
					</div>

					<div class="layui-row layui-col-space10 layui-form-item">
						<div class="layui-col-sm6">
							<label class="layui-form-label" >工厂名称：</label>
							<div class="layui-input-block">
								<input type="text" class="layui-input layui-hide" name="infoId" id="infoId"   autocomplete="off" >
								<input type="text" class="layui-input layui-hide" name="factoryId" id="factoryId"   autocomplete="off" >
								<input type="text" class="layui-input" name="factoryName" id="factoryName"   autocomplete="off" >
							</div>
						</div>

						<div class="layui-col-sm6">
							<label class="layui-form-label" >工厂代码：</label>
							<div class="layui-input-block">
								<input type="text" class="layui-input" name="factoryCode" id="factoryCode"  lay-verify="length11|float5" autocomplete="off" placeholder="点击保存，自动生成" readonly>
							</div>
						</div>
					</div>

					<div class="layui-row layui-col-space10 layui-form-item">
						<label class="layui-form-label" >工厂地址：</label>
						<div class="layui-input-block">
							<textarea class="layui-textarea" placeholder="" lay-verify="length255" name="factoryAddress" id="factoryAddress"></textarea>
						</div>
					</div>

					<div class="layui-form-item layui-row layui-hide">
						<div class="layui-input-block">
							<input type="text" class="layui-hide" name="createTime"
								   value="<%=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())%>" readonly/>
						</div>
					</div>

					<div class="layui-form-item layui-row layui-hide">
						<div class="layui-input-block">
							<%--java代码--%>
							<%
								IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
							%>
							<input type="text" class="layui-hide" name="creator" value="<%=usetObject.getUserName()%>"
								   readonly/>
						</div>
					</div>




				</div>
			</div>
		</div>
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
	var laydate = layui.laydate;
	var form = layui.form;
	var $ = layui.jquery;
	var submit = false;
	var isExist = false;
	var win = null;

	//获取树页面传输的树id
	var infoId = <%=request.getParameter("nodeId")%>;
	getfactory(infoId);
	function getfactory(infoId){
		debugger;
		//获取数据
		$.ajax({
			url:"<%=request.getContextPath() %>/FactoryController/query?infoId=" + infoId,
			type:"get",
			cache: false,
			contentType:"text/json",
			success: function(rel) {
				debugger;
				var data = rel.data;
				if (data == null ||data.length < 1) {
					form.val("factory-add", {
						infoId: infoId,
					});
				} else {
					var data = data[0];
					form.val("factory-add", {
						factoryId: data.factoryId,
						infoId: data.infoId,
						factoryName: data.factoryName,
						factoryCode: data.factoryCode,
						factoryAddress: data.factoryAddress
					});
				}
			}
		});
	}


	//监听提交
	form.on("submit(save_data)", function (data) {
		debugger;
		var data = data.field
		if(data.factoryId == null || data.factoryId == "") {
			//新增
			var factory = JSON.stringify(data);
			debugger;
			$.ajax({
				url: "<%=request.getContextPath() %>/FactoryController/add",
				type: "post",
				data: factory,
				cache: false,
				contentType: "text/json",
				success: function(result){
					if (result.code == 0) {
						layer.msg(result.msg, {
							icon: 1,
							time: 2000
						});
					} else {
						layer.msg("新增失败", {icon:2, time:2000});
					}
					getfactory(infoId);
				},
				error: function(){
					layer.msg("新增失败", {
						icon: 2,
						time: 2000
					});
				}
			});
		} else {
			//修改
			var factory = JSON.stringify(data);
			debugger;
			$.ajax({
				url: "<%=request.getContextPath() %>/FactoryController/update",
				type: "post",
				data: factory,
				cache: false,
				contentType: "text/json",
				success: function(result){
					if (result.code == 0) {
						layer.msg(result.msg, {
							icon: 1,
							time: 2000
						});
					} else {
						layer.msg("修改失败", {icon:2, time:2000});
					}
					getfactory(infoId);
				},
				error: function(){
					layer.msg("修改失败", {
						icon: 2,
						time: 2000
					});
				}
			});


		}

	});

	//监听取消
	form.on("submit(canle)", function (data) {
		debugger;
		getfactory(infoId);
	});

</script>
</body>
</html>