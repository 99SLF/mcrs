<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<%--<%@page import="com.mes.system.utility.StringUtil"%>--%>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 李伟杰
  - Date: 2022-12-03 15:53:38
  - Description:
-->
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
<title>Title</title>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js"></script>
</head>
<body>
    <div title="业务字典导入"  border="0" align="center">
    	<form id="import_dict_form" action="com.zimax.components.coframe.dict.impl.importDict.flow?_eosFlowAction=importDict" method="post" enctype="multipart/form-data">
        <table border="0" style="width:500px;height:100px;" align="center"  class="layui-table">
			<tr>
				<td width="50%" align="right">请选择您要导入的Excel文件:</td>
				<td><span id="uploadSpan"><input type="file" id="dict_file" name="dict_file" size="60"></span></td>
			</tr>
			<tr>
				<td colspan="2" align="center">注：导入时将根据主键匹配覆盖已存在的数据。</td>
			</tr>
			<tr align="center">
				<td colspan="2">
					<a class="layui-btn layui-btn-sm" href="javascript:void(0);" onclick="startUpload()">导入</a>
					<a class="layui-btn layui-btn-sm" href="javascript:void(0);" onclick="resetImport()">重置</a>
					<a class="layui-btn layui-btn-sm" href="javascript:void(0);" onclick="cancelImport()">取消</a>	
				</td>
			</tr>
        </table>
        </form>
    </div>
<script>
	var $ = layui.jquery;
	var win = null;
	function SetData(data) {
		win = data.win ? data.win : window;	 
	}
	
	/*var retcode = '<%= StringUtil.htmlFilter(request.getAttribute("retCode")==null?"":request.getAttribute("retCode").toString()) %>';*/
	if (retcode != "") {
  		if (retcode == -1) {
  			parent.retCode=-1;
    	} else {
			parent.retCode=1;
			cancelImport();
    	}
	}
	
	function startUpload(){
	 	var form = $("#import_dict_form");
		var file = $("#dict_file").val();
		var reg = /.xls$/;
		console.log(file);
		if (file == "") {
			layer.msg("请选择文件！");
			return;
		}
		if (!reg.test(file)) {
			layer.msg('请选择Excel格式(*.xls)文件！');
			return;	
		}
		form.submit();
	 }
	 
	function resetImport(){
	 	var html = document.getElementById('uploadSpan').innerHTML; 
	 	console.log("1" + html);
		document.getElementById('uploadSpan').innerHTML = html; 
		console.log("2" + html);
	}
	 
	function cancelImport(){
	 	var index = parent.layer.getFrameIndex(window.name);
		parent.layer.close(index);
	}
</script>
</body>
</html>