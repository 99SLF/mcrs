<%@ page import="com.zimax.cap.datacontext.DataContextManager" %>
<%@ page import="com.zimax.cap.party.IUserObject" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰
  - Date: 2023-1-10 10:41:33
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>预警规则查看</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/common/layui/css/layui.css">
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <div class="layui-fluid">
        <div class="layui-card">
            <div class="layui-form-item layui-row layui-col-space10">
                <%--	需要隐藏主键	--%>
                <input type="hidden" name="alarmRuleInt" value="default">
                <div class="layui-col-sm6">
                    <label class="layui-form-label"><span style="color:red">*</span>预警规则编码:</label>
                    <div class="layui-input-block">
                        <input id="alarmRuleId" type="text" name="alarmRuleId" lay-verify="required"
                               placeholder="预警规则编码(必填)" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
                <div class="layui-col-sm6">
                    <label class="layui-form-label">预警规则标题:</label>
                    <div class="layui-input-block">
                        <input id="alarmRuleTitle" type="text" name="alarmRuleTitle" lay-verify="required"
                               placeholder="预警规则标题" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
            </div>


            <div class="layui-form-item layui-row layui-col-space10">

                <div class="layui-col-sm6">
                    <label class="layui-form-label"><span style="color:red">*</span>监控层级:</label>
                    <div class="layui-input-block">
                        <select name="monitorLevel" id="monitorLevel" lay-filter="required" type="select">
                            <option value="1级">1级</option>
                            <option value="2级">2级</option>
                            <option value="3级">3级</option>
                            <option value="4级">4级</option>
                            <option value="5级">5级</option>
                        </select>
                    </div>
                </div>
                <div class="layui-col-sm6">
                    <label class="layui-form-label"><span style="color:red">*</span>是否启用：</label>
                    <div class="layui-input-block">
                        <select name="enable" id="enable" lay-filter="required" type="select">
                            <option value="on">是</option>
                            <option value="off">否</option>
                        </select>
                    </div>
                </div>
            </div>

            <div class="layui-form-item layui-row layui-col-space10">
                <div class="layui-col-sm6">
                    <label class="layui-form-label"><span style="color:red">*</span>预警事件编码:</label>
                    <div class="layui-input-block">
                        <input id="alarmEventInt" name="alarmEventInt" type="hidden"/>
                        <input type="text" class="layui-input" name="alarmEventId" id="alarmEventId"
                               lay-verify="required"
                               autocomplete="off" placeholder="" readonly>
                        <button type="button" class="layui-btn layui-btn-sm layui-btn-primary" id="onButtonAlarmEvent"
                                style="position:absolute;top:0px;right:0px;height:37px"><i
                                class="layui-icon layui-icon-more"></i></button>
                    </div>
                </div>
