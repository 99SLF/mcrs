<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>RFID点位配置</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/custom.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/iconfont/iconfont.css">
    <style>
        .layui-form-label {
            width: 140px;
        }

        .layui-input-block {
            margin-left: 150px;
            min-height: 36px
        }
    </style>
</head>
<body style="background-color: white;">
<div class="layui-fluid">
    <div class="layui-card">
        <h2>参数信息</h2>
        <div class="layui-form" lay-filter="point-rfid-add" id="point-rfid-add" style="padding:20px;">
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm4">
                    <label class="layui-form-label"><span style="color:red">*</span>RFID-ID：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="rfidNum" id="rfidNum"
                               autocomplete="off" placeholder="请输入RFID编号" lay-verify="required">
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label"><span style="color:red">*</span>连接IP：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="ipAddr" id="ipAddr"
                               autocomplete="off" lay-verify="required">
                    </div>
                </div>
                <div class="layui-col-sm4">
                    <label class="layui-form-label"><span style="color:red">*</span>端口号：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="port" id="port"
                               autocomplete="off" lay-verify="required">
                    </div>
                </div>
            </div>

            <div class="layui-form-item layui-hide">
                <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit"
                       value="确认添加">
            </div>
        </div>
        <div class="layui-card-body">
            <div class="layui-form layui-card-header layuiadmin-card-header-auto">
                <div class="layui-row">
                    <h2>RFID配置参数</h2>
                </div>
            </div>
            <div class="layui-card-body">
                <table id="rfidParam" lay-filter="rfidParam" class="layui-table " lay-skin="none"></table>
            </div>
        </div>
    </div>
</div>
<script type="text/html" id="table-list">
    <button class="layui-btn layui-btn-primary layui-btn-xs" title="新增" lay-event="add"><i
            class="layui-icon layui-icon-add-circle-fine layuiadmin-button-btn"></i></button>
    <button class="layui-btn layui-btn-primary layui-btn-xs" title="删除" lay-event="del"><i
            class="layui-icon layui-icon-reduce-circle layuiadmin-button-btn"></i></button>
</script>
<script src="<%=request.getContextPath()%>/common/layui/layui.all.js"></script>
<script>
    layui.config({
        base: "<%=request.getContextPath()%>/"
    });
</script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script type="text/javascript">
    var layer = layui.layer;
    var table = layui.table;
    var form = layui.form;
    var submit = false;
    var $ = layui.jquery;
    var reg = /^\d+$|^\d*\.\d+$/;
    var laydate = layui.laydate;
    form.render();
    var dataJson = [];
    var funName = "point_rfid_add";
    //过滤字段
    var hiddenFields = [];
    var win = null;
    form.render();

    function SetData(data){
        win = data.win ? data.win : window;
        var data = data.rfidGroup;
        form.val('point-rfid-add', {
            "rfidNum": data.rfidNum,
            "ipAddr": data.ipAddr,
            "port": data.port,
        });
        tables.reload({
            data: data.rfidPointList
        });
    }
    table.on('sort(rfidParam)', function (obj) { //注：sort 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
        table.reload('rfidParam', {
            initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。
            , where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                field: obj.field //排序字段
                , order: obj.type //排序方式
            }
        });

    });
    //查询过滤字段
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

    //文本框回车事件
    $(".layui-input").on("keydown", function (event) {
        if (event.keyCode == 13) {
            var submit = $("#search");
            submit.click();
            return false;
        }
    });

    function getFullSize() {
        var fluid = $(".layui-fluid");
        var header = $(".layui-card-header");
        var cardbody = $(".layui-card-body");
        return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + (fluid.outerHeight(true) - fluid.height()) + 2;
    }

    $(window).resize(function () {
        table.reload("rfidParam", {
            height: "full-" + getFullSize()
        });
    });

    table.on('toolbar(rfidParam)', function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });
    //监听提交
    form.on("submit(layuiadmin-app-form-submit)", function (data) {
        var rfidGroup = data.field;
        if (submit == false) {
            var rfidPointList = table.cache['rfidParam'];
            rfidGroup.rfidPointList = rfidPointList;
            win.setEditRfidGroup(rfidGroup);
            var index = parent.layer.getFrameIndex(window.name);
            top.layer.close(index);
            submit = true;
        } else {
            layer.msg("请稍等");
        }
        return false;
    });

    //监听按钮点击事件
    var active = {

    }

    /*   PLC */

    var tables = table.render({
        elem: "#rfidParam",
        id: "rfidParam",
        data: [],
        height: "full-" + getFullSize(),
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
        cols: [[{
            title: '序号',
            type: 'numbers',
            hide: false
        }, {
            field: "paramName",
            title: "参数名称",
            align: "center",
            edit: 'text',
            minWidth: 100,
        }, {
            field: "paramKey",
            title: "参数主键(key)",
            edit: 'text',
            align: "left",
            minWidth: 100,
        }, {
            field: "paramValue",
            title: "参数值(value)",
            edit: 'text',
            align: "center",
            minWidth: 80,
        }, {
            field: "paramMark",
            title: "参数标记(mark)",
            edit: 'text',
            align: "center",
            minWidth: 80,
        }, {
            field: "remarks",
            title: "备注",
            edit: 'text',
            align: "center",
            minWidth: 120,
        }, {
            title: "操作",
            align: "center",
            fixed: "right",
            width: 120,
            toolbar: "#table-list"
        }]],

    });

    table.on("tool(rfidParam)", function (obj) {
        if (obj.event == 'add') {
            var Data = table.cache["rfidParam"];
            var datas = {
                "paramName": "",
                "paramKey": "",
                "paramValue": "",
                "paramMark": "",
                "remarks": "",
            }
            Data.push(datas);
            tables.reload({
                data: Data
            });
        } else if(obj.event == "del") {
            var Data = table.cache["rfidParam"];
            if(Data.length>1){
                if (obj.tr.data("index") >= -1) {
                    Data.splice(obj.tr.data("index"), 1);	//根据索引删除当前行
                    tables.reload({
                        data: Data
                    });
                }
            }
        }
    })
    //单击行事件
    $('body').on("click", ".layui-table-body table.layui-table tbody tr td", function () {
        if ($(this).attr("data-field") === "0")
            return;
        $(this).siblings().eq(0).find('i').click();
    });
</script>
</body>
</html>
