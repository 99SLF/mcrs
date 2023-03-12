<!--
- Author(s): 李伟杰
- Date: 2022-12-05 14:08:11
- Description:
-->
<%@page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>RFID报表</title>
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
        <div class="layui-form layuiadmin-card-header-auto" lay-filter="layuiadmin-rfid-form" id="layuiadmin-rfid-form">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">载具号：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="epcId" autocomplete="off" />
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">RFID读写器：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="reader" autocomplete="off" />
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">RSSI：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="rssi" autocomplete="off" />
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">更新时间：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="UPDATED_TIME" id="UPDATED_TIME" placeholder="请选择更新日期" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
                <div class="layui-inline layui-hide">
                    <button id="LAY-app-rfid-search" class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-rfid-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </script>
    <div class="layui-card-body">
        <table id="LAY-app-rfid-list" lay-filter="LAY-app-rfid-list"></table>
    </div>
</div>
<script src="<%=request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
    layui.config({
        base: "<%=request.getContextPath() %>/"
    });
</script>
<script src="<%=request.getContextPath() %>/std/dist/index.all.js"></script>
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
    var funName = "rfid_list";
    // 高级查询参数
    var advancedFormData = {};
    // 焦点名称
    var focusName = null;

    // 监听搜索
    form.on("submit(LAY-app-rfid-search)", function(data) {
        var startTime = "";
        var endTime = "";
        var field = data.field;
        if(field.UPDATED_TIME != null){
            startTime = field.UPDATED_TIME.substring(0,field.UPDATED_TIME.indexOf("~"));
            endTime = field.UPDATED_TIME.substring(field.UPDATED_TIME.indexOf("~")+1);
        }
        field["startTime"]=startTime
        field["endTime"]=endTime
        reloadData(field);
        var formData = {
            epcId: field.epcId,
            reader: field.reader,
            rssi: field.rssi,
            UPDATED_TIME:field.UPDATED_TIME
        };
        form.val("layuiadmin-rfid-form", formData);
        advancedFormData = $.extend(advancedFormData, formData);
    });

    function reloadData(formData) {
        table.reload("LAY-app-rfid-list-reload", {
            where: formData
        });
        formReder();
        if (focusName) {
            $("input[name=" + focusName + "]").focus();
        }
    }

    function setFormData(data) {
        advancedFormData = data;
        reloadData(data);
        form.val("layuiadmin-rfid-form", {
            epcId: data.epcId,
            reader: data.reader,
            rssi: data.rssi,
            UPDATED_TIME:data.UPDATED_TIME
        });
    }

    function getFullSize() {
        var header = $(".layui-card-header");
        var cardbody = $(".layui-card-body");
        return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + 1;
    }

    // 监听按钮点击事件
    var active = {
        search: function() {
            var submit = $("#LAY-app-rfid-search");
            submit.click();
            return false;
        },
        query: function() {
            //高级查询页面
            var url = "<%=request.getContextPath() %>/report/rfid_form_query.jsp";
            //弹窗
            admin.popupRight({
                type: 2,
                content: [url, "yes"],
                btn: ["查询", "重置", "取消"],
                success: function(layero, index) {
                    var dataJson = {
                        win : window,
                        data: advancedFormData
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function(index, layero) {
                    var submit = layero.find("iframe").contents().find("#LAY-app-rfid-search-advanced");
                    submit.click();
                    top.layer.close(index);
                },
                btn2: function(index, layero) {
                    layero.find("iframe")[0].contentWindow.reset();
                }
            });
        }
    };

    // 右侧表头按钮事件监听
    table.on("toolbar(LAY-app-rfid-list)", function(obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    // 表格排序
    table.on("sort(LAY-app-rfid-list)", function(obj) {
        table.reload("LAY-app-rfid-list-reload", {
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
        success: function(result) {
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
        elem: "#LAY-app-rfid-list",
        id: "LAY-app-rfid-list-reload",
        url: "<%= request.getContextPath() %>/report/rfidReadRa/query",
        method: "get",
        height: "full-" + getFullSize(),
        page: true,
        limit: 100,
        toolbar: "#toolbar",
        defaultToolbar: [{
            title: "查询",
            layEvent: "search",
            icon: "layui-icon layui-icon-search layuiadmin-button-btn",
        }, {
            title: "高级查询",
            layEvent: "query",
            icon: "icon iconfont icon-gaojichaxun",
        }, "filter"],
        colHideChange: function(col, checked) {
            var field = col.field;
            var hidden = col.hide;
            $.ajax({
                url: "<%=request.getContextPath() %>/cols/filter/set?funName=" + funName + "&field=" + field + "&hidden=" + hidden,
                type: "GET",
                cache: false,
                contentType: "text/json",
                success: function(result) {
                    if (result) {
                    } else{
                        layer.msg("列筛选失败");
                    }
                }
            });
        },
        limits: [100, 150, 200, 300],
        parseData: function (res) {
            return {
                code: res.code,
                msg: res.msg,
                count: res.total,
                data: res.data
            };
        },
        //设置表头。值是一个二维数组。方法渲染方式必填
        cols: [[{
            title: "序号",
            type: "numbers"
        }, {
            field: "epcId",
            title: "载具号",
            align: "center",
            // sort: true,
            hide: isHidden("epcId"),
            minWidth: 150
        }, {
            //field:设定字段名。字段名的设定非常重要，且是表格数据列的唯一标识;title:设定标题名称
            field: "readNum",
            title: "读取次数",
            align: "center",
            minWidth: 120,
            hide: isHidden("readNum")
        }, {
            field: "reader",
            title: "RFID读写器",
            align: "center",
            hide: isHidden("reader"),
            minWidth: 120

        }, {
            field: "antenna",
            title: "RFID天线",
            align: "center",
            hide: isHidden("antenna"),
            minWidth: 120
        }, {
            field: "dBm",
            title: "天线增益",
            align: "center",
            hide: isHidden("dBm"),
            minWidth: 120
        }, {
            field: "rssi",
            title: "RSSI",
            align: "center",
            hide: isHidden("rssi"),
            minWidth: 120
        }, {
            field: "updatedTime",
            title: "更新时间",
            align: "center",
            hide: isHidden("updatedTime"),
            minWidth: 200,
            templet:function(d){
                return util.toDateString(d.updatedTime,'yyyy-MM-dd HH:mm:ss');
            }
        }]]
    });

    formReder();

    function formReder() {
        laydate.render({
            elem: "#UPDATED_TIME",
            type: "datetime",
            trigger: "click",
            range:"~"
            // ,done: function(value, date, endDate){
            // 	debugger;
            // 	console.log(value); //得到日期生成的值，如：2017-08-18
            // 	console.log(date); //得到日期时间对象：{year: 2017, month: 8, date: 18, hours: 0, minutes: 0, seconds: 0}
            // 	console.log(endDate); //得结束的日期时间对象，开启范围选择（range: true）才会返回。对象成员同上。
            // }
        });
        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-rfid-search");
                submit.click();
                return false;
            }
        });
    }

    $(window).resize(function() {
        table.reload("LAY-app-rfid-list-reload", {
            height: "full-" + getFullSize()
        });
    });

    $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function() {
        if ($(this).attr("data-field") === "0") return;
        $(this).siblings().eq(0).find("i").click();
    });
</script>
</body>
</html>