<%--                <div class="layui-col-sm6">--%>
<%--                    <label class="layui-form-label"><span style="color:red">*</span>监控对象:</label>--%>
<%--                    <div class="layui-input-block">--%>
<%--                        <input type="text" class="layui-input" name="monitorObject" id="monitorObject"--%>
<%--                               lay-verify=""--%>
<%--                               autocomplete="off" placeholder="" readonly>--%>
<%--                        <button type="button" class="layui-btn layui-btn-sm layui-btn-primary"--%>
<%--                                id="onButtonMonitorObject"--%>
<%--                                style="position:absolute;top:0px;right:0px;height:37px"><i--%>
<%--                                class="layui-icon layui-icon-more"></i></button>--%>
<%--                    </div>--%>
<%--                </div>--%>

            </div>

            <div class="layui-form-item layui-row layui-col-space12">

                <div class="layui-col-sm12">
                    <label class="layui-form-label">规则描述:</label>
                    <div class="layui-input-block">
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="alarmRuleDescribe"
                      id="alarmRuleDescribe" autocomplete="off"
                      class="layui-input" lay-verify="alarmEventContent" readonly></textarea>
                    </div>
                </div>
            </div>

            <div class="layui-form-item layui-row layui-col-space10">
                <div class="layui-col-sm6">
                    <label class="layui-form-label">制单人:</label>
                    <div class="layui-input-block">
                        <input id="ruleMakeFormPeople" type="text" name="ruleMakeFormPeople" lay-verify="required"
                               placeholder="" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
                <div class="layui-col-sm6">
                    <label class="layui-form-label">制单时间:</label>
                    <div class="layui-input-block">
                        <input id="ruleMakeFormTime" type="text" name="ruleMakeFormTime" lay-verify="required"
                               placeholder="预警规则标题" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
            </div>


            <div class="layui-form-item layui-row layui-col-space10">
                <div class="layui-col-sm6">
                    <label class="layui-form-label">修改人:</label>
                    <div class="layui-input-block">
                        <input id="ruleUpdatePeople" type="text" name="ruleUpdatePeople" lay-verify="required"
                               placeholder="" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
                <div class="layui-col-sm6">
                    <label class="layui-form-label">修改时间:</label>
                    <div class="layui-input-block">
                        <input id="ruleUpdateTime" type="text" name="ruleUpdateTime" lay-verify="required"
                               placeholder="预警规则标题" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
            </div>

            <div class="layui-form-item layui-hide">
                <input type="button" lay-submit lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit"
                       value="确认修改">
            </div>

            <div class="layui-card-body">
                <h2>监控对象</h2>
                <div class="layui-toolbar" id="toolbar" hidden="true">
                    <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add" id="monitor"><i
                            class="layui-icon layui-icon-add-circle-fine"></i>监控对象
                    </button>
                </div>


                <table id="LAY-app-alarmRule-list" lay-filter="LAY-app-alarmRule-list"></table>

                <script type="text/html" id="table-alarmRule-list">
                    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del" id="delete"><i
                            class="layui-icon layui-icon-delete"></i>删除</a>
                </script>
            </div>
        </div>
    </div>
</div>

<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
    layui.config({
        base: "<%=request.getContextPath()%>/"
    });
</script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>

