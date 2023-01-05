<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>plc点位配置</title>
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
        <div class="layui-form" lay-filter="point-plc-add" id="point-plc-add" style="padding:20px;">
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm6">
                    <label class="layui-form-label"><span style="color:red">*</span>组别名称：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="plcGroupName" id="plcGroupName"
                               lay-verify="required|length20"
                               autocomplete="off" placeholder="请输入组别名称">
                    </div>
                </div>
                <div class="layui-col-sm6">
                    <label class="layui-form-label"><span style="color:red">*</span>组别类型：</label>
                    <div class="layui-input-block">
                        <select name="plcGroupType" id="plcGroupType" lay-filter="plcGroupType" lay-verify="required" type="select">
                        </select>
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10 layui-form-item">
                <div class="layui-col-sm6">
                    <label class="layui-form-label"><span style="color:red">*</span>组映射RFID名称：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="plcGroupRname" id="plcGroupRname"
                               lay-verify="required|length20"
                               autocomplete="off" placeholder="请输入组映射RFID名称">
                    </div>
                </div>
                <div class="layui-col-sm6">
                    <label class="layui-form-label"><span style="color:red">*</span>RFID天线编码：</label>
                    <div class="layui-input-block">
                        <input type="text" class="layui-input" name="rfidNum" id="rfidNum" lay-verify="required|length20"
                               autocomplete="off" placeholder="请输入RFID天线编码">
                    </div>
                </div>
            </div>
            <div class="layui-row layui-col-space10 layui-form-item">
                <label class="layui-form-label">备注：</label>
                <div class="layui-input-block">
                    <textarea class="layui-textarea" placeholder="备注，不超过255个字符，可输入中英文、数字、符号" lay-verify="remarks|length255"
                              name="remarks" id="remarks"></textarea>
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
                    <h2>PLC配置参数</h2>
                </div>
            </div>
            <div class="layui-card-body">
                <table id="plcParam" lay-filter="plcParam" class="layui-table " lay-skin="none"></table>
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
    var funName = "point_plc_add";
    //过滤字段
    var hiddenFields = [];
    var win = null;
    layui.admin.renderDictSelect({
        elem: "#plcGroupType",
        dictTypeId: "plc_group_type"
    });
    form.render();
    form.verify({
        length20: function(value, item){ //value：表单的值、item：表单的DOM对象
            if(value.length>20){
                return '字数已达上限';
            }
        },
        length255: function(value, item){ //value：表单的值、item：表单的DOM对象
            if(value.length>255){
                return '字数已达上限';
            }
        }
    });
    function SetData(data) {
        win = data.win ? data.win : window;
        var data = data.plcGroup;
        form.val('point-plc-add', {
            "plcGroupName": data.plcGroupName,
            "plcGroupType": data.plcGroupType,
            "plcGroupRname": data.plcGroupRname,
            "rfidNum": data.rfidNum,
            "remarks": data.remarks,
        });
        tables.reload({
            data: data.plcPointList
        });
    }

    table.on('sort(plcParam)', function (obj) { //注：sort 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
        table.reload('plcParam', {
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
        table.reload("plcParam", {
            height: "full-" + getFullSize()
        });
    });

    table.on('toolbar(plcParam)', function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });
    //监听提交
    form.on("submit(layuiadmin-app-form-submit)", function (data) {
        var plcGroup = data.field;
        if (submit == false) {
            var plcPointList = table.cache['plcParam'];
            plcGroup.plcPointList = plcPointList;
            win.setEditPlcGroup(plcGroup);
            var index = parent.layer.getFrameIndex(window.name);
            top.layer.close(index);
            submit = true;
        } else {
            layer.msg("请稍等");
        }
        return false;
    });

    //监听按钮点击事件
    var active = {}

    /*   PLC */

    var tables = table.render({
        elem: "#plcParam",
        id: "plcParam",
        data: [],
        limit: 99999,
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
            field: "shineAddr",
            title: "映射地址",
            align: "center",
            edit: 'text',
            minWidth: 100,
        }, {
            field: "lableName",
            title: "标签名称",
            edit: 'text',
            align: "left",
            minWidth: 100,
        }, {
            field: "dataType",
            title: "数据类型",
            edit: 'text',
            align: "center",
            minWidth: 80,
        }, {
            field: "paramLen",
            title: "参数长度",
            edit: 'text',
            align: "center",
            minWidth: 80,
        }, {
            field: "smallPoint",
            title: "小数点（dp)",
            edit: 'text',
            align: "center",
            minWidth: 120,
        }, {
            field: "chineseMean",
            title: "中文释义",
            edit: 'text',
            align: "center",
            minWidth: 100,
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

    table.on("tool(plcParam)", function (obj) {
        if (obj.event == 'add') {
            var Data = table.cache["plcParam"];
            var datas = {
                "shineAddr": "",
                "lableName": "",
                "dataType": "",
                "paramLen": "",
                "smallPoint": "",
                "chineseMean": "",
                "remarks": "",
            }
            Data.push(datas);
            tables.reload({
                data: Data
            });
        } else if(obj.event == "del") {
            var Data = table.cache["plcParam"];
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
    table.on('edit(plcParam)',function (obj) {
        var that = this;
        var reg = /^\d+$|^\d*\.\d+$/;
        if(that.parentElement.cellIndex==4||that.parentElement.cellIndex==5){
            var oldText = $(that).prev().text();
            if(!reg.test(obj.value)){
                top.layer.alert("数量必须为整数!",{icon : 2, title : '系统提示'});
                $(that).val(oldText);
                return;
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
