<!--
- Author(s): 李伟杰
- Date: 2022-12-05 14:08:11
- Description:
-->
<%@page pageEncoding="UTF-8" %>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>下料报表</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
    <%--图标--%>
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
        <div class="layui-form  layuiadmin-card-header-auto"
             lay-filter="layuiadmin-blanking-form" id="layuiadmin-blanking-form"> <%--layui-card-header 样式变宽--%>
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">设备资源号：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="resource" autocomplete="off"/>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">下料轴：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="axis" autocomplete="off"/>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">上料卷径：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="diamRealityValue" autocomplete="off"/>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">创建时间：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="CREATED_TIME" id="CREATED_TIME" placeholder="请选择创建日期" autocomplete="off" class="layui-input" readonly>
                    </div>
                </div>
                <div class="layui-inline layui-hide">
                    <button id="LAY-app-blanking-search" class="layui-btn layuiadmin-btn-list" lay-submit
                            lay-filter="LAY-app-blanking-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </script>
    <div class="layui-card-body">
        <table id="LAY-app-blanking-list" lay-filter="LAY-app-blanking-list"></table>
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

    //高级搜索引用组件
    var util = layui.util;
    var admin = layui.admin;
    var view = layui.view;
    var laydate = layui.laydate;
    //过滤字段
    var hiddenFields = [];
    //功能名
    var funName = "blanking_list";

    // 高级查询参数
    var advancedFormData = {};
    // 焦点名称
    var focusName = null;

    //监听搜索
    form.on("submit(LAY-app-blanking-search)", function (data) {
        var startTime = "";
        var endTime = "";
        var field = data.field;
        if(field.CREATED_TIME != null){
            startTime = field.CREATED_TIME.substring(0,field.CREATED_TIME.indexOf("~"));
            endTime = field.CREATED_TIME.substring(field.CREATED_TIME.indexOf("~")+1);
        }
        field["startTime"]=startTime
        field["endTime"]=endTime


        //调用读取数据函数
        reloadData(field);

        //toolbar搜索条件——设备资源号，轴名称 ，天线位置
        var formData = {
            resource: field.resource,
            axis: field.axis,
            diamRealityValue: field.diamRealityValue,
            CREATED_TIME:field.CREATED_TIME
        };

        //将toolbar 表单赋值
        form.val("layuiadmin-blanking-form", formData);

        //注意：1. 如果只为$.extend()指定了一个参数，则意味着参数target被省略。此时，target就是jQuery对象本身。通过这种方式，我们可以为全局对象jQuery添加新的函数。
        // 2. 如果多个对象具有相同的属性，则后者会覆盖前者的属性值。
        advancedFormData = $.extend(advancedFormData, formData);
    });

    function reloadData(formData) {
        table.reload("LAY-app-blanking-list-reload", {
            where: formData
        });
        formReder();
        if (focusName) {
            $("input[name=" + focusName + "]").focus();
        }
    }

    //设置表单值
    function setFormData(data) {
        advancedFormData = data;
        reloadData(data);
        form.val("layuiadmin-blanking-form", {
            resource: data.resource,
            axis: data.axis,
            diamRealityValue: data.diamRealityValue,
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
            var submit = $("#LAY-app-blanking-search");
            submit.click();
            return false;
        },
        query: function () {
            //高级查询页面
            var url = "<%=request.getContextPath() %>/report/blanking_form_query.jsp";
            //弹窗
            admin.popupRight({
                type: 2,
                content: [url, "yes"],
                btn: ["查询", "重置", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        win: window,

                        //将toorbar值传到页面
                        data: advancedFormData
                    };
                    //传值
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    var submit = layero.find("iframe").contents().find("#LAY-app-blanking-search-advanced");
                    submit.click();
                    top.layer.close(index);
                },
                btn2: function (index, layero) {
                    layero.find("iframe")[0].contentWindow.reset();
                }
            });
        }
    };

    //左侧表头按钮事件监听
    table.on('toolbar(LAY-app-blanking-list)', function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    //表格排序
    table.on('sort(LAY-app-blanking-list)', function (obj) {
        table.reload('LAY-app-blanking-list-reload', {
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

    table.render({
        elem: "#LAY-app-blanking-list",
        id: "LAY-app-blanking-list-reload",
        url: "<%= request.getContextPath() %>/report/blanking/query",
        method: "get",
        height: "full-" + getFullSize(),
        page: true,
        limit: 100,
        toolbar: "#toolbar",
        // defaultToolbar: ["filter"],
        defaultToolbar: [{
            title: "查询",
            layEvent: "search",
            icon: "layui-icon layui-icon-search layuiadmin-button-btn",
        }, {
            title: "高级查询",
            layEvent: "query",
            icon: "icon iconfont icon-gaojichaxun",
        }, "filter"],

        //列筛选
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
            field: "operation",
            title: "工位",
            align: "center",
            // sort: true,
            hide: isHidden("operation"),
            minWidth: 100
        }, {
            field: "resource",
            title: "设备资源号",
            align: "center",
            // sort: true,
            hide: isHidden("resource"),
            minWidth: 120
        }, {
            //field:设定字段名。字段名的设定非常重要，且是表格数据列的唯一标识;title:设定标题名称
            field: "axis",
            title: "下料轴",
            align: "center",
            minWidth: 100,
            hide: isHidden("axis")
        }, {
            field: "sfcpre",
            title: "来料SFC号",
            align: "center",
            hide: isHidden("sfcpre"),
            minWidth: 120
        }, {
            field: "processLot",
            title: "载具号",
            align: "center",
            hide: isHidden("processLot"),
            minWidth: 120
        }, {
            field: "sfc",
            title: "下料绑定的SFC编码",
            align: "center",
            hide: isHidden("sfc"),
            minWidth: 180
        }, {
            field: "qty",
            title: "EA数",
            align: "center",
            hide: isHidden("qty"),
            minWidth: 80
        }, {
            field: "metre",
            title: "收卷米数",
            align: "center",
            hide: isHidden("metre"),
            minWidth: 120
        }, {
            field: "diamRealityValue",
            title: "上料卷径",
            align: "center",
            hide: isHidden("diamRealityValue"),
            minWidth: 120
        }, {
            field: "createdBy",
            title: "创建人",
            align: "center",
            hide: isHidden("createdBy"),
            minWidth: 100
        },{
            field: "createdTime",
            title: "创建时间",
            align: "center",
            hide: isHidden("createdTime"),
            templet: function(d) {
                return util.toDateString(d.createdTime, "yyyy-MM-dd HH:mm:ss");
            },
            minWidth: 160
        }, {
            field: "updatedBy",
            title: "更新人",
            align: "center",
            hide: isHidden("updatedBy"),
            minWidth: 150
        }, {
            field: "updatedTime",
            title: "更新时间",
            align: "center",
            hide: isHidden("updatedTime"),
            templet: function (d) {
                return util.toDateString(d.updatedTime, "yyyy-MM-dd HH:mm:ss");
            },
            minWidth: 160
        }]]
    });

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
                var submit = $("#LAY-app-blanking-search");
                submit.click();
                return false;
            }
        });
    }

    $(window).resize(function () {
        table.reload("LAY-app-blanking-list-reload", {
            height: "full-" + getFullSize()
        });
    });

    $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function () {
        if ($(this).attr("data-field") === "0") return;
        $(this).siblings().eq(0).find('i').click();
    });
</script>
</body>
</html>