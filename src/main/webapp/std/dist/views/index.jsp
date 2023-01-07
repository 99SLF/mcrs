<%--
  Created by IntelliJ IDEA.
  User: shilinfeng
  Date: 2023/1/5
  Time: 19:50
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
<body>
<div class="layui-fluid">
    <div class="layui-row layui-col-space15">
        <div class="layui-col-md8">
            <div class="layui-row layui-col-space15">
                <div class="layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">快捷方式</div>
                        <div class="layui-card-body">
                            <div class="layui-carousel layadmin-carousel layadmin-shortcut">
                                <ul class="layui-row layui-col-space10">
                                    <li class="layui-col-xs3">
                                        <a lay-href="<%=request.getContextPath() %>/basic/accPointResMaintain/accPointRes_add.jsp">
                                            <i class="layui-icon layui-icon-chart"></i>
                                            <cite>接入点新增</cite>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs3">
                                        <a lay-href="<%=request.getContextPath() %>/equipment/equipment/equipment_add.jsp">
                                            <i class="layui-icon layui-icon-set"></i>
                                            <cite>设备新增</cite>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs3">
                                        <a lay-href="<%=request.getContextPath() %>/equipment/equipment/equipment_add.jsp">
                                            <i class="layui-icon layui-icon-template-1"></i>
                                            <cite>终端注册</cite>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs3">
                                        <a lay-href="<%=request.getContextPath() %>/update/update_package_uploads.jsp">
                                            <i class="layui-icon layui-icon-chat"></i>
                                            <cite>更新包上传</cite>
                                        </a>
                                    </li>
                                </ul>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">终端实时数量</div>
                        <div class="layui-card-body">
                            <div class="layui-carousel layadmin-carousel layadmin-backlog">
                                <ul class="layui-row layui-col-space10">
                                    <li class="layui-col-xs6">
                                        <div class="layadmin-backlog-body">
                                            <h3>终端数量</h3>
                                            <p><cite id="deviceNumber">0</cite></p>
                                        </div>
                                    </li>
                                    <li class="layui-col-xs6">
                                        <div class="layadmin-backlog-body">
                                            <h3>终端在线数量</h3>
                                            <p><cite id="deviceOnumber">0</cite></p>
                                        </div>
                                    </li>
                                    <li class="layui-col-xs6">
                                        <div class="layadmin-backlog-body">
                                            <h3>接入点数量</h3>
                                            <p><cite id="accessPointNumber">0</cite></p>
                                        </div>
                                    </li>
                                    <li class="layui-col-xs6">
                                        <div class="layadmin-backlog-body">
                                            <h3>接入点在线数量</h3>
                                            <p><cite id="accessPointOnumber">0</cite></p>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-tab layui-tab-brief layadmin-latestData">
                            <ul class="layui-tab-title">
                                <li class="layui-this">终端行为记录</li>
                                <li>MCS行为记录</li>
                            </ul>
                            <div class="layui-tab-content">
                                <div class="layui-tab-item layui-show">
                                    <table id="equipmentChangeLog"></table>
                                </div>
                                <div class="layui-tab-item">
                                    <table id="operationLog"></table>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="layui-card">
                        <div class="layui-card-header">数据概览</div>
                        <div class="layui-card-body">

                            <div class="layui-carousel layadmin-carousel layadmin-dataview" data-anim="fade"
                                 lay-filter="LAY-index-dataview">
                                <div carousel-item id="LAY-index-dataview">
                                    <div><i class="layui-icon layui-icon-loading1 layadmin-loading"></i></div>
                                    <div></div>
                                    <div></div>
                                </div>
                            </div>

                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-col-md4">
            <div class="layui-card">
                <div class="layui-card-header">预警实时数量</div>
                <div class="layui-card-body">
                    <div class="layui-carousel layadmin-carousel layadmin-backlog">
                        <ul class="layui-row layui-col-space10">
                            <li class="layui-col-xs6">
                                <div class="layadmin-backlog-body">
                                    <h3>告警总数</h3>
                                    <p><cite id="warnTotal">0</cite></p>
                                </div>
                            </li>
                            <li class="layui-col-xs6">
                                <div class="layadmin-backlog-body">
                                    <h3>硬件告警总数</h3>
                                    <p><cite id="hardWarn">0</cite></p>
                                </div>
                            </li>
                            <li class="layui-col-xs6">
                                <div class="layadmin-backlog-body">
                                    <h3>行为告警总数</h3>
                                    <p><cite id="activeWarn">0</cite></p>
                                </div>
                            </li>
                        </ul>
                    </div>
                </div>

            </div>

            <div class="layui-card">
                <div class="layui-card-header">告警信息</div>
                <div class="layui-card-body">
                    <div id="EchartZhu6" style="width:100%;height: 300px"></div>
                </div>
            </div>

            <div class="layui-card">
                <div class="layui-card-header">告警分区占比</div>
                <div class="layui-card-body">
                    <div id="EchartZhu9" style="width: 100%;height: 300px"></div>
                </div>
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
    var activeWarn = [], hardWarn = [], recordDate = [];
    var bingData = [];
    var form = layui.form;
    <%--var chartZhu4 = echarts.init(document.getElementById('EchartZhu4'));--%>
    var chartZhu6 = echarts.init(document.getElementById('EchartZhu6'));
    <%--var chartZhu7 = echarts.init(document.getElementById('EchartZhu7'));--%>
    var chartZhu9 = echarts.init(document.getElementById('EchartZhu9'));
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
    // 在线数量
    $.ajax({
        url: "<%=request.getContextPath() %>/AccessMonitor/deviceAndaccess",
        type: "GET",
        async: true,
        cache: false,
        contentType: "text/json",
        success: function (result) {
            if (result) {
                $("#deviceOnumber").html(result.data.eqiOnline)
                $("#accessPointOnumber").html(result.data.accessOnline);
            } else {
                layer.msg("查询失败");
            }
        }
    });
    // 告警信息
    $.ajax({
        url: "<%=request.getContextPath() %>/DeviceAbnormalAlarm/getWarnInfo",
        type: "GET",
        async: true,
        cache: false,
        contentType: "text/json",
        success: function (result) {
            if (result) {
                $("#warnTotal").html(result.data.warnTotal)
                $("#hardWarn").html(result.data.hardWarn)
                $("#activeWarn").html(result.data.activeWarn)
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
            activeWarn = [], hardWarn = [], recordDate = []
            if (result) {
                var data = result.data;
                if (data.length > 0) {
                    for (var i = 0; i < data.length; i++) {
                        var date = new Date(data[i].recordDate)
                        var month = date.getMonth() + 1;
                        var day = date.getDate();
                        var str = month + '-' + day;
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
        url: "<%=request.getContextPath() %>/DeviceAbnormalAlarm/getWarnByproduction",
        type: "GET",
        async: true,
        cache: false,
        contentType: "text/json",
        success: function (result) {
            if (result) {
                var resData = result.data;
                var jsonData1 = {},jsonData2={},jsonData3 = {},jsonData4={};
                jsonData1.name = "冷压";
                jsonData1.value = resData.coldPress;
                bingData.push(jsonData1);
                jsonData2.name = "模切";
                jsonData2.value = resData.dieCut;
                bingData.push(jsonData2);
                jsonData3.name = "卷绕";
                jsonData3.value = resData.wind;
                bingData.push(jsonData3);
                jsonData4.name = "涂布";
                jsonData4.value = resData.coat;
                bingData.push(jsonData4);
                echartBing();
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
    //     var optionchart = {
    //         title: {
    //             text: '设备种类'
    //         },
    //         tooltip: {},
    //         legend: {
    //             data: ['销量']
    //         },
    //         xAxis: {
    //             data: ['周一', '周二', '周三', '周四', '周五', '周六', '周天']
    //         },
    //         yAxis: {
    //             type: 'value'
    //         },
    //         series: [{
    //             name: '销量',
    //             type: 'bar', //柱状
    //             data: [100, 200, 300, 400, 500, 600, 700],
    //             itemStyle: {
    //                 normal: { //柱子颜色
    //                     color: 'red'
    //                 }
    //             },
    //         }, {
    //             name: '产量',
    //             type: 'bar',
    //             data: [120, 210, 340, 430, 550, 680, 720],
    //             itemStyle: {
    //                 normal: {
    //                     color: 'blue'
    //                 }
    //             }
    //         }]
    //     };
    //
    function echartZhe() {
        var optionchartZhe = {
            tooltip: {},
            legend: { //顶部显示 与series中的数据类型的name一致
                data: ['硬件告警', '行为告警'],
                left: 'center',
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


    function echartBing() {
        var optionchartBing = {
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
                data: bingData
            }]
        };
        chartZhu9.setOption(optionchartBing, true);
    }

    // 按钮单击的事件监听
    $(".layui-btn.layuiadmin-btn-list").on("click", function () {
        var event = $(this).data("type");
        active[event] ? active[event].call(this) : "";
    });
    // chartZhu4.setOption(optionchart, true);
    // chartZhu7.setOption(optionchart, true);
    //chartZhu9.setOption(optionchartBing, true);
    var active = {}

    table.render({
        elem: "#equipmentChangeLog",
        id: "equipmentChangeLog",
        url: "<%= request.getContextPath() %>/log/deviceExchangeLog/query",
        method: "GET",
        height: "full-" + getFullSize,
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
            minWidth: 30,
            templet: function (d) {
                return util.toDateString(d.exchangeTime);
            },
        }, {
            field: "equipmentId",
            title: "设备资源号",
            align: "center",
            minWidth: 100,
        }, {
            field: "aPPId",
            title: "终端名称",
            align: "center",
            minWidth: 50,
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
        }, {
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
        height: "full-" + getFullSize + 500,
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
            templet: function (d) {
                return util.toDateString(d.operationTime);
            },
        }, {
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

