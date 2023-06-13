<!--
- Author(s): 李伟杰
- Date: 2023-4-11 14:12:11
- Description:
-->
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>监控异常历史记录</title>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/std/dist/style/admin.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath() %>/std/dist/style/custom.css?v=1.0.0">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/iconfont/iconfont.css">
    <style>
        .layui-card {
            margin-bottom: 0px
        }

        .layui-layer-adminRight {
            top: 0px !important;
            bottom: 0;
            box-shadow: 1px 1px 10px rgba(0, 0, 0, .1);
            border-radius: 0;
            overflow: auto
        }

        .layui-form-item .layui-inline {
            margin-bottom: 0px !important;
            margin-right: 0px !important;
        }

        .layui-form-label {
            width: 120px !important;
            padding: 5px 0px !important;
        }

        .layui-form-item .layui-input-inline {
            float: left;
            width: 150px;
            margin-right: 10px;
        }

        .layui-input {
            height: 30px !important;
        }
    </style>
</head>
<body>
<div class="layui-card">
    <script type="text/html" id="toolbar">
        <div class="layui-form layuiadmin-card-header-auto"
             lay-filter="layuiadmin-device_statusAlarm-form" id="layuiadmin-device_statusAlarm-form">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">设备资源号：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="equipmentId" autocomplete="off">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">终端名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="deviceName" autocomplete="off">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">预警类型：</label>
                    <div class="layui-input-inline">
                        <select name="warnType" id="warnType" lay-filter="warnType"
                                type="select">
                            <option value="">请选择预警类型</option>
                            <option value="101">硬件预警</option>
                            <option value="102">行为预警 </option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">预警等级：</label>
                    <div class="layui-input-inline">
                        <select name="warnGrade" id="warnGrade" lay-filter="warnGrade"
                                type="select">
                            <option value="">请选择预警等级</option>
                            <option value="info">info</option>
                            <option value="warn">warn</option>
                            <option value="error">error</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">发生时间：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="CREATED_TIME" id="CREATED_TIME" placeholder="请选择发生日期" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
                <div class="layui-inline layui-hide">
                    <button id="LAY-app-device_statusAlarm-search" class="layui-btn layuiadmin-btn-list" lay-submit
                            lay-filter="LAY-app-device_statusAlarm-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </script>
    <div class="layui-card-body">
        <table id="LAY-app-device_statusAlarm-list" lay-filter="LAY-app-device_statusAlarm-list"></table>
    </div>
</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
    layui.config({
        base: "<%=request.getContextPath()%>/"
    });
