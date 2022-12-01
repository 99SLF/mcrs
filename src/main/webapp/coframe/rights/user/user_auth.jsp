<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!-- 
  - Author(s): SSW
  - Date: 2021-03-30 10:42:05
  - Description:
-->
<head>
<title>权限信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
<style>
	.layuiBtn{
		text-align:center;
	}
</style>
</head>
<body style="margin:0px;height:100%;">
	<div id="test3" class="demo-transfer" style="margin-top:10px;margin-left:60px"></div>
	<!-- <div class="layuiBtn">
		<button type="button" class="layui-btn" style="margin-left:-100px;margin-top:10px">
			<i class="layui-icon layui-icon-ok">保存</i>
		</button>
	</div> -->

<script src="<%=request.getContextPath()%>/common/layui/layui.all.js"></script>
<script>
	layui.config({
		base: "<%=request.getContextPath()%>/"
	});
</script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script>
	var layer = layui.layer;
	var transfer = layui.transfer;
	var layer = layui.layer;
	var util = layui.util;
	var $=layui.jquery;
	var userId = null;
	var transfers=[];
	var win=null;
	function SetData(data) {
		win = data.win ? data.win : window;
		console.log(parent.req_data);
		console.log(win);
		userId = win.req_data[0].userId;
		getAuthorizedRoleList();	     	      
	}

	$(function() {
		/* console.log(parent.req_data);
		console.log(win);
		userId = parent.req_data[0].userId;
		getAuthorizedRoleList(); */
	});
	
	function getPartyByNode(node) {
		var party = {};
		if (!node) return party;
	    party = {
	        id: node.nodeId,
	        partyTypeID: "user"
	    }
	    return party;	
	}
	
	//获取授权角色
	function getAuthorizedRoleList() {
		$.ajax({
			url: "com.zimax.components.coframe.auth.partyauth.PartyAuth.getAuthorizedRoleList.biz.ext",
				type: 'POST',
				data: JSON.stringify({"partyId":userId,"partyType":"user"}),
				cache: false,
				contentType: 'text/json',
			 	success: function (result) {
			 		for (var i=0;i < result.authorizedRoleList.length;i++) {
						var data1=result.authorizedRoleList[i];
						var data={};
						data["value"] = data1.id;
						data["title"] = data1.name;
						data["num"]=0;
						transfers.push(data);
		 			};
		 			getUnauthorizedRoleList();
				}
		});	
	}
	
	//获取未授权角色
	function getUnauthorizedRoleList() {
		$.ajax({
			url: "com.zimax.components.coframe.auth.partyauth.PartyAuth.getUnauthorizedRoleList.biz.ext",
			type: 'POST',
			data: JSON.stringify({"partyId":userId,"partyType":"user"}),
			cache: false,
			contentType: 'text/json',
	 		success: function(result) {
				for (var i=0;i < result.unauthorizedRoleList.length;i++) {
					var data1=result.unauthorizedRoleList[i];
					var data={};
					data["value"]=data1.id;
					data["title"]=data1.name;
					data["num"]=1;
					transfers.push(data);
			 	}
			 	real();
		 	},
		}); 
	}
	
	function real() {
		var value = [];
		for (var i = 0;i<transfers.length;i++) {
			if (transfers[i]["num"]==1) {
				value.push(transfers[i]["value"]);
			}
		}
		
 		transfer.render({
			elem: '#test3',
			width: '200px',
			height: '400px',
			title: ['已授权的角色', '未授权的角色'],
			data: transfers,
			value: value,
			onchange: function(data, index) {
				var roleList = [];
				for (var i =0;i<data.length;i++) { 
        			var roleList1 = {name: data[i].title, id: data[i].value};
        			roleList.push(roleList1);
				}
				var party = {id:userId,partyTypeID:"user"};
				var json = JSON.stringify({
					party: party,
					roleList: roleList	    	
				});
				if (index==0) {
					$.ajax({
						url: "com.zimax.components.coframe.auth.partyauth.PartyAuth.deletePartyAuth.biz.ext", 
						cache: false,
				    	data: json,
				    	type: 'POST',
				    	contentType: 'text/json',
				    	success: function(text) {
				    		if (text.result) {
					    		layer.msg("取消授权成功");
				    		}
			            },
			             error: function() {
	            		}
					});
	 			} else if (index == 1) {
				    $.ajax({
				    	url: "com.zimax.components.coframe.auth.partyauth.PartyAuth.addPartyAuth.biz.ext",
				    	cache: false,
				    	data: json,
				    	type: 'POST',
				    	contentType: 'text/json',
				    	success: function(text) {
				    		if (text.result) {
				    			layer.msg("授权成功");
				    		}
				    	},
				    	error: function() {
				    	}
					});
	 			}
			}
		}); 		
	}  	
</script>
</body>