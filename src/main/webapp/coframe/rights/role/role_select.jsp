<%@page pageEncoding="UTF-8"%>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<!--
  - Author(s): SSW
  - Date: 2021-03-30 10:42:05
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>角色选择</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css">
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
<div class="layui-fluid">
    <div class="layui-card">
        <script type="text/html" id="toolbar">
            <div class="layui-form layuiadmin-card-header-auto" lay-filter="layuiadmin-feeding-form" id="layuiadmin-feeding-form">
                <div class="layui-form-item">
                    <div class="layui-inline">
                        <label class="layui-form-label">角色代码：</label>
                        <div class="layui-input-inline">
                            <input type="text" name="roleCode" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline">
                        <label class="layui-form-label">角色名称：</label>
                        <div class="layui-input-inline">
                            <input type="text" name="roleName" placeholder="" autocomplete="off" class="layui-input">
                        </div>
                    </div>
                    <div class="layui-inline layui-hide">
                        <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-rolelist-search" id="LAY-app-rolelist-search">
                            <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                        </button>
                    </div>
                </div>
            </div>
        </script>
        <div class="layui-card-body">
            <table id="LAY-app-role-list" lay-filter="LAY-app-role-list"></table>
        </div>
    </div>
</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script>
    layui.config({
        base: "<%=request.getContextPath()%>/"
    });
</script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js" type="text/javascript"></script>
<script src="<%= request.getContextPath() %>/coframe/rights/role/role.js" type="text/javascript"></script>
<script type="text/javascript">
    var $ = layui.$;
    var form = layui.form;
    var table = layui.table;
    // 是否已初始化
    var isInit = false;
    var hiddenFields = [];
    // 调用窗口对象
    var win = null;
    var focusName = null;
    //是否已提交
    var submit = false;
    // 功能名
    var funName = "subfuncgroup_list";
    form.render();
    function getFullSize() {
        var fluid = $(".layui-fluid");
        var header = $(".layui-card-header");
        var cardbody = $(".layui-card-body");
        return header.outerHeight(true)  + (cardbody.outerHeight(true) - cardbody.height()) +
            (fluid.outerHeight(true) - fluid.height()) + 2;
    }
    /**
     * 判断是否隐藏函数
     */
    function isHidden(field) {
        for (var i = 0; i < hiddenFields.length; i++) {
            if (hiddenFields[i].field == field ) {
                return true;
            }
        }
        return false;
    }

    // 查询过滤字段
    $.ajax({
        url: "/mcrs/cols/filter/query/" + funName,
        type: "GET",
        async: false,
        cache: false,
        contentType: "text/json",
        success: function(result) {
            if (result) {
                hiddenFields = result.data
            } else {
                layer.msg("查询失败");
            }
        }
    });

    /**
     * 渲染表格
     */
        table.render({
            elem: "#LAY-app-role-list",
            id:"LAY-app-role-list",
            url: "<%= request.getContextPath() %>/rights/role/query",
            method: "get",
            height: "full-" + getFullSize(),
            page: true,
            limit: 10,
            limits: [10, 15, 20, 30],
            toolbar: "#toolbar",
            colHideChange: function(col, checked) {
                var field = col.field;
                var hidden = col.hide;
                $.ajax({
                    url: "/mcrs/cols/filter/set?funName=" + funName + "&field=" + field + "&hidden=" + hidden,
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
            defaultToolbar: [{
                title: "查询",
                layEvent: "search",
                icon: "layui-icon layui-icon-search layuiadmin-button-btn",
            },"filter"],
            parseData: function(res) {
                var t = res.data.length;
                return {
                    code: res.code,
                    msg: res.msg,
                    count: res.total,
                    data: res.data
                };
            },
            cols:[[{
                type: "checkbox"
            }, {
                title: "序号",
                type: "numbers"
            }, {
                field: "roleCode",
                title: "角色代码",
                align: "left",
                hide: isHidden("roleCode"),
                sort: true,
                minWidth: 100
            }, {
                field: "roleName",
                title: "角色名称",
                align: "left",
                hide: isHidden("roleName"),
                minWidth: 120
            }, {
                field: "roleDesc",
                title: "角色描述",
                align: "left",
                hide: isHidden("roleDesc"),
                minWidth: 150
            }, {
                title: "操作",
                align: "center",
                fixed: "right",
                width:  150,
                toolbar: "#table-role-list"
            }]]
        });
    formReder();
    // 操作集合
    var active = {
        search: function() {
            var submit = $("#LAY-app-rolelist-search");
            submit.click();
            return false;
        }
    };
    table.on("toolbar(LAY-app-role-list)", function(obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });
    form.on("submit(LAY-app-rolelist-search)", function(data) {
        var field = data.field;
        table.reload("LAY-app-role-list", {
            where: field,
            page: {
                curr: 1
            }
        })
        formReder();
        form.val("layuiadmin-feeding-form", field);
    });

    function formReder() {
        form.render();
        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-rolelist-search");
                submit.click();
                return false;
            }
        });
        if (focusName) {
            $("input[name=" + focusName + "]").focus();
        }
    }


    function getData() {   //获取点击行的数据
        var checkStatus = table.checkStatus('LAY-app-role-list');
        return checkStatus.data;
    }
    $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function() {
        if ($(this).attr("data-field") === "0") return;
        $(this).siblings().eq(0).find('i').click();
    });
</script>
</body>
</html>