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
	.layui-form-label{
	    width:100px;
	}
	.layui-input-block{
	   	margin-left:100px;
	}
</style>
</head>
<body>
	<form  id="dict_type_form" class="layui-form" lay-filter="operaterform" action="">
		<input type="hidden" name="rank" class="layui-input">
		<input type="hidden" name="seqNo" class="layui-input">
		<input type="hidden" name="action" class="layui-input">
	  	<br>

		<div class="layui-form-item">
		    <label class="layui-form-label">上级类型代码</label>
		    <div class="layui-input-inline">
		      	<input type="text" name="parentId" style="width:200px;"  autocomplete="off" class="layui-input layui-disabled" readonly="true">
		    </div>
		</div>
	  	<div class="layui-form-item">
		    <label class="layui-form-label">类型代码</label>
		    <div class="layui-input-block">
		      <input type="text" name="dictTypeId" id="dictTypeId" style="width:200px;" required  autocomplete="off"  lay-verify="required" class="layui-input">
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	   		<label class="layui-form-label">类型名称</label>
	    	<div class="layui-input-block">
	      		<input type="text" name="dictTypeName"  style="width:200px;" required autocomplete="off"  lay-verify="required"  autocomplete="off" class="layui-input">
	    	</div>
	  	</div>
	  	<!-- <div class="layui-form-item">
	    	<div class="layui-input-block">
	      		<button class="layui-btn" lay-submit lay-filter="formDemo">保存</button>
	      		<a class="layui-btn" href="javascript:void(0);" onclick="closeWindow();">关闭</a>
	    	</div>
	  	</div> -->
	  	<div class="layui-form-item layui-hide">
			<input type="button" lay-submit lay-filter="layuiadmin-dicttype-form-submit" id="layuiadmin-dicttype-form-submit" value="确认添加">
		</div>
	</form>
<script type="text/javascript">
	var $ = layui.jquery;
	var form = layui.form;
	var win = null;
	var parentData;
	var submit = false;
	
	function SetData(data) {
		win = data.win ? data.win : window;
		var dictType =data.dictType;
		if (dictType) {
			form.val("layuiadmin-app-form-list", {
				parentId: dictType.parentId,
				dictTypeId: dictType.dictTypeId,
				dictTypeName: dictType.dictTypeName
			}); 
		}
		
		var parentData = win.childData;
		if (parentData.action == "add") {
			if (parentData.length > 0) {
				form.val("operaterform", {
					rank: parentData[0].rank,
					seqNo: parentData[0].seqNo,
					action: parentData.action,
					parentId: parentData[0].parentId
				});
			} else {
				form.val("operaterform", {
					action: parentData.action
				});
			}
		} else if (parentData.action == "edit") {
			form.val("operaterform", {
				rank: parentData[0].rank,
				seqNo: parentData[0].seqNo,
				action: parentData.action,
				parentId: parentData[0].parentId,
				dictTypeId: parentData[0].dictTypeId,
				dictTypeName: parentData[0].dictTypeName
			});
			$("#dictTypeId").attr("readonly",true);
			form.render("select");
		};
	}
	
	//监听提交
	form.on("submit(layuiadmin-dicttype-form-submit)", function(data) {
		var adddata = data.field;
		if (submit == false) {
			submit = true;
			$.ajax({
				url: "com.zimax.components.coframe.dict.DictManager.saveDictType.biz.ext",
				type: "POST",
				data: JSON.stringify({
					data: adddata
				}),
				cache: false,
				contentType: "text/json",
				success: function(json) {
					if (json.status == 'success') {
						layer.msg("保存成功", {
							icon: 1,
							time: 2000
						}, function() {
							parent.cldFlag = true;
							var index = parent.layer.getFrameIndex(window.name);
							win.layui.treeTable.reload("LAY-app-dictType-list");
							top.layer.close(index);
						});
					} else if (json.status == 'exist') {
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
</script>
</body>
</html>