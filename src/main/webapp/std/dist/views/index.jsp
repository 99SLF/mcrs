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
				<button class="layui-btn layuiadmin-btn-list layui-btn-warm layui-btn-sm" data-type="addEquipment"><i class="layui-icon layui-icon-add-circle-fine"></i>资产管理</button>
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
		<div class="layui-col-md3">
			<div class="layui-card-body">
				<div id="EchartZhu4" style="width: 300px;height: 250px;"></div>
			</div>
		</div>
		<div class="layui-col-md6" >
			<div class="layui-card-header" style=text-align:center>设备交互日志</div>
			<div class="layui-card-body">
				<table id="equipmentChangeLog" lay-filter="equipmentChangeLog"></table>
			</div>
		</div>
		<div class="layui-col-md3">
			<div class="layui-card-body">
				<div id="EchartZhu6" style="width: 320px;height: 250px;float:right;"></div>
			</div>
		</div>
	</div>
	<div class="layui-row">
		<div class="layui-col-md3">
			<div class="layui-card-body">
				<div id="EchartZhu7" style="width: 300px;height: 250px;"></div>
			</div>
		</div>
		<div class="layui-col-md6">
			<div class="layui-card-header" style=text-align:center>操作日志</div>
			<div class="layui-card-body">
				<table id="operationLog" lay-filter="operationLog"></table>
			</div>
		</div>
		<div class="layui-col-md3">
			<div class="layui-card-body">
				<div id="EchartZhu9" style="width: 300px;height: 250px;"></div>
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
	var layer = layui.layer;
	var table = layui.table;
	var util = layui.util;
	var activeWarn = [],hardWarn = [],recordDate = [];
	var form = layui.form;
	var chartZhu4 = echarts.init(document.getElementById('EchartZhu4'));
	var chartZhu6 = echarts.init(document.getElementById('EchartZhu6'));
	var chartZhu7 = echarts.init(document.getElementById('EchartZhu7'));
	var chartZhu9 = echarts.init(document.getElementById('EchartZhu9'));
	$("#deviceOnumber").html("99")
	$("#accessPointNumber").html("99");
	$("#accessPointOnumber").html("99");
	$("#warnTotal").html("99");
	$("#hardWarnTotal").html("99");
	$("#activeWarnTotal").html("99");
	// 终端数量
	$.ajax({
		url: "<%=request.getContextPath() %>/equipment/device/count",
		type: "GET",
		async: true,
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
	// 接入点数量
	$.ajax({
		url: "<%=request.getContextPath() %>/accPointResController/getCount",
		type: "GET",
		async: true,
		cache: false,
		contentType: "text/json",
		success: function (result) {
			if (result) {
				$("#accessPointNumber").html(result.data)
			} else {
				layer.msg("查询失败");
			}
		}
	});

	$.ajax({
		url: "<%=request.getContextPath() %>/DeviceAbnormalAlarm/groupQueryBydate",
		type: "GET",
		async: true,
		cache: false,
		contentType: "text/json",
		success: function (result) {
			activeWarn = [],hardWarn = [],recordDate = []
			if (result) {
				var data = result.data;
				debugger;
				if(data.length>0){
					for(var i=0;i<data.length;i++){
						var date= new Date(data[i].recordDate)
						var month = date.getMonth() + 1;
						var day = date.getDate();
						var str = month+'-'+day;
						recordDate.push(str);
						activeWarn.push(data[i].activeWarn);
						hardWarn.push(data[i].hardWarn);
					}
				}
				echartZhe();
			} else {
				layer.msg("查询失败");
			}
		}
	});
	$.ajax({
		url: "<%=request.getContextPath() %>/DeviceAbnormalAlarm/groupQueryByproduction",
		type: "GET",
		async: true,
		cache: false,
		contentType: "text/json",
		success: function (result) {
			if (result) {
				//$("#deviceNumber").html(result.data)
			} else {
				layer.msg("查询失败");
			}
		}
	});
	function getFullSize() {
		var fluid = $(".layui-fluid");
		var header = $(".layui-card-header");
		var cardbody = $(".layui-card-body");
		return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + (fluid.outerHeight(true) - fluid.height()) + 2;
	}


	$(window).resize(function () {
		table.reload("LAY-app-deviceExchangeLog-list-reload", {
			height: "full-" + getFullSize()
		});
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

	function echartZhe(){
		var optionchartZhe = {
			title: {
				text: '告警信息'
			},
			tooltip: {},
			legend: { //顶部显示 与series中的数据类型的name一致
				data: ['硬件告警', '行为告警'],
				left: 'right',
			},
			xAxis: {
				data: recordDate
			},
			yAxis: {
				type: 'value'
			},
			series: [{
				name: '硬件告警',
				type: 'line', //线性
				data: hardWarn,
			}, {
				name: '行为告警',
				type: 'line', //线性
				data: activeWarn,
			}]
		};
		chartZhu6.setOption(optionchartZhe, true);
	}


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
			radius: ['40%', '60%'],
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
	chartZhu7.setOption(optionchart, true);
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

	table.render({
		elem: "#equipmentChangeLog",
		id: "equipmentChangeLog",
		url: "<%= request.getContextPath() %>/log/deviceExchangeLog/query",
		method: "GET",
		height: "full-" + getFullSize+500,
		limit: 10,
		defaultToolbar: [""],
		parseData: function (res) {
			return {
				code: res.code,
				msg: res.msg,
				count: res.total,
				data: res.data
			};
		},
		cols: [[{
			field: "exchange_time",
			title: "操作时间",
			align: "center",
			minWidth: 100,
			templet:function(d){
				return util.toDateString(d.exchangeTime);
			},
		},{
			field: "equipmentId",
			title: "设备资源号",
			align: "center",
			minWidth: 100,
		},{
			field: "aPPId",
			title: "终端名称",
			align: "center",
			minWidth: 90,
		}, {
			field: "aPPId",
			title: "操作内容",
			align: "center",
			minWidth: 100,
		}, {
			field: "aPPId",
			title: "操作结果",
			align: "center",
			minWidth: 90,
		},{
			field: "operator",
			title: "操作人员",
			align: "center",
			minWidth: 90,
		}]]
	});
	table.render({
		elem: "#operationLog",
		id: "operationLog",
		url: "<%= request.getContextPath() %>/log/operationLog/query",
		method: "GET",
		height: "full-" + getFullSize+500,
		limit: 10,
		defaultToolbar: [""],
		parseData: function (res) {
			return {
				code: res.code,
				msg: res.msg,
				count: res.total,
				data: res.data
			};
		},
		cols: [[{
			field: "operationTime",
			title: "操作时间",
			align: "center",
			minWidth: 100,
			templet:function(d){
				return util.toDateString(d.operationTime);
			},
		},{
			field: "operationContent",
			title: "操作内容",
			align: "center",
			minWidth: 150,
		}, {
			field: "operationResult",
			title: "操作结果",
			align: "center",
			minWidth: 120,
		}, {
			field: "operator",
			title: "操作人",
			align: "center",
			minWidth: 120,
		}]]
	});

</script>
</body>
</html>
