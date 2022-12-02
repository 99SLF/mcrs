<%@page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%--<%@page import="com.mes.system.utility.StringUtil"%>--%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
</head>
<body>
	<div style="padding: 0 10px;margin-top: 10px;" class="mcolor"></div>		    
		<form class="layui-form"  method="post" lay-filter="editform">
			<div class="page-form">
				<input type="hidden" name="menu/parentMenu/menuId"/>						
				<div class="layui-form-item">
					<label class="layui-form-label layui-form-project" style="width: 120px;">菜单名称：</label>
					<div class="layui-input-inline">
                		<input id="menu.menuId" name="menu.menuId" type="hidden"/>
	                    <input id="menu.menuAction" name="menu.menuAction" type="hidden"/>
	                    <input id="menu.menuLevel" name="menu.menuLevel" type="hidden"/>
	                    <input id="menu.menuSeq" name="menu.menuSeq" type="hidden"/>
	                    <input id="menu.subCount" name="menu.subCount" type="hidden"/>  
						<input type="text" class="layui-input" name="menu/menuName" id="menuName"  lay-verify="required" autocomplete="off" placeholder="">
					</div>
					<label class="layui-form-label layui-form-project" style="width: 120px;">菜单代码：</label>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" name="menu/menuCode" id="menuCode" lay-verify="required" autocomplete="off" placeholder="">
					</div>
				</div>	
				<div class="layui-form-item">
					<label class="layui-form-label layui-form-project" style="width: 120px;">菜单显示名称：</label>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" name="menu/menuLabel" id="menuLabel"  lay-verify="required" autocomplete="off" placeholder="">
					</div>
					<label class="layui-form-label layui-form-project" style="width: 120px;">菜单显示顺序：</label>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" name="menu/displayOrder" id="displayOrder"  lay-verify="required" autocomplete="off" placeholder="">
					</div>
				</div> 	
				<div class="layui-form-item">
					<label class="layui-form-label layui-form-project" style="width: 120px;">是否为叶子菜单：</label>
					<div class="layui-input-inline">
				    	<select name="menu/isLeaf" id="isLeaf" lay-filter="isLeaf" type="select">
							<option value=""></option>
						</select>
					</div>
					<label class="layui-form-label layui-form-project" style="width: 120px;">功能资源：</label>
					<div class="layui-input-inline">
						<input type="text" class="layui-input" name="menu/funcCode" id="funcCode" lay-verify="required" autocomplete="off" placeholder="">
					</div>
				</div>	
				<div class="layui-form-item">
					<label class="layui-form-label layui-form-project" style="width: 120px;">打开方式：</label>
					<div class="layui-input-inline">
						<select name="menu/openMode" id="openMode" lay-filter="openMode" type="select">
							<option value=""></option>
						</select>
					</div>
				</div>
				<div class="layui-form-item">
					<label class="layui-form-label"> </label>
					<div class="layui-input-block" style="margin-left: 300px">
						<button type="submit" lay-submit="" style="width: 30%;" class="layui-btn layui-btn-fluid" id="sava_data" lay-filter="sava_data">保存</button>
					</div>
				</div>
			</div>
		</form>

