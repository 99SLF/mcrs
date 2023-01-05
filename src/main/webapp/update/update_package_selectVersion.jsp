<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2022-12-01 16:11:58
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>更新包管理</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
    <style>
         .layui-table-page {
            border-width: 0px;
            border-style: solid;
            border-color: rgb(230, 230, 230);
        }

    </style>
</head>
<body>
<div class="layui-fluid">

    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">版本号：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="version" placeholder="请输入版本号" autocomplete="off"
                               class="layui-input">
                    </div>
                    <label class="layui-form-label">终端软件类型：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="deviceSoType" placeholder="请输入终端软件类型" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>

                <div class="layui-inline layui-search">
                    <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-devicelist-search"
                            id="LAY-app-devicelist-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>

        <div class="layui-card-body">

            <table id="LAY-app-device-list" lay-filter="LAY-app-device-list"></table>

            <div class="layui-form layui-card-header layuiadmin-card-header-auto">
                <div class="layui-form-item">
                    <div class="layui-inline" style="float: right">
                        <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn" data-type="upgrade">确定
                        </button>
                        <button class="layui-btn layui-btn-normal layui-btn ">取消
                        </button>
                    </div>
                </div>
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
    var table = layui.table;
    var form = layui.form;
    var $ = layui.jquery;
    var util = layui.util;

    //获取传过来的终端主键
    var deviceIds = "<%=request.getParameter("deviceIds")%>";

    //全局参数
    var req_data;


    //功能名，查询过滤字段和列筛选
    var funName = "list";

    var hiddenFields = [];


    /*
    * 搜素栏选择下拉框选值
    */
    // 获取终端软件类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#deviceSoType",
        dictTypeId: "DEVICE_SOFTWARE_TYPE"
    });
    layui.admin.renderDictSelect({
        elem: "#uploadStrategy",
        dictTypeId: "UPDATESTRATEGY"
    });
    //状态默认
    $("#deviceSoType").val("请选择");
    //数据字典项加载
    form.render();


    //监听搜索
    form.on("submit(LAY-app-devicelist-search)", function (data) {
        var field = data.field;
        table.reload("LAY-app-device-list-reload", {
            where: field
        });
    });


    //文本框回车事件
    $(".layui-input").on("keydown", function (event) {
        if (event.keyCode == 13) {
            var submit = $("#LAY-app-devicelist-search");
            submit.click();
            return false;
        }
    });




    table.on('sort(LAY-app-device-list)', function (obj) {
        table.reload('LAY-app-device-list-reload', {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
    });

    //左侧表头按钮事件监听
    table.on("toolbar(LAY-app-device-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });


    //表格排序
    table.on("sort(LAY-app-device-list)", function (obj) {
        table.reload("LAY-app-device-list-reload", {
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
        var form = $(".layui-form");
        return form.outerHeight(true) + header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + (fluid.outerHeight(true) - fluid.height()) + 2;
    }


    $(window).resize(function () {
        table.reload("LAY-app-device-list-reload", {
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
        success: function(result) {
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
        elem: "#LAY-app-device-list",
        id: "LAY-app-device-list-reload",
        url: "<%= request.getContextPath() %>/upload/queryUpdateUpload/query",
        method: "GET",
        height: "full-" + getFullSize(),
        page: true,
        //skin: 'nob',
        limit: 10,
        limits: [10, 15, 20, 30],
        toolbar: "#toolbar",
        defaultToolbar: ["filter"],
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
        parseData: function (res) {
            return {
                code: res.code,
                msg: res.msg,
                count: res.total,
                data: res.data
            };
        },
        cols: [[{
            type: "checkbox",
        }, {
            title: "序号",
            type: "numbers",
        },{
            field: "uploadNumber",
            title: "更新包单号",
            align: "center",
            minWidth: 120,
            hide: isHidden("uploadNumber"),
            //打开监听
            event: "view",
            //监听打开详情页面
            templet: function (d) {
                return '<span style="color: #09bbfd">' + d.uploadNumber +'</span>';
            }
        }, {
            field: "version",
            title: "版本号",
            align: "center",
            minWidth: 80,
            hide: isHidden("version")
        }, {
            field: "uploadStrategy",
            title: "更新策略",
            align: "center",
            minWidth: 120,
            hide: isHidden("uploadStrategy"),
            templet:function(d) {
                return layui.admin.getDictText("UPDATESTRATEGY", d.uploadStrategy);
            }
        }, {
            field: "deviceSoType",
            title: "终端软件类型",
            align: "center",
            minWidth: 150,
            hide: isHidden("deviceSoType"),
            templet:function(d) {

                return layui.admin.getDictText("DEVICE_SOFTWARE_TYPE", d.deviceSoType);
            }

        }, {
            field: "versionUploadTime",
            title: "版本上传时间",
            align: "center",
            minWidth: 200,
            hide: isHidden("versionUploadTime"),
            templet:function (data) {
                return layui.util.toDateString(data.versionUploadTime, "yyyy-MM-dd HH:mm:ss");
            }
        }
        ]]
    });


    $(".layui-btn").on("click", function() {
        var type = $(this).data("type");
        active[type] ? active[type].call(this) : "";
    });
    var active = {

        //升级跳转
        upgrade: function () {
            debugger;
            var checkStatus = table.checkStatus("LAY-app-device-list-reload");
            var data = checkStatus.data;
            if (data.length == 0) {
                layer.msg("请至少选中一条记录！");
            }
            if (data.length > 0) {
                var uploadIds = data[0].uploadId;
                var ids =new Array();
                ids = deviceIds.split("_");

                //组合成json数据
                var json = {};
                json.ids = ids;
                json.upload = uploadIds;
                layer.confirm("确定升级所选更新版本？", {
                    icon: 3,
                    title: "系统提示"
                }, function (index) {
                    $.ajax({
                        url: "<%= request.getContextPath() %>/equipment/add",
                        type: "post",
                        data: JSON.stringify(json),
                        cache: false,
                        contentType: "text/json",
                        success: function (result) {
                            if (result.exception) {
                                layer.alert(result.exception.message, {
                                    icon: 2,
                                    title: "系统提示"
                                });
                            } else if (result) {
                                layer.msg("删除成功", {
                                    icon: 1,
                                    time: 500
                                }, function () {
                                    table.reload("LAY-app-device-list-reload");
                                });
                            } else {
                                layer.msg("删除失败！", {
                                    icon: 2,
                                    time: 2000
                                });
                            }
                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            layer.msg(jqXHR.responseText, {
                                time: 500,
                                icon: 5
                            });
                        }
                    });
                    top.layui.index.openTabsPage("<%=request.getContextPath() %>/equipment/deviceUpgrade/device_upgrade_list.jsp", "升级记录");
                    layer.close(index);
                    table.reload("LAY-app-device-list-reload");
                });

            }
        },
    };



    //批量选中
    $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function () {
        if ($(this).attr("data-field") === "0") return;
        $(this).siblings().eq(0).find("i").click();
    });
</script>
</body>
</html>