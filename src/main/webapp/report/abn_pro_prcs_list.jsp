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
    <title>生产过程异常报表</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
    <style type="text/css">
        .layui-card {
            margin-bottom: 0px
        }
    </style>
</head>
<body>
<div class="layui-card">
    <div class="layui-form layui-card-header layuiadmin-card-header-auto">
        <div class="layui-form-item">
            <div class="layui-inline">
                <label class="layui-form-label">站点号：</label>
                <div class="layui-input-inline">
                    <input type="text" name="siteId" value="" placeholder="请输入站点号" autocomplete="off"
                           class="layui-input">
                </div>
                <label class="layui-form-label">膜卷号：</label>
                <div class="layui-input-inline">
                    <input type="text" name="rollId" value="" placeholder="请输入膜卷号" autocomplete="off"
                           class="layui-input">
                </div>
            </div>
            <div class="layui-inline">
                <label class="layui-form-label">设备资源号：</label>
                <div class="layui-input-inline">
                    <input type="text" name="equipmentId" value="" placeholder="请输入设备资源号" autocomplete="off"
                           class="layui-input">
                </div>
                <label class="layui-form-label">轴名称：</label>
                <div class="layui-input-inline">
                    <input type="text" name="axisName" value="" placeholder="请输入轴名称" autocomplete="off"
                           class="layui-input">
                </div>
            </div>

<%--            <div class="layui-inline">--%>
<%--                <div class="layui-input-inline">--%>
<%--                    <input type="text" name="performStep" value="" placeholder="执行步骤" autocomplete="off"--%>
<%--                           class="layui-input">--%>
<%--                </div>--%>
<%--            </div>--%>

            <div class="layui-inline">
                <label class="layui-form-label">创建时间：</label>
                <div class="layui-input-inline">
                    <input type="text" name="createTime" value="" placeholder="请选择创建时间" id="test0" autocomplete="off"
                           class="layui-input">
                </div>

                <label class="layui-form-label">更新时间：</label>
                <div class="layui-input-inline">
                    <div class="layui-input-inline">
                    <input type="text" name="updateTime" value="" placeholder="请选择更新时间" id="test1" autocomplete="off"
                           class="layui-input">
                    </div>
                </div>
                <div class="layui-inline layui-search"style="padding-left:15px">
                    <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-rolelist-search"
                            id="LAY-app-rolelist-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>

        </div>
    </div>
    <div class="layui-card-body">
        <%--        <div class="layui-toolbar" id="toolbar" hidden="true">--%>
        <%--            <button class="layui-btn layuiadmin-btn-list layui-btn-sm"  lay-event="add"><i class="layui-icon layui-icon-add-circle-fine"></i>添加</button>--%>
        <%--            <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel"><i class="layui-icon layui-icon-delete"></i>删除</button>--%>
        <%--        </div>--%>
        <table id="LAY-app-application-list" lay-filter="LAY-app-application-list"></table>
        <%--        <script type="text/html" id="table-role-list">--%>
        <%--            <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i class="layui-icon layui-icon-edit"></i>编辑</a>--%>
        <%--            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i class="layui-icon layui-icon-delete"></i>删除</a>--%>
        <%--        </script>--%>
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

    //过滤字段
    var hiddenFields = [];

    //功能名
    var funName = "application_list";
    //时间工具类引用
    var util =layui.util;
    var laydate = layui.laydate;

    //日期时间选择器
    laydate.render({
        elem: '#test0'
        , type: 'date'
    });

    //日期时间选择器
    laydate.render({
        elem: '#test1'
        , type: 'date'
    });

    //监听搜索
    form.on("submit(LAY-app-rolelist-search)", function (data) {
        var field = data.field;
        table.reload("LAY-app-application-list-reload", {
            where: field
        });
    });

    //下拉框监听事件
    form.on('select(appType)', function (data) {
        var submit = $("#LAY-app-rolelist-search");
        submit.click();
    });

    //文本框回车事件
    $(".layui-input").on("keydown", function (event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-rolelist-search");
            submit.click();
            return false;
        }
    });


    function getFullSize() {
        var header = $(".layui-card-header");
        var cardbody = $(".layui-card-body");
        return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + 1;
    }


    //表格排序
    table.on('sort(LAY-app-application-list)', function (obj) {
        table.reload('LAY-app-application-list-reload', {
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
        elem: "#LAY-app-application-list",
        id: "LAY-app-application-list-reload",
        url: "<%= request.getContextPath() %>/report/abnProdPrcs/query",
        method: "get",
        height: "full-" + getFullSize(),
        page: true,
        limit: 10,
        toolbar: "#toolbar",
        defaultToolbar: ["filter"],
        //列筛选
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
        limits: [10, 15, 20, 30],
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
            type: "checkbox"
        },{
            title: "序号",
            type: "numbers"
        }, {
            field: "siteId",
            title: "站点号",
            align: "center",
            // sort: true,
            hide: isHidden("siteId"),
            minWidth: 150
        }, {

            //field:设定字段名。字段名的设定非常重要，且是表格数据列的唯一标识;title:设定标题名称
            field: "rollId",
            title: "膜卷号",
            align: "center",
            minWidth: 150,
            hide: isHidden("rollId")
        }, {
            field: "equipmentId",
            title: "设备资源号",
            align: "center",
            hide: isHidden("equipmentId"),
            minWidth: 150
        }, {
            field: "axisName",
            title: "轴名称",
            align: "center",
            hide: isHidden("axisName"),
            minWidth: 150
        }, {
            field: "vehicleCode",
            title: "载具码",
            align: "center",
            hide: isHidden("vehicleCode"),
            minWidth: 150
        }, {
            field: "prodSFCId",
            title: "生产SFC编码",
            align: "center",
            hide: isHidden("prodSFCId"),
            minWidth: 150
        }, {
            field: "endEANumber",
            title: "完工EA数量",
            align: "center",
            hide: isHidden("endEANumber"),
            minWidth: 60
        }, {
            field: "performStep",
            title: "执行步骤",
            align: "center",
            hide: isHidden("performStep"),
            minWidth: 60,
            templet:function(d) {

                return layui.admin.getDictText("PERFORM_STEP", d.performStep);
            }
        }, {
            field: "isEnd",
            title: "是否完工",
            align: "center",
            hide: isHidden("isEnd"),
            minWidth: 60,
            templet:function(d) {

                return layui.admin.getDictText("IS_END", d.isEnd);
            }
        }, {
            field: "createTime",
            title: "创建时间",
            align: "center",
            hide: isHidden("createTime"),
            minWidth: 200,
            templet:function(d){
                return util.toDateString(d.createTime,'yyyy-MM-dd HH:mm:ss');
            }
        }, {
            field: "updateTime",
            title: "更新时间",
            align: "center",
            hide: isHidden("updateTime"),
            minWidth: 200,
            templet:function(d){
                return util.toDateString(d.updateTime,'yyyy-MM-dd HH:mm:ss');
            }
        }

        ]]
    });

    $(window).resize(function () {
        table.reload("LAY-app-application-list-reload", {
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