<script type="text/javascript">
	//采用全加载模块
	;!function(){
  	  //无需再执行layui.use()方法加载模块，直接使用即可
		var layer = layui.layer, //弹层
	  		table = layui.table, //表格
			form = layui.form, //表单
			$ = layui.jquery; //jquery      
		var submit = false;
            
     //获取数据
		var menuid = "<%= StringUtil.htmlFilter(request.getParameter("id")) %>";
		var json = JSON.stringify({
			template: {
				menuId: menuId
			}
		});
		$.ajax({
		    url: "com.zimax.components.coframe.framework.MenuManager.getMenu.biz.ext",
		    type: 'POST',
		    data: json,
		    cache: false,
		    contentType: 'text/json',
		    cache: false,
		    success: function (text) {
	        form.val('editform', {
			 	"menu/menuName": text.menu.menuName,
				"menu/menuCode": text.menu.menuCode,
				"menu/menuLabel": text.menu.menuLabel,
				"menu/displayOrder": text.menu.displayOrder,
				"menu/isLeaf": text.menu.isLeaf,
				"menu/funcCode": text.menu.funcCode,
				"menu/openMode": text.menu.openMode
			   });
			}
		});
       
      	//提交
		form.on('submit(sava_data)', function(data){	  //根据 lay-filter
			if (submit == false) {
				submit = true;
				var submitData=JSON.stringify(data.field);  //获取name的value
				$.ajax({
					url: "com.zimax.components.coframe.framework.MenuManager.updateMenu.biz.ext",
					type: 'POST',
					data: submitData,
					cache: false,
					contentType: 'text/json',
					success: function(result) {
						layer.msg('添加成功', {
							icon: 1,
							time: 2000
						}, function() {
							var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
							parent.layer.close(index); //再执行关闭  
		    			});
						/* if(result.retCode == 1){
							layer.msg('添加成功', {icon: 1,time: 2000}, function() {
								var index = parent.layer.getFrameIndex(window.name); //先得到当前iframe层的索引
								parent.layer.close(index); //再执行关闭  
		        			});
						} else if(result.retCode == 0){
							layer.msg('姓名重复请仔细检查', {icon: 1,time: 3000}, function() {
								
		        			});
						}else if(result.retCode == -1){
							layer.msg('错误', {icon: 1,time: 3000}, function() {
								
		        			});
						} */
					}
				});		
			} else {
				layer.msg('正在添加...请稍等！');
			}
			return false; 
		});	  
	  	
	  	//数据校验
	  	/* form.verify({
    		 names:function(value,item){
    			if(new RegExp("[`~@$%^&*\\[\\]<>/~@#￥%……&*|【】]").test(value)){
   			      return '不能含有特殊字符!';
   				}if(/(^\_)|(\__)|(\_+$)/.test(value)){
   			      return '首尾不能出现下划线\'_\'';
   		    	}
    		},numbers:function(value,item){
				if(value.lemgth>255){
					return '字数不能超过255个字！';
        		}if(new RegExp("[`~@$^&*\\[\\]<>/~@#￥……&*|【】]").test(value)){
  			      return '不能含有特殊字符!';
    			}if(/(^\_)|(\__)|(\_+$)/.test(value)){
    			      return '首尾不能出现下划线\'_\'';
    		    }
    		}
    	}); */
	}();
	 
	 //打开选择页
	  <%-- nui.open({
                url: "<%=request.getContextPath() %>/coframe/framework/function/entrance_select.jsp",
                title: "选择功能调用入口", 
                width: 350, 
                height: 460,
                allowResize:false,
                ondestroy: function (action) {
                    //grid.reload();
                   if (action == "ok") {
                        var iframe = this.getIFrameEl();
                        var data = iframe.contentWindow.getData();
                        data = nui.clone(data);    //必须
                        if (data) {
                        	var url = data.resUrl;
                        	if(url.indexOf("/")!=0){
                        		url = "/"+url;
                        	}
                            btnEdit.setValue(url);
                            btnEdit.setText(url);
                            if (!(data.resType == "startprocess")) {
                             	var respara = nui.get("paraInfo");
                             	respara.setValue(data.resPara);
                            }
                            var restype = nui.get("resType");
                            restype.setValue(data.resType);
                        }
                    } 
                }
            }); --%>
          
            
       /* function codevalidation(e){
        	if(e.value == tempMenuCode) return;
        	if(e.isValid){
        		var data = {menucode:e.value};
        		var json = nui.encode({template:data});
	        	$.ajax({
                    url: "com.zimax.components.coframe.framework.MenuManager.validateMenu.biz.ext",
                    type: 'POST',
	                data: json,
	                cache: false,
	                contentType:'text/json',
                    cache: false,
                    async:false,
                    success: function (text) {
                       var o = nui.decode(text);
                        if(o.data == "1"){
                        	e.errorText = "功能编码不唯一，请请重新填写";
	        				e.isValid = false;
                        }
                    }
	           });
        	}
        }
        function menuTypeChange(e){
        	var type = nui.get("appmenu.isleaf").getValue();
        	
    		nui.get("funccode").set({"required":type=="1"});
    		nui.get("funccode").set({"enabled":type=="1"});
    		nui.get("appmenu.openmode").set({"enabled":type=="1"});
        } */
</script>
</body>
</html>