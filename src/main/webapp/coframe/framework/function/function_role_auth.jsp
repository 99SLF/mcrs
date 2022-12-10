<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<title>角色功能授权</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/common/layui/css/layui.css">
</head>
<body>
<div class="layui-fluid" style="padding:10px;">
<div id="panel1" class="nui-panel" style="width:100%;height:100%;" showHeader="false"
    showToolbar="true" showCollapseButton="false" showFooter="false">
    <!--toolbar-->
    <div property="toolbar" style="padding:10px;">
    	<table style="width:100%;">
                <tr>
                <td style="width:100%;">
                	<button class="layui-btn layuiadmin-btn-list" data-type="save">保存</button>
                	<span class="separator"></span>
			      <!--  <a type="hidden" class="layui-btn layui-btn-normal layui-btn-sm" iconCls="icon-expand" onclick="expandAll()" title="全部展开">全部展开</a>
					<a type="hidden"class="layui-btn layui-btn-danger layui-btn-sm" iconCls="icon-collapse" onclick="collapseAll()" title="全部折叠">全部折叠</a>
               --> </td>
                <td style="white-space:nowrap;">
                	<input type="hidden" id="key" class="layui-input" style="width:100px;" onenter="onKeyEnter" emptyText="请输入查询条件" />
<!--					<a type="hidden" class="layui-btn layui-btn-sm" style="width:60px;" iconCls="icon-search" onclick="search()">查询</a>
-->                </td>
            </tr>
        </table> 
    </div>
    <!--body-->
 	<div class="layui-fluid" style="padding:0px 10px 10px 10px;">
		<div id="funcTree"></div>
<%--		<ul id="funcTree" class="nui-tree" style="width:100%;height:100%;"
			url="com.zimax.components.coframe.framework.FunctionAuth.getFunctionAuthTree.biz.ext"
			idField="id" textField="text" parentField="pid" resultAsTree="false"
			showTreeIcon="true" ajaxData="setRoleId" showTreeLines="true" expandOnDblClick="true" expandOnLoad="false" showCheckBox="true" checkRecursive="true">
		</ul>--%>
	</div>

