<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<%@page pageEncoding="UTF-8"%>
<% String contextPath = request.getContextPath(); %>
<html xmlns="http://www.w3.org/1999/xhtml">
<!-- 
  - Author(s): liweijie
  - Date: 2021-12-09 22:19:40
  - Description:
-->
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js"></script>
<style>
	.layui-form-label{
	    width:100px;
	}
	.layui-input-block{
	   	margin-left:100px;
	}
</style>
<body>
	<form  id="dict_type_form" class="layui-form" lay-filter="operaterform" action="">
		<input type="hidden" name="rank" class="layui-input">
		<input type="hidden" name="seqno" class="layui-input">
		<input type="hidden" name="action" class="layui-input">
	  	<br>

		<div class="layui-form-item">
		    <label class="layui-form-label">上级类型代码</label>
		    <div class="layui-input-inline">
		      	<input type="text" name="parentid" style="width:200px;"  autocomplete="off" class="layui-input" readonly="true">
		    </div>
		</div>
	  	<div class="layui-form-item">
		    <label class="layui-form-label">类型代码</label>
		    <div class="layui-input-block">
		      <input type="text" name="dicttypeid"  style="width:200px;" required  lay-verify="required" class="layui-input">
		    </div>
	  	</div>
	  	<div class="layui-form-item">
	   		<label class="layui-form-label">类型名称</label>
	    	<div class="layui-input-block">
	      		<input type="text" name="dicttypename"  style="width:200px;" required  lay-verify="required"  autocomplete="off" class="layui-input">
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
</body>
</html>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script type="text/javascript">
	var layer = layui.layer;
	var form = layui.form;
	var $ = layui.jquery;
	var isExist = false;
	var submit = false;
	
	var win = null;
	function SetData(data) {
		win = data.win ? data.win : window;	 
	}
	
	//提交
	form.on('submit(layuiadmin-dicttype-form-submit)', function(data){	  //根据 lay-filter
		var adddata = data.field;
   		if (submit == false) {
   			submit = true;
	  		$.ajax({
			 	url:"com.zimax.components.coframe.dict.DictManager.saveDictType.biz.ext",
		   		type:'POST',
		 		data:JSON.stringify({
		 			data: adddata
		 		}),
		   		cache: false,
	  			contentType:'text/json',
	  			success: function (json) {
					if (json.status == 'success') {
						layer.msg("保存成功", {
							icon: 1,
							time: 2000
						}, function() {
							parent.cldFlag = true;
							var index = parent.layer.getFrameIndex(window.name);
							win.layui.table.reload('#demo');
							parent.layer.close(index); 
						});
					} else if (json.status == 'exist') {
						layer.msg("记录已存在！");
						submit = false;
					} else{ 
						layer.msg("保存失败！");
						submit = false;
					}
				}
			});	
		} else {
			layer.msg("正在保存.....请稍等");
		}
	    	return false;
	});
		  	
	function closeWindow() {            
		var index = parent.layer.getFrameIndex(win.name);
		parent.layer.close(index); 
	}
</script>