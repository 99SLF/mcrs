<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>新增单号规则</title>
<!-- 
  - Author(s): linxiaohuai
  - Date: 2022-02-15 16:42:57
  - Description:
-->
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.1">
</head>
<body>
<div class="layui-fluid">
	<div class="layui-form" lay-filter="coding-add" id="coding-add" style="padding: 20px 30px 0 0;">
		<div class="layui-row layui-col-space10 layui-form-item" >
			<div class="layui-col-sm6">
				<label class="layui-form-label" ><span style="color:red">*</span>规则编码：</label>
				<div class="layui-input-block">
					<input type="text"  class="layui-input" name="functionNum" id="functionNum" lay-verify="required|chinese|length32" autocomplete="off" placeholder="英文、数字、符号，不能超过32个字符">
				</div>
			</div>
			<div class="layui-col-sm6">
				<label class="layui-form-label" ><span style="color:red">*</span>规则名称：</label>
				<div class="layui-input-block">
					<input type="text"  class="layui-input" name="functionName" id="functionName" lay-verify="required|length32" autocomplete="off" placeholder="中英文、数字、符号，不能超过32个字符">
				</div>
			</div>		
		</div>
		<div class="layui-row layui-col-space10 layui-form-item">
				<label class="layui-form-label" ><span style="color:red">*</span>生成规则：</label>
				<div class="layui-input-block">
					<input type="text"  class="layui-input" name="titleRule" id="titleRule"   lay-verify="required|chinese|length32" autocomplete="off" placeholder="英文、数字、符号，不能超过32个字符">
				</div>
		</div>
		<div class="layui-row layui-col-space10 layui-form-item">
			<label class="layui-form-label" ><span style="color:red">*</span>流水号规则：</label>
			<div class="layui-input-block">
					<input type="text"  class="layui-input" name="numberRule" id="numberRule"   lay-verify="required|chinese|length32" autocomplete="off" placeholder="英文、数字、符号，不能超过32个字符">
			</div>
		</div>
		<div class="layui-row layui-col-space10 layui-form-item">		
			<div class="layui-col-sm6">
				<label class="layui-form-label" ><span style="color:red">*</span>流水号长度：</label>
				<div class="layui-input-block">
					<input type="text"  class="layui-input" name="digit" id="digit" lay-verify="required|number|length4" autocomplete="off" placeholder="数字，不超过4个字符">
				</div>
			</div>
			<div class="layui-col-sm6">
				<label class="layui-form-label" ><span style="color:red">*</span>初始值：</label>
				<div class="layui-input-block">
					<input type="text"  class="layui-input" name="startvalue" id="startvalue" lay-verify="required|number|length2" autocomplete="off" placeholder="数字，不超过2个字符">
				</div>
			</div>
		</div>
		<div class="layui-row layui-col-space10 layui-form-item">		
			<div class="layui-col-sm6">
				<label class="layui-form-label" ><span style="color:red">*</span>计数方式：</label>
				<div class="layui-input-block">
					<select name="numBasis" id="numBasis" lay-verify="required" placeholder="请选择">
					</select>			
				</div>
			</div>
		</div>
		<div class="layui-row layui-col-space10 layui-form-item" style="mamargin-bottom:  0;">
			<label class="layui-form-label" >说明：</label>
			<div class="layui-input-block">
				<textarea class="layui-textarea" lay-verify="length255" placeholder="说明,不超过255个字符" name="note" id="note" ></textarea>
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
<script type="text/javascript">
	var layer = layui.layer;
	var table = layui.table;
	var form = layui.form;
	var $ = layui.jquery;
	
	layui.admin.renderDictSelect({    	
		 elem: "#flowingWater",
	  	 dictTypeId: "FLOWING_WATER"
	});
	
	layui.admin.renderDictSelect({    	
		 elem: "#numBasis",
	  	 dictTypeId: "numbasis"
	});
	
	
	// 鼠标悬浮提示文字
	var titlerule_html = "<p>生成规则表达式说明：" + "</p>" +
							 "<p>{Y}：表示年" +  "</p>" +
              				 "<p>{M}：表示月" +  "</p>" +
              				 "<p>{D}：表示日" + "</p>" +
              				 "<p>{H}：表示时" + "</p>" +
              				 "<p>{I}：表示分" + "</p>" +
              				 "<p>{S}：表示秒" + "</p>" +
              				 "<p>{F}：表示流程名" + "</p>" +
              				 "<p>{U}：表示用户姓名" + "</p>" +
              				 "<p>例如：XX公司-{F}流程({Y}年{M}月{D}日{H}:{I})-{U}" + "</p>" +
              				 "<p>会自动生成：XX公司-请假流程(2022年06月17日09:59)-张三" ;
              				 
    var numberrule_html = "<p>流水规则表达式说明：" + "</p>" +
							 "<p>{N}：表示流水号" +  "</p>" +
							 "<p>流水号根据<span style='color:red'>流水号长度</span>会自动拼接在拼接规则后面 " + "</p>" +
              				 "<p>例如：--{N}号" + "</p>" +
              				 "<p>会自动生成：XX公司-请假流程(2022年06月17日09:59)-张三--001号" ;
	var tip_index = 0;
	
	
	
	$(document).on('mouseenter', '#titlerule', function(){  // 监听鼠标移入事件
          tip_index = layer.tips(titlerule_html, '#titlerule', {
              tips: [1, "#"],  //1-4表示上右下左四个方向，# 可带背景色
              area: ['450px', 'auto'], // 提示框宽高
              time: 0  //自动关闭所需毫秒,0表示不自动关闭
            });
  	}).on('mouseleave', '#titlerule', function(){ // 监听鼠标移出事件
    	layer.close(tip_index);
	});
	
	$(document).on('mouseenter', '#numberrule', function(){  // 监听鼠标移入事件
          tip_index = layer.tips(numberrule_html, '#numberrule', {
              tips: [1, "#"],  //1-4表示上右下左四个方向，# 可带背景色
              area: ['450px', 'auto'], // 提示框宽高
              time: 0  //自动关闭所需毫秒,0表示不自动关闭
            });
  	}).on('mouseleave', '#numberrule', function(){ // 监听鼠标移出事件
    	layer.close(tip_index);
	});
				
	form.render();
	form.verify({
	//数组的两个值分别代表：[正则匹配、匹配不符时的提示文字]
		chinese: function(value, item){ //value：表单的值、item：表单的DOM对象
			var reg = new RegExp("[\\u4E00-\\u9FFF]+", "g");
			if((reg.test(value))){
				return '此项不能包含中文';
			}
		},	
		english: function(value, item){ //value：表单的值、item：表单的DOM对象
			var reg = new RegExp("[\\u4E00-\\u9FFF]+", "g");
			var reg1 = /[a-zA-Z]/;
			if((reg.test(value)|| reg1.test(reg1))){
				return '此项不能包含中英文';
			}
		},	
		length11: function(value, item){ //value：表单的值、item：表单的DOM对象
			if(value.length>11){
				return '字数已达上限';
			}
		},
		length9: function(value, item){ //value：表单的值、item：表单的DOM对象
			if(value.length>9){
				return '字数已达上限';
			}
		},
		length4: function(value, item){ //value：表单的值、item：表单的DOM对象
			if(value.length>4){
				return '字数已达上限';
			}
		},
		length2: function(value, item){ //value：表单的值、item：表单的DOM对象
			if(value.length>2){
				return '字数已达上限';
			}
		},
		length32: function(value, item){ //value：表单的值、item：表单的DOM对象
			if(value.length>32){
				return '字数已达上限';
			}
		},
		length100: function(value, item){ //value：表单的值、item：表单的DOM对象
			if(value.length>100){
				return '字数已达上限';
			}
		},
		length255: function(value, item){ //value：表单的值、item：表单的DOM对象
			if(value.length>255){
				return '字数已达上限';
			}
		}
	});
	var win=null;
	function SetData(obj) {
		win = obj.win ? obj.win : window;		
	}
	
	//监听按钮提交事件
	var submit = false;
    form.on('submit(save_data)', function(data) {
		if(submit == false){
			submit = true ;		
			var serial = JSON.stringify(data.field);

			$.ajax({
				url : "<%=request.getContextPath() %>/serialnumber/add",
				type : 'POST',
				data : serial,
				cache : false,
				contentType : 'text/json',
				success : function(result) {
					if(result.code == "0"){
						layer.msg(result.msg, {icon : 1,time : 1500},function() {
							var index = top.layer.getFrameIndex(window.name);
							win.layui.table.reload('tableReload');
							top.layer.close(index);
						});
					} else {
						layer.msg(result.msg, {icon : 2,time : 1500},function() {
							submit = false;		
						});
					}
				}
			});
		}else{
			layer.msg("正在提交中，请不要点击确定和取消！",{
				time:2000,
				icon:0,
			});
		}
	});
	
	//禁用按钮3秒
	function disabledSubmitButton(submitButtonName){
         $("#"+submitButtonName).attr({"disabled":"disabled"});     //控制按钮为禁用
         var timeoutObj = setTimeout(function () {
             $("#"+submitButtonName).removeAttr("disabled");//将按钮可用
             /* 清除已设置的setTimeout对象 */
             clearTimeout(timeoutObj)
         }, 3000);
     }
	
</script>
</body>
</html>