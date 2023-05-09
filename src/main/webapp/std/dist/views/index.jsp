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
                                        <a lay-href="<%=request.getContextPath() %>/basic/accPointResMaintain/accPointRes_list.jsp">
                                            <i class="layui-icon layui-icon-chart"></i>
                                            <cite>接入点维护</cite>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs3">
                                        <a lay-href="<%=request.getContextPath() %>/equipment/equipment/equipment_list.jsp">
                                            <i class="layui-icon layui-icon-set"></i>
                                            <cite>资产管理</cite>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs3">
                                        <a lay-href="<%=request.getContextPath() %>/equipment/device/device_list.jsp">
                                            <i class="layui-icon layui-icon-template-1"></i>
                                            <cite>终端管理</cite>
                                        </a>
                                    </li>
                                    <li class="layui-col-xs3">
                                        <a lay-href="<%=request.getContextPath() %>/update/update_package_manager.jsp">
                                            <i class="layui-icon layui-icon-chat"></i>
                                            <cite>更新管理</cite>
                                        </a>
                                    </li>
                                </ul>
                            </div>

                        </div>
                    </div>
                </div>
                <div class="layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">终端数量</div>
                        <div class="layui-card-body">
                            <div class="layui-carousel layadmin-carousel layadmin-backlog">
                                <ul class="layui-row layui-col-space10">
                                    <li class="layui-col-xs6">
                                        <div class="layadmin-backlog-body">
                                            <h3>终端总数</h3>
                                            <p><cite id="deviceNumber">0</cite></p>
                                        </div>
                                    </li>
                                    <li class="layui-col-xs6">
                                        <div class="layadmin-backlog-body">
                                            <h3>终端正常数量</h3>
                                            <p><cite id="deviceOnumber">0</cite></p>
                                        </div>
                                    </li>
                                    <li class="layui-col-xs6">
                                        <div class="layadmin-backlog-body">
                                            <h3>终端异常数量</h3>
                                            <p><cite id="deviceEnumber">0</cite></p>
                                        </div>
                                    </li>
                                    <li class="layui-col-xs6">
                                        <div class="layadmin-backlog-body">
                                            <h3>终端未启动数量</h3>
                                            <p><cite id="deviceNsnumber">0</cite></p>
                                        </div>
                                    </li>
<%--                                    <li class="layui-col-xs6">--%>
<%--                                        <div class="layadmin-backlog-body">--%>
<%--                                            <h3>接入点数量</h3>--%>
<%--                                            <p><cite id="accessPointNumber">0</cite></p>--%>
<%--                                        </div>--%>
<%--                                    </li>--%>
<%--                                    <li class="layui-col-xs6">--%>
<%--                                        <div class="layadmin-backlog-body">--%>
<%--                                            <h3>接入点在线数量</h3>--%>
<%--                                            <p><cite id="accessPointOnumber">0</cite></p>--%>
<%--                                        </div>--%>
<%--                                    </li>--%>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md12">
                    <div class="layui-card">
                        <div class="layui-tab layui-tab-brief layadmin-latestData">
                            <ul class="layui-tab-title">
<%--                                <li class="layui-this">终端行为记录</li>--%>
                                <li>MCRS行为记录</li>
                            </ul>
                            <div class="layui-tab-content">
