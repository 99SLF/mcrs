<%@page language="java" contentType="text/html; charset=UTF-8"
		pageEncoding="UTF-8" session="false" %>
<!--
- Author: 李伟杰
- Date: 2022-12-01 22:19:40
- Description:添加字典类型弹窗
-->
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css">
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js"></script>
<style>
   	.layui-form-select {
   		width: 200px;
   	}	
</style>
<body>
	<form  id="dict_form" class="layui-form" lay-filter="operaterform" action="">
		<input type="hidden" name="status" class="layui-input" />
		<input type="hidden" name="rank" class="layui-input" />
		<input type="hidden" name="seqNo" class="layui-input" />
		<input type="hidden" name="action" class="layui-input" />
	  	<br>
		<div class="layui-form-item">
		    <label class="layui-form-label">上级字典项</label>
		    <div class="layui-input-inline">
		      	<input type="text" name="parentId" style="width:200px;"  autocomplete="off" class="layui-input" readonly="true">
		    </div>
		</div>
	  	<div class="layui-form-item">
		    <label class="layui-form-label">类型名称</label>
		    <div class="layui-input-block">
		    	<select name="dictTypeId" id="dictTypeId" lay-verify="required" style="width:200px;" lay-filter="">
           	 		<!-- <option value="">请选择类型代码</option> -->
              	</select>
		    </div>
	  	</div>	
	  	<div class="layui-form-item">
	   		<label class="layui-form-label">字典项代码</label>
	    	<div class="layui-input-block">
	      		<input type="text" name="dictId" id="dictId" style="width:200px;" required  lay-verify="required"  autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	   		<label class="layui-form-label">字典项名称</label>
	    	<div class="layui-input-block">
	      		<input type="text" name="dictName"  style="width:200px;" required  lay-verify="required"  autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
	  	<div class="layui-form-item">
	   		<label class="layui-form-label">排序</label>
	    	<div class="layui-input-block">
	      		<input type="text" name="sortNo"  style="width:200px;" required  lay-verify="required"  autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
	  	<!-- <div class="layui-form-item">
	    	<div class="layui-input-block">
	      		<button class="layui-btn" lay-submit lay-filter="formDemo">保存</button>
	      		<a class="layui-btn" href="javascript:void(0);" onclick="closeWindow();">关闭</a>
	    	</div>
	  	</div> -->
	  	<div class="layui-form-item layui-hide">
			<input type="button" lay-submit lay-filter="layuiadmin-dict-form-submit" id="layuiadmin-dict-form-submit" value="确认添加">
		</div>
	</form>
</body>
</html>
<script type="text/javascript">
	var win = null;
	var parentData;
	var $ = layui.jquery;
	var form = layui.form;
	form.render();
	var submit = false;
	
	function SetData(data) {
		win = data.win ? data.win : window;
		var dictType =data.dictType;
		//判断有没有data值
		if (dictType) {
			form.val("layuiadmin-app-form-list", {
				parentId: dictType.parentId,
				dictTypeId: dictType.dictTypeId,
				dictTypeName: dictType.dictTypeName
			}); 
		}
		
		parentData = win.dictChildData; 
		
		if (parentData.type == "add") {
			form.val("operaterform", { //formTest 即 class="layui-form" 所在元素属性 lay-filter="" 对应的值
				action: parentData.action,
			});	
			$('#dictTypeId').append(new Option(parentData.dictParentName,parentData.dictParentId));
			form.render("select");
		}
	
		if (parentData.action == "edit") {
			form.val("operaterform", { //formTest 即 class="layui-form" 所在元素属性 lay-filter="" 对应的值
				action: parentData.action,
				dictName: parentData[0].dictName,
				parentId: parentData.dictParentId,
				rank: parentData[0].rank,
				dictId: parentData[0].dictId,
				sortNo: parentData[0].sortNo,
				seqNo: parentData[0].seqNo
			});	
			$("#dictTypeId").append(new Option(parentData.dictParentName,parentData.dictParentId));
			$("#dictId").attr("readonly",true);
			form.render("select");
		}
	
		if (parentData.type == "adddict") {
			form.val("operaterform", { //formTest 即 class="layui-form" 所在元素属性 lay-filter="" 对应的值
				action: parentData.action,
				parentId: parentData[0].dictId,
				rank: parentData[0].rank,
				seqNo: parentData[0].seqNo
			});	
			$("#dictTypeId").append(new Option(parentData.dictParentName,parentData.dictParentId));
			form.render("select");
		} else if (parentData.dictParentId != null) {
			$.ajax({
				url: "<%=request.getContextPath() %>/dict/queryDictType?dictTypeId="+parentData.dictParentId,
				type: 'GET',
				cache: false,
				contentType:'text/json',
				success: function (json) {
					for (var i = 0; i < json.data.length; i++) {
						$('#dictTypeId').append(new Option(json.data[i].dictTypeName,json.data[i].dictTypeId));// 下拉菜单里添加元素
					}
					form.render("select");
				}
			});		
		}
	}
	
	//监听提交
	form.on('submit(layuiadmin-dict-form-submit)', function(data) {
		var adddata = data.field;
		var url="";
		if (parentData.type == "add"||parentData.type == "adddict") {
			url = "<%=request.getContextPath() %>/dict/saveDict"
		}
		else if(parentData.action == "edit"){
			url = "<%=request.getContextPath() %>/dict/updateDict"
		}
		if (submit == false) {
			submit = true;
			$.ajax({
				url: url,
				type: 'POST',
				data: JSON.stringify(adddata),
				cache: false,
				contentType: 'text/json',
				success: function (json) {
					if (json.code == '0') {
						layer.msg("保存成功", {
							icon: 1,
							time: 2000
						}, function() {
							parent.cldFlag = true;
							var index = parent.layer.getFrameIndex(window.name);
							win.layui.treeTable.reload("LAY-app-dict-list");
							parent.layer.close(index);
						});	
					} else if (json.code == '1') {
						layer.msg("记录已存在！");
						submit = false;
					} else {
						layer.msg("保存失败！");	
						submit = false;
					} 
				},
			});	
		} else {
			layer.msg("正在保存....请稍等！");
		} 
			return false;
	});
	
	function closeWindow() {            
		var index = parent.layer.getFrameIndex(window.name);
		parent.layer.close(index);
	}
</script>