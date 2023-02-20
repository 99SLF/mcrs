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
    <title>RFID状态</title>
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
             lay-filter="layuiadmin-RFID-form" id="layuiadmin-RFID-form">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">设备资源号：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="equipmentId" autocomplete="off">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">接入状态：</label>
                    <div class="layui-input-inline">
                        <select name="accessStatus" id="accessStatus" lay-filter="accessStatus"
                                type="select">
                            <option value=""></option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline layui-hide">
                    <button id="LAY-app-RFID-search" class="layui-btn layuiadmin-btn-list" lay-submit
                            lay-filter="LAY-app-RFID-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </script>
    <div class="layui-card-body">
        <table id="LAY-app-RFID-list" lay-filter="LAY-app-RFID-list"></table>
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

    // 过滤字段
    var hiddenFields = [];
    // 功能名
    var funName = "RFID_list";
    // 高级查询参数
    var advancedFormData = {};
    // 焦点名称
    var focusName = null;


    // 监听搜索
    form.on("submit(LAY-app-RFID-search)", function (data) {
        var field = data.field;
        reloadData(field);
        var formData = {
            equipmentId: field.equipmentId,
            accessStatus: field.accessStatus
        };
        form.val("layuiadmin-RFID-form", formData);
        advancedFormData = $.extend(advancedFormData, formData);
    });


    function reloadData(formData) {
        //读取表格数据 表格id
        table.reload("LAY-app-RFID-list-reload", {
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
        form.val("layuiadmin-RFID-form", {
            equipmentId: data.equipmentId,
            accessStatus: data.accessStatus
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
            var submit = $("#LAY-app-RFID-search");
            submit.click();
            return false;
        }
        ,
        <%--query: function () {--%>
        <%--    var url = "<%=request.getContextPath() %>/.jsp";--%>
        <%--    admin.popupRight({--%>
        <%--        type: 2,--%>
        <%--        content: [url, "yes"],--%>
        <%--        btn: ["查询", "重置", "取消"],--%>
        <%--        success: function (layero, index) {--%>
        <%--            var dataJson = {--%>
        <%--                win: window,--%>
        <%--                data: advancedFormData--%>
        <%--            };--%>
        <%--            layero.find("iframe")[0].contentWindow.SetData(dataJson);--%>
        <%--        },--%>
        <%--        yes: function (index, layero) {--%>
        <%--            var submit = layero.find("iframe").contents().find("#LAY-app-PLC-search-advanced");--%>
        <%--            submit.click();--%>
        <%--            top.layer.close(index);--%>
        <%--        },--%>
        <%--        btn2: function (index, layero) {--%>
        <%--            layero.find("iframe")[0].contentWindow.reset();--%>
        <%--        }--%>
        <%--    });--%>
        <%--}--%>
    };

    // 右侧表头按钮事件监听
    table.on("toolbar(LAY-app-RFID-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    // 表格排序
    table.on("sort(LAY-app-RFID-list)", function (obj) {
        table.reload("LAY-app-RFID-list-reload", {
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
        elem: "#LAY-app-RFID-list",
        id: "LAY-app-RFID-list-reload",
        url: "<%= request.getContextPath() %>/EquipmentRuntime/RFID/queryEquipmentAccessR",
        method: "GET",
        height: "full-" + getFullSize(),
        page: true,
        limit: 10,
        toolbar: "#toolbar",
        defaultToolbar: [{
            title: "查询",
            layEvent: "search",
            icon: "layui-icon layui-icon-search layuiadmin-button-btn",
        },
            //     {
            //     title: "高级查询",
            //     layEvent: "query",
            //     icon: "icon iconfont icon-gaojichaxun",
            // },
            "filter"],
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
        limits: [10, 15, 20, 30],
        parseData: function (res) {
            debugger;
            return {
                code: res.code,
                msg: res.msg,
                count: res.total,
                data: res.data
            };
        },
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
            field: "equipmentName",
            title: "设备名称",
            align: "center",
            // sort: true,
            hide: isHidden("equipmentName"),
            minWidth: 150
        },{
            field: "accessType",
            title: "接入类型",
            align: "center",
            // sort: true,
            hide: isHidden("accessType"),
            minWidth: 150,
            templet: function (d) {

                return layui.admin.getDictText("ACCESS_TYPE", d.accessType);
            }
        }, {
            //field:设定字段名。字段名的设定非常重要，且是表格数据列的唯一标识;title:设定标题名称
            field: "accessStatus",
            title: "接入状态",
            align: "center",
            minWidth: 150,
            hide: isHidden("accessStatus"),
            templet: function (d) {

                return layui.admin.getDictText("EQUIPMENT_ACCESS_STATUS", d.accessStatus);
            }

        }, {
            field: "antennaStatus",
            title: "天线状态",
            align: "center",
            hide: isHidden("antennaStatus"),
            minWidth: 150,
            templet: function (d) {

                return layui.admin.getDictText("ANTENNA_TYPE", d.antennaStatus);
            }

        }

        ]]
    });


    formReder();

    function formReder() {
        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-RFID-search");
                submit.click();
                return false;
            }
        });

        //软件类型下拉框监听事件
        form.on("select(accessStatus)", function (data) {
            var submit = $("#LAY-app-RFID-search");
            submit.click();
        });


        //获取接入状态的下拉值
        layui.admin.renderDictSelect({
            elem: "#accessStatus",
            dictTypeId: "EQUIPMENT_ACCESS_STATUS",
        });
        form.render();
    }

    $(window).resize(function () {
        table.reload("LAY-app-RFID-list-reload", {
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