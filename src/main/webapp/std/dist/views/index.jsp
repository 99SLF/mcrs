<%--
  Created by IntelliJ IDEA.
  User: shilinfeng
  Date: 2022/12/23
  Time: 11:06
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
	<title>主页</title>
	<meta charset="utf-8">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css"/>
	<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/custom.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/layout.css">
	<link rel="stylesheet" href="<%= request.getContextPath() %>/iconfont/iconfont.css">
	<style>
		.layui-form-label {
			width: 130px;
		}
	</style>
</head>
<body style="background-color: white;">
<div class="layui-card">
	<div class="layui-row">
		<div class="layui-col-md4">
			<div class="layui-panel">
				<div class="layui-col-md6">
					<div class="layui-card-body" style=text-align:center>
						<br/><h2>终端数量</h2><br/>
						<h1 id="deviceNumber" style=text-align:center>0</h1>
					</div>
				</div>
				<div class="layui-col-md6">
					<div class="layui-card-body"style=text-align:left>
						<div class="layui-row">
							<label class="layui-form-label">终端在线数量：<span id="deviceOnumber">0</span></label>
						</div>
						<div class="layui-row">
							<label class="layui-form-label">接入点数量：<span id="accessPointNumber">0</span></label>
						</div>
						<div class="layui-row">
							<label class="layui-form-label">接入点在线数量：<span id="accessPointOnumber">0</span></label>
						</div>
					</div>
				</div>
			</div>
		</div>
		<div class="layui-col-md4">
			<div class="layui-card-body" style=margin:30px>
				<button class="layui-btn layuiadmin-btn-list layui-btn-sm" data-type="addAccessPoint"><i class="layui-icon layui-icon-add-circle-fine"></i>接入点管理</button>
				<button class="layui-btn layuiadmin-btn-list layui-btn-warm layui-btn-sm" data-type="addEquipment"><i class="layui-icon layui-icon-add-circle-fine"></i>设备管理</button>
				<button class="layui-btn layuiadmin-btn-list layui-btn-normal layui-btn-sm" data-type="addDevice"><i class="layui-icon layui-icon-add-circle-fine"></i>终端管理</button>

			</div>
		</div>
		<div class="layui-col-md4">
			<div class="layui-panel">
				<div class="layui-col-md4">
					<div class="layui-card-body" style=text-align:center>
						<br/><h2>告警总数</h2><br/>
						<h1 id="warnTotal" style=text-align:center>0</h1>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-card-body" style=text-align:center>
						<br/><h2>硬件告警数</h2><br/>
						<h1 id="hardWarnTotal" style=text-align:center>0</h1>
					</div>
				</div>
				<div class="layui-col-md4">
					<div class="layui-card-body" style=text-align:center>
						<br/><h2>行为告警数</h2><br/>
						<h1 id="activeWarnTotal" style=text-align:center>0</h1>
					</div>
				</div>
			</div>
		</div>
	</div>
	<br/>
	<div class="layui-row">
		<div class="layui-col-md4">
			<div class="layui-card-body">
				<div id="EchartZhu4" style="width: 500px;height: 500px;"></div>
			</div>
		</div>
		<div class="layui-col-md4">
			<div class="layui-card-body">
				<div id="EchartZhu5" style="width: 500px;height: 500px;"></div>
			</div>
		</div>
		<div class="layui-col-md4">
			<div class="layui-card-body">
				<div id="EchartZhu6" style="width: 500px;height: 500px;"></div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-md4">
			<div class="layui-card-body">
				<div id="EchartZhu7" style="width: 500px;height: 500px;"></div>
			</div>
		</div>
		<div class="layui-col-md4">
			<div class="layui-card-body">
				<div id="EchartZhu8" style="width: 500px;height: 500px;"></div>
			</div>
		</div>
		<div class="layui-col-md4">
			<div class="layui-card-body">
				<div id="EchartZhu9" style="width: 500px;height: 500px;"></div>
			</div>
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
<script src="<%=request.getContextPath()%>/std/dist/echarts.js"></script>
<script type="text/javascript">
	var echarts = layui.echarts;
	var $ = layui.jquery;
	var chartZhu4 = echarts.init(document.getElementById('EchartZhu4'));
	var chartZhu5 = echarts.init(document.getElementById('EchartZhu5'));
	var chartZhu6 = echarts.init(document.getElementById('EchartZhu6'));
	var chartZhu7 = echarts.init(document.getElementById('EchartZhu7'));
	var chartZhu8 = echarts.init(document.getElementById('EchartZhu8'));
	var chartZhu9 = echarts.init(document.getElementById('EchartZhu9'));
	$("#deviceOnumber").html("99")
	$("#accessPointNumber").html("99");
	$("#accessPointOnumber").html("99");
	$("#warnTotal").html("99");
	$("#hardWarnTotal").html("99");
	$("#activeWarnTotal").html("99");
	$.ajax({
		url: "<%=request.getContextPath() %>/equipment/device/count",
		type: "GET",
		async: false,
		cache: false,
		contentType: "text/json",
		success: function (result) {
			if (result) {
				$("#deviceNumber").html(result.data)
			} else {
				layer.msg("查询失败");
			}
		}
	});
	//指定图表配置项和数据
	var optionchart = {
		title: {
			text: '设备种类'
		},
		tooltip: {},
		legend: {
			data: ['销量']
		},
		xAxis: {
			data: ['周一', '周二', '周三', '周四', '周五', '周六', '周天']
		},
		yAxis: {
			type: 'value'
		},
		series: [{
			name: '销量',
			type: 'bar', //柱状
			data: [100, 200, 300, 400, 500, 600, 700],
			itemStyle: {
				normal: { //柱子颜色
					color: 'red'
				}
			},
		}, {
			name: '产量',
			type: 'bar',
			data: [120, 210, 340, 430, 550, 680, 720],
			itemStyle: {
				normal: {
					color: 'blue'
				}
			}
		}]
	};

	var optionchartZhe = {
		title: {
			text: '告警信息'
		},
		tooltip: {},
		legend: { //顶部显示 与series中的数据类型的name一致
			data: ['硬件告警', '行为告警']
		},
		xAxis: {
			data: ['周一', '周二', '周三', '周四', '周五', '周六', '周日']
		},
		yAxis: {
			type: 'value'
		},
		series: [{
			name: '硬件告警',
			type: 'line', //线性
			data: [145, 230, 701, 734, 1090, 1130, 1120],
		}, {
			name: '行为告警',
			type: 'line', //线性
			data: [720, 832, 801, 834, 1190, 1230, 1220],
		}]
	};

	var optionchartBing = {
		title: {
			text: '告警分区占比',
			//subtext: '纯属虚构', //副标题
			x: 'center' //标题居中
		},
		tooltip: {
// trigger: 'item' //悬浮显示对比
		},
		legend: {
			orient: 'vertical', //类型垂直,默认水平
			left: 'left', //类型区分在左 默认居中
			data: ['模切', '涂布', '卷绕', '冷压']
		},
		series: [{
			type: 'pie', //饼状
			radius: '60%', //圆的大小
			center: ['50%', '50%'], //居中
			data: [{
				value: 335,
				name: '涂布'
			},
				{
					value: 310,
					name: '模切'
				},
				{
					value: 234,
					name: '卷绕'
				},
				{
					value: 135,
					name: '冷压'
				}
			]
		}]
	};
	// 按钮单击的事件监听
	$(".layui-btn.layuiadmin-btn-list").on("click", function() {
		var event = $(this).data("type");
		active[event] ? active[event].call(this) : "";
	});
	chartZhu4.setOption(optionchart, true);
	chartZhu5.setOption(optionchartBing, true);
	chartZhu6.setOption(optionchartZhe, true);
	chartZhu7.setOption(optionchart, true);
	chartZhu8.setOption(optionchartZhe, true);
	chartZhu9.setOption(optionchartBing, true);
	var active = {
		addAccessPoint:function(){
			top.layui.index.openTabsPage( "<%=request.getContextPath() %>/basic/accPointResMaintain/accPointRes_list.jsp","接入点管理");
		},
		addEquipment:function(){
			top.layui.index.openTabsPage( "<%=request.getContextPath() %>/equipment/equipment/equipment_list.jsp","资产管理");
		},
		addDevice:function(){
			top.layui.index.openTabsPage( "<%=request.getContextPath() %>/equipment/device/device_list.jsp","终端管理");
		},

	}

</script>
</body>
</html>
