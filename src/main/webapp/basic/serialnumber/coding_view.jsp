<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): LIUYULIN
  - Date: 2022-11-18 15:11:13
  - Description:
-->
<head>
<title>查看型体资料</title>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.1">
</head>
<body> 
<div class="layui-fluid">
	<div class="layui-form" lay-filter="coding-edit" id="coding-edit" style="padding: 20px 30px 0 0;">
		<input type="text" class="layui-input layui-hide" id="id" name="serial/id">
		<div class="layui-row layui-col-space10 layui-form-item" >
			<div class="layui-col-sm6">
				<label class="layui-form-label" ><span style="color:red">*</span>规则编码：</label>
				<div class="layui-input-block">
					<input type="text"  class="layui-input" name="serial/functionNum" lay-verify="required|chinese|length32" autocomplete="off" placeholder="英文、数字、符号，不能超过32个字符" disabled="disabled">
				</div>
			</div>
			<div class="layui-col-sm6">
				<label class="layui-form-label" ><span style="color:red">*</span>规则名称：</label>
				<div class="layui-input-block">
					<input type="text"  class="layui-input" name="serial/functionName" id="functionName" lay-verify="required|length32" autocomplete="off" placeholder="中英文、数字、符号，不能超过32个字符" disabled="disabled">
				</div>
			</div>		
		</div>
		<div class="layui-row layui-col-space10 layui-form-item">
				<label class="layui-form-label" ><span style="color:red">*</span>生成规则：</label>
				<div class="layui-input-block">
					<input type="text"  class="layui-input" name="serial/titlerule" id="titlerule"  lay-filtter ="titlerule" lay-verify="required|chinese|length32" autocomplete="off" placeholder="英文、数字、符号，不能超过32个字符" disabled="disabled">
				</div>
		</div>
		<div class="layui-row layui-col-space10 layui-form-item">
			<label class="layui-form-label" ><span style="color:red">*</span>流水号规则：</label>
			<div class="layui-input-block">
					<input type="text"  class="layui-input" name="serial/numberrule" id="numberrule"  lay-filtter ="required|chinese|length32" autocomplete="off" placeholder="英文、数字、符号，不能超过32个字符" disabled="disabled">
			</div>
		</div>
		<div class="layui-row layui-col-space10 layui-form-item">		
			<div class="layui-col-sm6">
				<label class="layui-form-label" ><span style="color:red">*</span>流水号长度：</label>
				<div class="layui-input-block">
					<input type="text"  class="layui-input" name="serial/digit" id="digit" lay-verify="required|number|length9" autocomplete="off" placeholder="数字，不超过9个字符" disabled="disabled">
				</div>
			</div>
			<div class="layui-col-sm6">
				<label class="layui-form-label" ><span style="color:red">*</span>初始值：</label>
				<div class="layui-input-block">
					<input type="text"  class="layui-input" name="serial/startvalue" id="startvalue" lay-verify="required|number|length9" autocomplete="off" placeholder="数字，不超过9个字符" disabled="disabled">
				</div>
			</div>
		</div>
		<div class="layui-row layui-col-space10 layui-form-item">		
			<div class="layui-col-sm6">
				<label class="layui-form-label" ><span style="color:red">*</span>计数方式：</label>
				<div class="layui-input-block">
					<select name="serial/numbasis" id="numbasis" lay-verify="required" placeholder="请选择" disabled="disabled">
					</select>			
				</div>
			</div>
		</div>
		<div class="layui-row layui-col-space10 layui-form-item" style="mamargin-bottom:  0;">
			<label class="layui-form-label" >说明：</label>
			<div class="layui-input-block">
				<textarea class="layui-textarea" lay-verify="length255" placeholder="说明,不超过255个字符" name="serial/note" id="note" disabled="disabled"></textarea>
			</div>
		</div>
		<div class="layui-form-item layui-hide">
          	<button class="layui-btn layui-btn-normal layui-hide" id='save_data' lay-submit lay-filter="save_data"></button>
	    </div>
	 </div>	
</div>
<script src="<%=request.getContextPath()%>/common/layui/layui.all.js"></script>
<script>
	layui.config({
		base: "<%=request.getContextPath()%>/"
	});
</script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script src="<%=request.getContextPath()%>/general/js/coding.js"></script>
<script type="text/javascript">
	var layer = layui.layer;
	var table = layui.table;
	var form = layui.form;
	var $ = layui.jquery;
	var modePhoto = null;
	var count = 0;
	
	layui.admin.renderDictSelect({    	
		 elem: "#numbasis",
	  	 dictTypeId: "numbasis"
	});
	form.render();

	var win=null;
	function SetData(obj) {
		win = obj.win ? obj.win : window;
		var data = obj.data;
		var serial = obj.data;
		form.val('coding-edit',{
		    "serial/id":serial.id,
			"serial/functionNum":serial.functionNum,
			"serial/functionName":serial.functionName,
			"serial/titlerule":serial.titleRule,
			"serial/numberrule":serial.numberRule,
			"serial/digit":serial.digit,
			"serial/startvalue":serial.startvalue,
			"serial/numbasis":serial.numBasis,
			"serial/note":serial.note,
		});
	}
	
	// 按钮单击的事件监听
	$(".layui-btn.layuiadmin-btn-list").on("click", function() {
		var event = $(this).data("type");
	 	active[event] ? active[event].call(this) : "";
	});
	
	
	form.on("submit(confirm)", function() {
		var index = top.layer.getFrameIndex(window.name);
		top.layer.close(index);
	});
	
	function getFullSize() {
		var header = $(".layui-card-header");
		var toolbar = $(".layui-toolbar");
		var cardbody = $(".layui-card-body");
		return header.outerHeight(true) + toolbar.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height());		
	}
		
	$(window).resize(function () {
		table.reload("tableReload", {
			height: "full-" + getFullSize()
		});
	});
	
	//禁用按钮3秒
    function disabledSubmitButton(submitButtonName){
        $("#"+submitButtonName).attr({"disabled":"disabled"});     //控制按钮为禁用
        var timeoutObj = null;
        timeoutObj = setTimeout(function () {
        	$("#"+submitButtonName).removeAttr("disabled");//将按钮可用
             /* 清除已设置的setTimeout对象 */
        	clearTimeout(timeoutObj);
        }, 3000);
	}
	
</script>
</body>
</html>