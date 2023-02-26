<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): SSW ，李伟杰
  - Date: 2021-03-30 10:42:05
  - Description:
-->
<head>
<title>权限信息</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" media="all">
<style>
	.layuiBtn{
		text-align:center;
	}
</style>
</head>
<body style="margin:0px;height:100%;">
<div id="test3" class="demo-transfer" style="margin-top:10px;margin-left:60px"></div>
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
	var $ = layui.jquery;
	
	var userId = null;
	var transfers = [];
	var win = null;
	var party = {};
	
	function SetData(data) {
		win = data.win ? data.win : window;
		party = {
			partyId: data.partyId,
			partyType: data.partyType
		};
		getAuthorizedRoleList();
	}
	
	//获取授权角色
	function getAuthorizedRoleList() {
		$.ajax({
			url: "<%=request.getContextPath()%>/party/auth/authorized/" + party.partyType + "/" + party.partyId,
				type: "GET",
				cache: false,
				contentType: "text/json",
				success: function(result) {
					for (var i = 0; i < result.data.length; i++) {
						var partyData = result.data[i];
						var data = {};
						data["value"] = partyData.id;
						data["title"] = partyData.name;
						data["num"] = 0;
						transfers.push(data);
					};
					getUnauthorizedRoleList();
			}
		});
	}
	
	//获取未授权角色
	function getUnauthorizedRoleList() {
		$.ajax({
			url: "<%=request.getContextPath()%>/party/auth/unauthorized/" + party.partyType + "/" + party.partyId,
			type: "GET",
			cache: false,
			contentType: "text/json",
			success: function(result) {
				for (var i = 0; i < result.data.length; i++) {
					var party = result.data[i];
					var data = {};
					data["value"] = party.id;
					data["title"] = party.name;
					data["num"] = 1;
					transfers.push(data);
				}
				real();
			}
		});
	}
	
	function real() {
		var value = [];
		for(var i = 0; i < transfers.length; i++) {
			if (transfers[i]["num"] == 1) {
				value.push(transfers[i]["value"]);
			}
		}
		var id = party.partyId;
		var partyTypeID = party.partyType;
		transfer.render({
			elem: "#test3",
			width: "200",
			height: "400",
			title: ["已授权的角色", "未授权的角色"],
			data: transfers,
			value: value,
			onchange: function(data, index) {
				var roleList = [];
				for (var i = 0; i < data.length; i++) {
					var roleList1 = {
						name: data[i].title,
						id: data[i].value
					};
					roleList.push(roleList1);
				}
				var json = JSON.stringify(roleList);
				if (index == 0) {
					$.ajax({
						url: "<%=request.getContextPath()%>/party/auth/delete/" + partyTypeID + "/" + id,
						cache: false,
						data: json,
						type: "POST",
						contentType: "text/json",
						success: function(text) {
						    debugger;
							if (text.code) {
								layer.msg("取消授权成功",{
                                    icon: 1,
                                    time: 1000
                                },function (){
                                    win.layui.table.reload('LAY-app-user-list-reload');
                                });
							}
						},
						error: function() {
						}
					});
				} else if (index == 1) {
					$.ajax({
						url: "<%=request.getContextPath()%>/party/auth/add/" + partyTypeID + "/" + id,
						cache: false,
						data: json,
						type: "POST",
						contentType: "text/json",
                        success: function(text) {
                            debugger;
                            if (text.code) {
                                layer.msg("授权成功",{
                                    icon: 1,
                                    time: 1000
                                },function (){
                                    win.layui.table.reload('LAY-app-user-list-reload');
                                });
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
</html>