</div>
</div>
<script src="<%=request.getContextPath()%>/common/layui/layui.all.js"></script>
<script type="text/javascript">
	var tree = layui.tree;
	var $ = layui.jquery;
	var data = [{
    	title: "一级1",
    	id: 1,
    	field: "name1",
    	checked: true,
    	spread: true,
    	children: [{
      		title: "二级1-1 可允许跳转",
      		id: 3,
      		field: "name11",
      		href: "https://www.layui.com/",
      		children: [{
        		title: "三级1-1-3",
		        id: 23,
		        field: "",
			        children: [{
			          title: "四级1-1-3-1",
			          id: 24,
			          field: "",
				          children: [{
					            title: "五级1-1-3-1-1",
					            id: 30,
					            field: ""
				          }, {
				            title: "五级1-1-3-1-2",
				            id: 31,
				            field: ""
				          }]
        			}]
			}, {
		        title: "三级1-1-1",
		        id: 7,
		        field: "",
		        children: [{
			          title: "四级1-1-1-1 可允许跳转",
			          id: 15,
			          field: "",
			          href: "https://www.layui.com/doc/"
			        }]
      		}, {
		        title: "三级1-1-2",
		        id: 8,
		        field: "",
		        children: [{
		          title: "四级1-1-2-1",
		          id: 32,
		          field: ""
		        }]
		      }]
    		}, {
		      title: "二级1-2",
		      id: 4,
		      spread: true,
		      children: [{
		        title: "三级1-2-1",
		        id: 9,
		        field: "",
		        disabled: true
     		 }, {
		        title: "三级1-2-2",
		        id: 10,
		        field: ""
		      }]
   			}, {
		      title: "二级1-3",
		      id: 20,
		      field: "",
		      children: [{
		        title: "三级1-3-1",
		        id: 21,
		        field: ""
		     }, {
        title: "三级1-3-2",
        id: 22,
        field: ""
      }]
    }]
  }, {
    title: "一级2",
    id: 2,
    field: "",
    spread: true,
    children: [{
      title: "二级2-1",
      id: 5,
      field: "",
      spread: true,
      children: [{
        title: "三级2-1-1",
        id: 11,
        field: ""
      }, {
        title: "三级2-1-2",
        id: 12,
        field: ""
      }]
    }, {
      title: "二级2-2",
      id: 6,
      field: "",
      children: [{
        title: "三级2-2-1",
        id: 13,
        field: ""
      }, {
        title: "三级2-2-2",
        id: 14,
        field: "",
        disabled: true
      	}]
    }]
	}, {
	    title: "一级3",
	    id: 16,
	    field: "",
	    children: [{
	      title: "二级3-1",
	      id: 17,
	      field: "",
	      fixed: true,
	      children: [{
	        title: "三级3-1-1",
	        id: 18,
	        field: ""
	      }, {
	        title: "三级3-1-2",
	        id: 19,
	        field: ""
	      }]
	    }, {
	      title: "二级3-2",
	      id: 27,
	      field: "",
	      children: [{
	        title: "三级3-2-1",
	        id: 28,
	        field: ""
	      }, {
	        title: "三级3-2-2",
	        id: 29,
	        field: ""
	      }]
	    }]
	  }];
	
	var active = {
		getLeafNodes: function(funcDatas, leafNodes) {
			for (var cursor = 0; cursor < funcDatas.length; cursor++) {
				var node = funcDatas[cursor];
				if (node.type === "function") {
					leafNodes.push(node);
				} else {
					active.getLeafNodes(node.children, leafNodes);
				}
			}
		},
		save: function() {
			var funcDatas = tree.getChecked("funcTree1");
			var leafNodes = [];
			active.getLeafNodes(funcDatas, leafNodes);
			var json = JSON.stringify(leafNodes);
			$.ajax({
				url: "<%=request.getContextPath()%>/function/auth/save/<%=request.getParameter("roleId") %>",
				type: "POST",
				data: json,
				cache: false,
				contentType: "text/json",
				success: function(text) {
					layer.msg("权限设置成功!", {
						icon: 1,
						time: 2000
					});
				},
				error: function () {
					layer.msg("权限设置失败");
				}
			});
		},
		del: function() {
		}
	};
	
	$(".layui-btn.layuiadmin-btn-list").on("click", function() {
		var type = $(this).data("type");
		active[type] ? active[type].call(this) : "";
    });
	
	function getData(datas, id) {
		for (var i = 0; i < datas.length; i++) {
			var data = datas[i];
			if (data.id === id) {
				return data;
			}
		}
	}
	
	$.ajax({
		url: "<%=request.getContextPath()%>/function/auth/tree/<%= request.getParameter("roleId")%>",
		type: "GET",
		cache: false,
		contentType: "text/json",
		success: function (text) {
			var datas = text.data;
			var renderDatas = [];
			var addDatas = [];
			for (var i = 0; i < datas.length; i++) {
				var data = datas[i];
				if (data.pid) {
					var pdata = getData(addDatas, data.pid);
					if (pdata) {
						var renderData = {
							id: data.id,
							title: data.text,
							type: data.type,
							realId: data.realId,
							checked: data.checked,
							spread: true,
							children: []
						};
						pdata.children.push(renderData);
						addDatas.push(renderData);
					}
				} else {
					var renderData = {
						id: data.id,
						title: data.text,
						type: data.type,
						realId: data.realId,
						checked: data.isCheck === "1" ? true : false,
						spread: true,
						children: []
					};
					renderDatas.push(renderData);
					addDatas.push(renderData);
				}
			}
			tree.render({
				elem: "#funcTree",
				data: renderDatas,
				showCheckbox: true,
				id: "funcTree1",
				isJump: true
			});
		},
		error: function () {
		}
	});

	function setRoleId(){
		return {
			roleId: "<%= request.getParameter("roleId")%>"
		};
	}

	function saveTree() {
		var funcDatas = tree.getChecked("funcTree1");
		var leafNodes = [];
		for (var cursor = 0; cursor < funcDatas.length; cursor++) {
			var node = funcDatas[cursor];
			if (funcTree.isLeaf(node)) {
				leafNodes.push(node);
			}
		}
		var json = JSON.stringify({
			functions: leafNodes,
			roleId: "<%=request.getParameter("roleId") %>"
		});
		$.ajax({
			url: "com.zimax.components.coframe.framework.FunctionAuth.saveFunctionAuths.biz.ext",
			type: "POST",
			data: json,
			cache: false,
			contentType: "text/json",
			success: function(text) {
				layer.alert("权限设置成功");
			},
			error: function () {
				layer.alert("权限设置失败");
			}
		});
	}

	function search(){
		var filtedNodes = [];
		var key = nui.get("key").getValue();
		if (key == "") {
			funcTree.clearFilter();
		} else {
			var rootNode = funcTree.getRootNode();
			funcTree.cascadeChild(
				rootNode,
				function(node){
					var pNode = funcTree.getParentNode(node);
					var nofind = true;
					for (i = 0; i < filtedNodes.length; i++) {
						if (filtedNodes[i] == pNode.id) {
							filtedNodes.push(node.id);
							nofind = false;
							break;
						}
					}
					if (nofind) {
						var text = node.text ? node.text.toLowerCase() : "";
						if (text.indexOf(key) != -1) {
							filtedNodes.push(node.id);
						}
					}
				}
			);
			funcTree.filter(function(node){
				for (i = 0; i < filtedNodes.length; i++) {
					if (filtedNodes[i] == node.id) {
						return true;
					}
				}
			});
		}
	}

	function expandAll(){
		funcTree.expandAll();
	}

	function collapseAll(){
		funcTree.collapseAll();
	}
</script>
</body>
</html>