</script>
<%--字典--%>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script type="text/javascript">
    var layer = layui.layer;
    var table = layui.table;
    var form = layui.form;
    var $ = layui.jquery;

    var util = layui.util;
    var admin = layui.admin;
    var view = layui.view;
    var laydate = layui.laydate;

    // 过滤字段
    var hiddenFields = [];
    // 功能名
    var funName = "device_statusAlarm_list";
    // 高级查询参数
    var advancedFormData = {};
    // 焦点名称
    var focusName = null;


    // 监听搜索
    form.on("submit(LAY-app-device_statusAlarm-search)", function (data) {
        var startTime = "";
        var endTime = "";
        var field = data.field;
        if(field.CREATED_TIME != null){
            startTime = field.CREATED_TIME.substring(0,field.CREATED_TIME.indexOf("~"));
            endTime = field.CREATED_TIME.substring(field.CREATED_TIME.indexOf("~")+1);
        }
        field["startTime"]=startTime
        field["endTime"]=endTime
        reloadData(field);
        var formData = {
            equipmentId: field.equipmentId,
            deviceName: field.deviceName,
            warnType: field.warnType,
            warnGrade: field.warnGrade,
            CREATED_TIME:field.CREATED_TIME
        };
        form.val("layuiadmin-device_statusAlarm-form", formData);
        advancedFormData = $.extend(advancedFormData, formData);
    });


    function reloadData(formData) {
        //读取表格数据 表格id
        table.reload("LAY-app-device_statusAlarm-list-reload", {
            where: formData,
            page: {
                curr: 1
            }
        });
        formReder();
        if (focusName) {
            $("input[name=" + focusName + "]").focus();
        }
    }

    function setFormData(data) {
        advancedFormData = data;
        reloadData(data);
        form.val("layuiadmin-device_statusAlarm-form", {
            equipmentId: data.equipmentId,
            deviceName: data.deviceName,
            warnType: data.warnType,
            warnGrade: data.warnGrade,
            CREATED_TIME:data.CREATED_TIME
        });
    }

    function getFullSize() {
        var header = $(".layui-card-header");
        var cardbody = $(".layui-card-body");
        return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + 1;
    }

    // 监听按钮点击事件
    var active = {
        search: function () {
            var submit = $("#LAY-app-device_statusAlarm-search");
            submit.click();
            return false;
        },
        query: function () {
            var url = "<%=request.getContextPath() %>/monitor/device_statusAlarm_form_query.jsp";
            admin.popupRight({
                type: 2,
                content: [url, "yes"],
                btn: ["查询", "重置", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        win: window,
                        data: advancedFormData
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    var submit = layero.find("iframe").contents().find("#LAY-app-device_statusAlarm-search-advanced");
                    submit.click();
                    top.layer.close(index);
                },
                btn2: function (index, layero) {
                    layero.find("iframe")[0].contentWindow.reset();
                }
            });
        }
    };

    // 右侧表头按钮事件监听
    table.on("toolbar(LAY-app-device_statusAlarm-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    // 表格排序
    table.on("sort(LAY-app-device_statusAlarm-list)", function (obj) {
        table.reload("LAY-app-device_statusAlarm-list-reload", {
            initSort: obj,
            where: {
                field: obj.field,
                order: obj.type
            }
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
                hiddenFields = result.data;
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


    table.render({
        elem: "#LAY-app-device_statusAlarm-list",
        id: "LAY-app-device_statusAlarm-list-reload",
        url: "<%= request.getContextPath() %>/HistoryAlarm/historyAlarm/query",
        method: "GET",
        height: "full-" + getFullSize(),
        page: true,
        limit: 30,
        toolbar: "#toolbar",
        defaultToolbar: [{
            title: "查询",
            layEvent: "search",
            icon: "layui-icon layui-icon-search layuiadmin-button-btn",
        }, "filter"],
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
        limits: [30, 50, 70, 100],
        parseData: function (res) {
            return {
                code: res.code,
                msg: res.msg,
                count: res.total,
                data: res.data
            };
        },
        //设置表头。值是一个二维数组。方法渲染方式必填
        //设置表头。值是一个二维数组。方法渲染方式必填
        cols: [[{
            type: "checkbox",
        }, {
            title: "序号",
            type: "numbers",
        }, {
            field: "equipmentId",
            title: "设备资源号",
            align: "center",
            // sort: true,
            hide: isHidden("equipmentId"),
            minWidth: 150
        },{
            //field:设定字段名。字段名的设定非常重要，且是表格数据列的唯一标识;title:设定标题名称
            field: "appId",
            title: "APPID",
            align: "center",
            hide: isHidden("appId"),
            minWidth: 245
        }, {
            //field:设定字段名。字段名的设定非常重要，且是表格数据列的唯一标识;title:设定标题名称
            field: "deviceName",
            title: "终端名称",
            align: "center",
            hide: isHidden("deviceName"),
            minWidth: 150
        }, {
            field: "warnType",
            title: "预警类型",
            align: "center",
            hide: isHidden("warnType"),
            minWidth: 150,
            templet: function (d) {
                var warnType = layui.admin.getDictText("WRANING_TYPE", d.warnType);
                if (d.warnType == null) {
                    return "";
                }else {
                    return  warnType;
                }
            }
        }, {
            field: "warnGrade",
            title: "预警等级",
            align: "center",
            hide: isHidden("warnGrade"),
            minWidth: 150,
            templet: function (d) {
                var warnGrade = d.warnGrade;
                if (d.warnGrade == null) {
                    return "";
                } else if (d.warnGrade == "info") {
                    return '<span class="layui-badge-dot layui-bg-green"></span>' + "  " + '<span style="color:green">' + warnGrade + '</span>';
                } else if (d.warnGrade == "warn") {
                    return '<span class="layui-badge-dot layui-bg-orange"></span>' + "  " + '<span style="color:orange">' + warnGrade + '</span>';
                } else {
                    return '<span class="layui-badge-dot"></span>' + "  " + '<span style="color:red">' + warnGrade + '</span>';
                }
            }
        }, {
            field: "warningContent",
            title: "预警内容",
            align: "center",
            hide: isHidden("warningContent"),
            minWidth: 150,
            // ,templet: function (d) {
            //     // var warningContent = layui.admin.getDictText("WARNING_CONTENT", d.warningContent);
            //     if (d.warningContent == "正常") {
            //         return '<span style="color:green">' + "正常" + '</span>';
            //     }else {
            //         return '<span style="color:red">' + d.warningContent + '</span>';
            //     }
            // }
            templet: function(d) {
                d.warningContent = d.warningContent == null ? "" : d.warningContent;
                var html = '<div><a rel="nofollow" href="javascript:void(0);" style="color:#1eddff" lay-event="showWarningContent">' + d.warningContent+ '</a></div>';
                return html;
            }
        }, {
            field: "occurrenceTime",
            title: "发生时间",
            align: "center",
            hide: isHidden("occurrenceTime"),
            minWidth: 200,
            templet: function (d) {
                return d.occurrenceTime==null?"":util.toDateString(d.occurrenceTime, 'yyyy-MM-dd HH:mm:ss');
            }

        }]]
    });

    table.on( 'tool(LAY-app-device_statusAlarm-list)', function ( obj ) {
        var data = obj.data;
        if ( obj.event == "showWarningContent") {
               var title = "预警内容";
               var dataContent = obj.data.warningContent;
            top.layer.open( {
                type: 2,
                title: title,
                shadeClose: true,
                content: "<%= request.getContextPath() %>/monitor/textWindows.jsp",
                resize: true,
                maxmin: true,
                btn: [ "关闭" ],
                success: function ( layero, index ) {
                    //找到当前弹出层的iframe元素
                    var iframe = layui.$( layero )
                        .find( 'iframe' );
                    //设定iframe的高度为当前iframe内body的高度
                    iframe.css( 'height', Number( iframe[ 0 ].contentDocument.body.offsetHeight ) + 30 );
                    iframe.css( 'width', "800px" );
                    //重新调整弹出层的位置，保证弹出层在当前屏幕的中间位置
                    $( layero ).css( 'top', ( window.innerHeight - iframe[ 0 ].offsetHeight ) / 2 );
                    $( layero ).css( 'left', ( window.innerWidth - iframe[ 0 ].offsetWidth ) / 2 );
                    var dataJson = {
                        data: dataContent,
                        win: window
                    };
                    layero.find( "iframe" )[ 0 ].contentWindow.SetData( dataJson );
                },
            } );
        }
    } );

    formReder();

    function formReder() {
        laydate.render({
            elem: "#CREATED_TIME",
            type: "datetime",
            trigger: "click",
            range:"~"
        });
        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-device_statusAlarm-search");
                submit.click();
                return false;
            }
        });

        //软件类型下拉框监听事件
        form.on("select(warnType)", function (data) {
            var submit = $("#LAY-app-device_statusAlarm-search");
            submit.click();
        });

        form.on("select(warnGrade)", function (data) {
            var submit = $("#LAY-app-device_statusAlarm-search");
            submit.click();
        });

    }


    $(window).resize(function () {
        table.reload("LAY-app-device_statusAlarm-list-reload", {
            height: "full-" + getFullSize()
        });
    });

    $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function () {
        if ($(this).attr("data-field") === "0") return;
        $(this).siblings().eq(0).find("i").click();
    });
</script>
</body>
</html>