<script type="text/javascript">
    var layer = layui.layer;
    var form = layui.form;
    var laydate = layui.laydate;
    var $ = layui.jquery;
    var isExist = false;
    var submit = false;
    var win = null;
    var table = layui.table;
    var util = layui.util;

    //全局参数
    var req_data;

    var tableDates;
    //功能名
    var funName = "list";

    var hiddenFields = [];

    function SetData(data) {
        win = data.win ? data.win : window;
    }
    //禁用规则等级下拉选择框
    layui.use('form', function(){
        var form = layui.form;
        $("#monitorLevel").attr("disabled","disabled");
        form.render('select');
    });

    //禁用是否启用下拉选择框
    layui.use('form', function(){
        var form = layui.form;
        $("#enable").attr("disabled","disabled");
        form.render('select');
    });

    //禁用选择设备类型入口
    $('#onButtonAlarmEvent').addClass("layui-btn-disabled").attr("disabled",true);

    //禁用选择监控对象按钮
    $('#monitor').addClass("layui-btn-disabled").attr("disabled",true);

    //禁用选择设备类型入口
    $('#delete').addClass("layui-btn-disabled").attr("disabled",true);


    function SetData(data) {
        win = data.win ? data.win : window;
        var data = data.data;
        debugger;
        form.val("layuiadmin-app-form-list", {
            "alarmRuleInt": data.alarmRuleInt,
            "alarmRuleId": data.alarmRuleId,
            "alarmRuleTitle": data.alarmRuleTitle,
            "enable": data.enable,
            "monitorLevel": data.monitorLevel,
            "alarmEventId": data.alarmEventId,
            "alarmEventInt": data.alarmEventInt,
            "alarmRuleDescribe": data.alarmRuleDescribe,
            "ruleMakeFormPeople": data.ruleMakeFormPeople,
            "ruleMakeFormTime": data.ruleMakeFormTime,
            "ruleUpdatePeople": data.ruleUpdatePeople,
            "ruleUpdateTime": data.ruleUpdateTime,

        });
        $.ajax({
            url: "<%=request.getContextPath() %>/warn/alarmRule/MonitorEquipment/get?alarmRuleInt=" + data.alarmRuleInt,
            type: "GET",
            async: false,
            cache: false,
            contentType: "text/json",
            success: function (result) {
                debugger;
                if (result) {
                    table.reload('LAY-app-alarmRule-list-reload', {
                        data: result.data.monitorEquipmentVoList
                    });
                } else {
                    layer.msg("查询失败");
                }
            }
        });
        form.render();
    }

    //选择预警事件编码入口
    $("#onButtonAlarmEvent").click(function () {
        top.layer.open({
            type: 2,
            title: "选择预警事件编码",
            area: ["850px", "470px"],
            btn: ["确定", "取消"],
            content: "<%= request.getContextPath() %>/warn/alarmRule/alarm_event.jsp",
            yes: function (index, layero) {
                var data = layero.find('iframe')[0].contentWindow.getData();
                $("#alarmEventInt").val(data.alarmEventInt);
                $("#alarmEventId").val(data.alarmEventId);
                top.layer.close(index);
            }
        });
    });

    //选择监控对象入口
    <%--$("#onButtonMonitorObject").click(function () {--%>
    <%--    top.layer.open({--%>
    <%--        type: 2,--%>
    <%--        title: "选择监控对象",--%>
    <%--        area: ["850px", "470px"],--%>
    <%--        btn: ["确定", "取消"],--%>
    <%--        content: "<%= request.getContextPath() %>/equipment/device/equipment_select.jsp",--%>
    <%--        yes: function (index, layero) {--%>
    <%--            var data = layero.find('iframe')[0].contentWindow.getData();--%>
    <%--            $("#alarmEventInt").val(data.alarmEventInt);--%>
    <%--            $("#alarmEventId").val(data.alarmEventId);--%>
    <%--            top.layer.close(index);--%>
    <%--        }--%>
    <%--    });--%>
    <%--});--%>


    // //判断字符
    // form.verify({
    // 	username: function(value, item) {
    // 		if (value.length > 10) {
    // 			return "学生名不能超过10字";
    // 		}
    // 	},
    // 	age: function(value, item) {
    // 		if (value <= 0||value >=150) {
    // 			return "请输入正确的年龄";
    // 		}
    // 	},
    // 	teachr: function(value, item) {
    // 		if (value.length > 10) {
    // 			return "教师名不能超过10字";
    // 		}
    // 	}
    // });

    form.render();
    // //日期
    // laydate.render({
    // 	elem: '#invaldate',
    // 	format: 'yyyy-MM-dd',
    // 	//解决时间选择器一闪而过的情况
    // 	trigger: 'click',
    // });
    //
    // var startDate = laydate.render({
    // 	elem: '#star_time',
    // 	//设置日期的类型
    // 	type: 'date',
    // 	trigger:'click',
    // 	done: function(value, date) {
    // 		if (value != "") {
    // 			date.month = date.month - 1;
    // 			date.date = date.date + 1;
    // 			endDate.config.min = date;
    // 		} else {
    // 			endDate.config.min = startDate.config.min;
    // 		}
    // 	},
    // });
    //
    // var endDate = laydate.render({
    // 	//绑定的控件名称
    // 	elem: '#end_time',
    // 	//设置日期的类型
    // 	type: 'date',
    // 	//theme: '#2c78da',
    // 	trigger: 'click',
    // 	done: function(value, date) {
    // 		if (value != "") {
    // 			date.month = date.month - 1;
    // 			date.date = date.date - 1;
    // 			startDate.config.max = date;
    // 		} else {
    // 			startDate.config.max = endDate.config.max;
    // 		}
    // 	}
    // });

    //监听提交
    form.on("submit(layuiadmin-app-form-edit)", function (data) {
        var index = parent.layer.getFrameIndex(window.name);
        win.layui.table.reload("LAY-app-alarmRule-list-reload");
        top.layer.close(index);
        return false;
    });
    table.on('sort(LAY-app-alarmRule-list)', function (obj) {
        table.reload('LAY-app-alarmRule-list-reload', {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
    });

    //左侧表头按钮事件监听
    table.on("toolbar(LAY-app-alarmRule-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    //表格排序
    table.on("sort(LAY-app-alarmRule-list)", function (obj) {
        table.reload("LAY-app-alarmRule-list-reload", {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
    });

    function getFullSize() {
        var fluid = $(".layui-fluid");
        var header = $(".layui-card-header");
        var cardbody = $(".layui-card-body");
        return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + (fluid.outerHeight(true) - fluid.height()) + 2;
    }


    $(window).resize(function () {
        table.reload("LAY-app-alarmRule-list-reload", {
            height: "full-" + getFullSize()
        });
    });

    // 查询过滤字段
    $.ajax({
        url: "<%=request.getContextPath() %>/cols/filter/query/" + funName,
        type: "GET",
        async: false,
        cache: false,
        contentType: "text/json",
        success: function (result) {
            if (result) {
                hiddenFields = result.data
            } else {
                layer.msg("查询失败");
            }
        }
    });

    //判断是否隐藏函数
    function isHidden(field) {
        for (var i = 0; i < hiddenFields.length; i++) {
            if (hiddenFields[i].field == field) {
                return true;
            }
        }
        return false;
    }

    var active = {
        //设备新建
        add: function () {
            top.layer.open({
                type: 2,
                title: "选择监控对象",
                content: "<%= request.getContextPath() %>/equipment/equipment/equipment_rule_select.jsp",
                area: ["1000px", "560px"],
                resize: false,
                btn: ["确定", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        win: window,
                    };
                    //layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {

                    var tableData = layero.find("iframe")[0].contentWindow.GetData();
                    tableDates = tableData;
                    debugger;
                    table.reload("LAY-app-alarmRule-list-reload", {
                        data: tableData
                    });
                    top.layer.close(index);


                }
            });
        },
    };

    table.render({
        elem: "#LAY-app-alarmRule-list",
        id: "LAY-app-alarmRule-list-reload",
        height: "full-" + getFullSize(),
        data: [],
        toolbar: "#toolbar",
        defaultToolbar: ["filter"],
        colHideChange: function (col, checked) {
            var field = col.field;
            var hidden = col.hide;
            $.ajax({
                url: "<%=request.getContextPath() %>/cols/filter/set?funName=" + funName + "&field=" + field + "&hidden=" + hidden,
                type: "GET",
                cache: false,
                contentType: "text/json",
                success: function (result) {
                    if (result) {
                    } else {
                        layer.msg("列筛选失败");
                    }
                }
            });
        },
        parseData: function (res) {
            debugger;
            return {
                code: res.code,
                msg: res.msg,
                count: res.total,
                data: res.data
            };
        },
        cols: [[{
            type: "checkbox"
        }, {
            title: "序号",
            type: "numbers"
        }, {
            field: "equipmentId",
            title: "设备资源号",
            align: "center",
            minWidth: 120,
            hide: isHidden("equipmentId")
        }, {
            field: "equipmentName",
            title: "设备名称",
            align: "center",
            minWidth: 120,
            hide: isHidden("equipmentName")
        }, {
            field: "equipmentInstallLocation",
            title: "安装位置",
            align: "center",
            minWidth: 120,
            hide: isHidden("equipmentInstallLocation")
        }, {
            field: "accPointResName",
            title: "接入点名称",
            align: "center",
            minWidth: 100,
            hide: isHidden("accPointResName")
        }, {
            field: "matrixCode",
            title: "基地代码",
            align: "center",
            minWidth: 150,
            hide: isHidden("matrixCode")
        }, {
            field: "factoryCode",
            title: "工厂代码",
            align: "center",
            minWidth: 150,
            hide: isHidden("factoryCode")
        }, {
            field: "factoryCode",
            title: "工厂名称",
            align: "center",
            minWidth: 120,
            hide: isHidden("factoryCode")
        }, {
            field: "processName",
            title: "使用工序",
            align: "center",
            minWidth: 120,
            hide: isHidden("processName")
        }, {
            field: "ruleMakeFormTime",
            title: "工位代码",
            align: "center",
            minWidth: 100,
            hide: isHidden("ruleMakeFormTime")
        }, {
            title: "操作",
            align: "center",
            fixed: "right",
            width: 100,
            toolbar: "#table-alarmRule-list"
        }]]
    });
    table.on("tool(LAY-app-alarmRule-list)", function (e) {
        var date
        if (obj.event == "del") {
            var Data = table.cache["LAY-app-alarmRule-list"];
            if (obj.tr.data("index") >= -1) {
                Data.splice(obj.tr.data("index"), 1);	//根据索引删除当前行
                table.reload('LAY-app-alarmRule-list', {
                    data: Data
                });
            }
        }
    });

    function setMonitorEquipment(monitorEquipmentList) {
        var rfidGroupList = table.cache['LAY-app-alarmRule-list-reload'];
        rfidGroupList.push(monitorEquipmentList);
        table.reload('LAY-app-alarmRule-list-reload', {
            data: monitorEquipmentList
        });
    }
</script>
</body>
</html>