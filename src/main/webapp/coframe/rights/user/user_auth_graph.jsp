<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html>
<!-- 
  - Author(s): SSW
  - Date: 2021-03-30 10:42:05
  - Description:
-->
<head>
<title>
参与者权限
</title>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script> 
<script type="text/javascript"
	src="<%=request.getContextPath()%>/coframe/auth/authgraph/js/raphael-min.js"></script>
<script type="text/javascript"
	src="<%=request.getContextPath()%>/coframe/auth/authgraph/js/coframe_graph.js"></script>
<style>
		*{
			font-family: "Microsoft YaHei", "宋体", "Segoe UI", sans-serif;
    		font-size: 13px;
		}
	</style>
</head>
<body style="">
<div id="canvas"></div>
<script type="text/javascript">
var image_path = "<%=request.getContextPath()%>/coframe/tools/icons/";

node_images["user"] = image_path + "user.png";
node_images["position"] = image_path + "position.png";
node_images["emp"] = image_path + "emp.png";
node_images["group"] = image_path + "group.png";
node_images["duty"] = image_path + "duty.png";
node_images["org"] = image_path + "organization.png";
node_images["role"] = image_path + "authorization.png";
node_border_colors["role"] = "red";
node_border_colors["user"] = "#bf0000";
node_border_colors["position"] = "#bfac00";
node_border_colors["emp"] = "#7cbf00";

var partyData = {};

function SetData(data) {
	if (data) {
		var party = getPartyByNode(data);
 		partyData = {partyId:party.id,partyType:party.partyTypeID};
 		loadData();
	}
}

	function loadData() {
		 layui.jquery.ajax({
			 url: "com.zimax.components.coframe.auth.party.graph.Service.getPartyAuthGraph.biz.ext",
			 type: "POST",
			 data: JSON.stringify(partyData),  //将对象转化为json字符串
			 cache: false,
			 contentType: "text/json",
			 success: function(text) {
			 	if (text.exception) {
			 		layui.layer.msg(json.exception.message || JSON.stringify(json.exception));
			 		return;
			 	}
				drawGraph(text);
			 },
			 error: function(jqXHR, textStatus, errorThrown) {
			     layui.layer.msg(jqXHR.responseText);
			 }
		});
	}

	/* only do all this when document has finished loading (needed for RaphaelJS) */
	function drawGraph(json) {
	    if (!json) {
	    	return;
	    }
	    var width = layui.jquery(document).width() - 20;
	    var height = layui.jquery(document).height() - 66;
	    var coframeGraph = new CoframeGraph("canvas",width,height);
		var nodes = json["nodes"];
	
		for (var i=0;i<nodes.length;i++) {
			var node = nodes[i];
			coframeGraph.addNode(node);
			if (node.connections) {
				for (var j=0;j<node.connections.length;j++) {
					coframeGraph.addEdge(node.id, node.connections[j], { directed : true } );
				}
			}
		}
		coframeGraph.draw();
	    var result_shape = coframeGraph.getShape("auth_result");
	    if (result_shape) {
	    	for (var i = 0; i < result_shape.length; i++) {
	    		var item = result_shape[i];
	    	}
	    }
	    result_shape.click(function() {
	        var url=" <%=request.getContextPath() %>/coframe/auth/authgraph/compute_function_menu.jsp";
	    		top.layui.layer.open({
	    		type: 2,
	            title: "功能菜单计算结果", 
	            btn: ["关闭"],
				area: ['700px','410px'],
	            content: [url, 'no'], //弹窗不出现滚动条
	            success: function(layero,index) {
	            	var data = partyData;
	            	layero.find("iframe")[0].contentWindow.SetData(data);
	            },
	            end: function() {}
	        });
	    });
	};

	function getPartyByNode(node) {
		var party = {};
		if (!node) return party;
	    party = {
	        id: node.nodeId,
	        partyTypeID: "user"
	    }
	    return party;	
	}
</script>
</body>
</html>