<%--                                <div class="layui-tab-item layui-show">--%>
<%--                                    <table id="equipmentChangeLog"></table>--%>
<%--                                </div>--%>
                                <div class="layui-tab-item layui-show">
                                    <table id="operationLog"></table>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">工序对应设备数量</div>
                        <div class="layui-card-body">
                            <div id="EchartZhu7" style="width: 100%;height: 300px;"></div>
                        </div>
                    </div>
                </div>
                <div class="layui-col-md6">
                    <div class="layui-card">
                        <div class="layui-card-header">
                            各工厂的工序对应设备数量</div>
                        <div class="layui-card-body">
                            <div id="EchartZhu8" style="width: 100%;height: 300px;"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="layui-col-md4">
            <div class="layui-card">
                <div class="layui-card-header">预警数量</div>
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
    var processName = []
    var activeWarn = [], hardWarn = [], recordDate = [],eqiByProcess=[]
    var bingData = [],bingProcessName = [];
    var duiProcessName=[],factotyName=[];
    var seriesData = [];
    var form = layui.form;
    var chartZhu6 = echarts.init(document.getElementById('EchartZhu6'));
    var chartZhu7 = echarts.init(document.getElementById('EchartZhu7'));
    var chartZhu8 = echarts.init(document.getElementById('EchartZhu8'));
    var chartZhu9 = echarts.init(document.getElementById('EchartZhu9'));
    // 终端数量
    $.ajax({
        url: "<%=request.getContextPath() %>/equipment/device/countReg",
        type: "GET",
        async: true,
        cache: false,
        contentType: "text/json",
        success: function (result) {
            if (result) {
                var data = result.data;
                $("#deviceNumber").html(data.deviceNumber)
                $("#deviceOnumber").html(data.deviceOnumber)
                $("#deviceEnumber").html(data.deviceEnumber)
                $("#deviceNsnumber").html(data.deviceNsnumber)

            } else {
                layer.msg("查询失败");
            }
        }
    });
    // 接入点数量
    <%--$.ajax({--%>
    <%--    url: "<%=request.getContextPath() %>/accPointResController/getCount",--%>
    <%--    type: "GET",--%>
    <%--    async: true,--%>
    <%--    cache: false,--%>
    <%--    contentType: "text/json",--%>
    <%--    success: function (result) {--%>
    <%--        if (result) {--%>
    <%--            $("#accessPointNumber").html(result.data)--%>
    <%--        } else {--%>
    <%--            layer.msg("查询失败");--%>
    <%--        }--%>
    <%--    }--%>
    <%--});--%>
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

    // 告警信息折线图
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
    // 饼图
    $.ajax({
        url: "<%=request.getContextPath() %>/DeviceAbnormalAlarm/getWarnByproduction",
        type: "GET",
        async: true,
        cache: false,
        contentType: "text/json",
        success: function (result) {
            if (result) {
                var resData = result.data;
                bingData = resData
                for(var i in resData){
                    bingProcessName.push(resData[i].name)
                }
                echartBing();
            } else {
                layer.msg("查询失败");
            }
        }
    });


    // 柱形图
    $.ajax({
        url: "<%=request.getContextPath() %>/AccessMonitor/processAndeqi",
        type: "GET",
        async: true,
        cache: false,
        contentType: "text/json",
        success: function (result) {
            if (result) {
                var data = result.data;
                for(var i in data){
                    processName.push(data[i].name)
                    eqiByProcess.push(data[i].value);
                }
                echartZhu();
            } else {
                layer.msg("查询失败");
            }
        }
    });

    // 堆叠图
    $.ajax({
        url: "<%=request.getContextPath() %>/AccessMonitor/queryProcessAndFactory",
        type: "GET",
        async: true,
        cache: false,
        contentType: "text/json",
        success: function (result) {
            if (result) {
                var data = result.data;
                duiProcessName = data.processName;
               factoryName = data.factoryName;
               var list = data.dataTotalList;
               for(var i in processName){
                   seriesData.push({
                       name: processName[i],
                       type: "bar",//柱状图
                       stack:"Search Engine",
                       emphasis: {//折线图的高亮状态。
                           focus: "series",//聚焦当前高亮的数据所在的系列的所有图形。
                       },
                       data: list[i]
                   })
               }
                echartDui();
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


    //指定图表配置项和数据
    function echartZhu(){
        var optionchartZhu = {
            tooltip: {},
            xAxis: {
                data: processName
            },
            yAxis: {
                type: 'value'
            },
            series: [{
                name: '数量',
                type: 'bar', //柱状
                data: eqiByProcess,
                itemStyle: {
                    normal: { //柱子颜色
                        color: 'blue'
                    }
                }}]
        };
        chartZhu7.setOption(optionchartZhu, true);
    }
    function echartDui(){
        var optionchartDui = {
            tooltip: {},
            legend: {
                data: duiProcessName
            },
            xAxis: {
                data: factoryName
            },
            yAxis: {},
            series: seriesData
        };
        chartZhu8.setOption(optionchartDui, true);
    }

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
                data: bingProcessName
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
            field: "equipmentExchangeTime",
            title: "操作时间",
            align: "center",
            width: 180,
            templet: function (d) {
                return util.toDateString(d.equipmentExchangeTime);
            },
        }, {
            field: "equipmentId",
            title: "设备资源号",
            align: "center",
            minWidth: 100,
        }, {
            field: "aPPId",
            title: "APPID",
            align: "center",
            minWidth: 50,
        },{
            field: "equipmentName",
            title: "设备名称",
            align: "center",
            minWidth: 50,
        },{
            field: "operationType",
            title: "操作类型",
            align: "center",
            minWidth: 90,
            templet: function (d) {
                return layui.admin.getDictText("OPERATE_TYPE", d.operationType);
            }
        },{
            field: "operationContent",
            title: "操作内容",
            align: "center",
            minWidth: 100,
        },{
            field: "operateName",
            title: "操作人员",
            align: "center",
            width: 100,
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
            width: 180,
            templet: function (d) {
                return util.toDateString(d.operationTime);
            },
        }, {
            field: "operationContent",
            title: "操作内容",
            align: "center",
            width: 200,
        }, {
            field: "operationResult",
            title: "操作结果",
            align: "center",
            minWidth: 200,
            templet: function (d) {
                return layui.admin.getDictText("OPERATE_RESULT", d.result);
            }
        }, {
            field: "operateName",
            title: "操作人",
            align: "center",
            minWidth: 208,
        }]]
    });
</script>
</body>
</html>

