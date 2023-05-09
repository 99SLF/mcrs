<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 李伟杰
  - Date: 2022-12-14 10:05:20
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=deviceUpgrade-width, initial-scale=1, maximum-scale=1">
    <title>终端回退信息</title>
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
        <div class="layui-form layuiadmin-card-header-auto" lay-filter="layuiadmin-deviceRollback-form"
             id="layuiadmin-deviceRollback-form">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">终端名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="deviceName" autocomplete="off"/>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">终端类型：</label>
                    <div class="layui-input-inline">
                        <select name="deviceSoftwareType" id="deviceSoftwareType" lay-filter="deviceSoftwareType"
                                type="select">
                            <option value=""></option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">回退版本号：</label>
                    <div class="layui-input-inline">
                        <input type="text" class="layui-input" name="version" autocomplete="off"/>
                    </div>
                </div>
                <div class="layui-inline layui-hide">
                    <button id="LAY-app-deviceRollback-list-search" class="layui-btn layuiadmin-btn-list" lay-submit
                            lay-filter="LAY-app-deviceRollback-list-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </script>
    <div class="layui-card-body">
        <table id="LAY-app-deviceRollback-list" lay-filter="LAY-app-deviceRollback-list"></table>

        <script type="text/html" id="table-deviceRollback-list">
            <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="configurationFile"><i
                    class="layui-icon layui-icon-file-b"></i>详细</a>
        </script>
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

    //全局参数
    var req_data;

    //功能名
    var funName = "rollback_list";

    var hiddenFields = [];


    // 焦点名称
    var focusName = null;

    // 高级查询参数
    var advancedFormData = {};

    //监听搜索
    form.on("submit(LAY-app-deviceRollback-list-search)", function (data) {
        var field = data.field;
        reloadData(field);
        var formData = {
            deviceName: field.deviceName,
            deviceSoftwareType: field.deviceSoftwareType,
            version: field.version
        };

        //设置整个表单数据 layuiadmin-update_package-form
        form.val("layuiadmin-deviceRollback-form", formData);
        advancedFormData = $.extend(advancedFormData, formData);
    });

    function reloadData(formData) {

        //读取表格数据 表格id LAY-app-update_package-list-reload
        table.reload("LAY-app-deviceRollback-list-reload", {
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

        //将设置整个表单的数据
        form.val("layuiadmin-deviceRollback-form", {
            deviceName: data.deviceName,
            deviceSoftwareType: data.deviceSoftwareType,
            version: data.version
        });
    }

    table.on('sort(LAY-app-deviceRollback-list)', function (obj) {
        table.reload('LAY-app-deviceRollback-list-reload', {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
    });

    //左侧表头按钮事件监听
    table.on("toolbar(LAY-app-deviceRollback-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });


    //表格排序
    table.on("sort(LAY-app-deviceRollback-list)", function (obj) {
        table.reload("LAY-app-deviceRollback-list-reload", {
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
        table.reload("LAY-app-deviceRollback-list-reload", {
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

    table.render({
        elem: "#LAY-app-deviceRollback-list",
        id: "LAY-app-deviceRollback-list-reload",
        url: "<%= request.getContextPath() %>/equipment/deviceRollback/query",
        method: "GET",
        height: "full-" + getFullSize(),
        page: true,
        limit: 10,
        limits: [10, 15, 20, 30],
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
            field: "deviceName",
            title: "终端名称",
            align: "center",
            minWidth: 130,
            hide: isHidden("deviceName")
        }, {
            field: "deviceSoftwareType",
            title: "终端类型",
            align: "center",
            minWidth: 120,
            hide: isHidden("deviceSoftwareType"),
            templet: function (d) {

                return layui.admin.getDictText("DEVICE_SOFTWARE_TYPE", d.deviceSoftwareType);
            }
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
            minWidth: 150,
            hide: isHidden("equipmentName")
        }, {
            field: "equipmentName",
            title: "设备类型",
            align: "center",
            minWidth: 150,
            hide: isHidden("equipmentName")
        }, {
            field: "uploadNumber",
            title: "更新包单号",
            align: "center",
            minWidth: 180,
            hide: isHidden("uploadNumber")
        }, {
            field: "version",
            title: "回退版本号",
            align: "center",
            minWidth: 100,
            hide: isHidden("version")
        }, {
            field: "upgradeStatus",
            title: "升级状态",
            align: "center",
            minWidth: 150,
            hide: isHidden("upgradeStatus"),
            templet: function (d) {
                return layui.admin.getDictText("Rollback", d.upgradeStatus);
            }
        }, {
            field: "accPointResName",
            title: "接入点名称",
            align: "center",
            minWidth: 150,
            hide: isHidden("accPointResName")
        }, {
            field: "factoryName",
            title: "工厂名称",
            align: "center",
            minWidth: 150,
            hide: isHidden("factoryName")
        }, {
            field: "createName",
            title: "版本回退人",
            align: "center",
            minWidth: 150,
            hide: isHidden("createName")
        }, {
            field: "versionRollbackTime",
            title: "版本回退时间",
            align: "center",
            minWidth: 200,
            hide: isHidden("versionRollbackTime")
        }]]
    });

    formReder();

    function formReder() {
        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-deviceRollback-list-search");
                submit.click();
                return false;
            }
        });

        //软件类型下拉框监听事件
        form.on("select(deviceSoftwareType)", function (data) {
            var submit = $("#LAY-app-deviceRollback-list-search");
            submit.click();
        });

        // 获取终端类型的下拉值
        layui.admin.renderDictSelect({
            elem: "#deviceSoftwareType",
            dictTypeId: "DEVICE_SOFTWARE_TYPE"
        });
        form.render();
    }

    var active = {
        search: function () {
            //点击搜索
            var submit = $("#LAY-app-deviceRollback-list-search");
            submit.click();
            return false;
        },
        //高级搜索
        query: function () {
            var url = "<%=request.getContextPath() %>/equipment/deviceUpgrade/device_rollback_from_query.jsp";
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
                    var submit = layero.find("iframe").contents().find("#LAY-app-deviceRollback-list-search-advanced");
                    submit.click();
                    top.layer.close(index);
                },
                btn2: function (index, layero) {
                    layero.find("iframe")[0].contentWindow.reset();
                }
            });
        },
    };


    //监听操作事件
    table.on("tool(LAY-app-deviceRollback-list)", function (e) {
        //当前行数据
        var data = e.data;
        var appId = data.aPPId;
        if (e.event == "configurationFile") {
            top.layer.open({
                type: 2,
                title: "查看配置文件详情",
                content: "<%= request.getContextPath() %>/updateConfigFile/view_list.jsp",
                area: ["800px", "560px"],
                resize: false,
                btn: ["关闭"],
                success: function (layero, index) {
                    var dataJson = {
                        appId: appId,
                        win: window
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    // var edit = layero.find("iframe").contents().find("#layuiadmin-app-form-edit");
                    parent.layer.close(index);
                }

            });
        }
    });



    //批量选中
    $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function () {
        if ($(this).attr("data-field") === "0") return;
        $(this).siblings().eq(0).find("i").click();
    });
</script>
</body>
</html>