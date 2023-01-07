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
                        <select name="deviceSoType" id="deviceSoType" lay-filter="deviceSoType"
                                 type="select">
                            <option value=""></option>
                        </select>
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
            <div class="layui-toolbar" id="toolbar" hidden="true">
                <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i
                        class="layui-icon layui-icon-add-circle-fine"></i>上传
                </button>
                <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel"><i
                        class="layui-icon layui-icon-delete"></i>删除
                </button>

            </div>

            <table id="LAY-app-device-list" lay-filter="LAY-app-device-list"></table>

            <script type="text/html" id="table-device-list">
<%--                方法一--%>
<%--                <a href="<%= request.getContextPath() %>/upload/download" class="layui-btn layui-btn-normal layui-btn-xs" lay-event=""><i--%>

                    <a  class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
                        class="layui-icon layui-icon-edit" ></i>下载</a>

                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
                        class="layui-icon layui-icon-delete"></i>删除</a>
            </script>
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

    layui.admin.renderDictSelect({    //获取终端软件类型
        elem: "#deviceSoType",
        dictTypeId: "DEVICE_SOFTWARE_TYPE",
    });
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

    var active = {
        //更新包上传
        add: function () {
            top.layer.open({
                type: 2,
                title: "上传",
                content: "<%= request.getContextPath() %>/update/update_package_uploads.jsp",
                area: ["800px", "560px"],
                resize: false,
                btn: ["确定", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        win: window,
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    debugger;
                    var submit = layero.find("iframe").contents().find("#layuiadmin-app-form-submit");
                    submit.click();

                }
            });
        },
        //批量删除
        batchdel: function () {
            var checkStatus = table.checkStatus("LAY-app-device-list-reload");
            var data = checkStatus.data;
            if (data.length == 0) {
                layer.msg("请至少选中一条记录！");
            }
            if (data.length > 0) {
                var uploadIds = new Array();
                for (var i = 0; i < data.length; i++) {
                    uploadIds[i] = data[i].uploadId;
                }
                layer.confirm("确定删除所选中更新包文件信息？", {
                    icon: 3,
                    title: "系统提示"
                }, function (index) {
                    $.ajax({
                        url: "<%= request.getContextPath() %>/upload/batchDelete",
                        type: "DELETE",
                        data: JSON.stringify(uploadIds),
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
                                    time: 2000
                                }, function () {
                                    table.reload("LAY-app-device-list-reload");
                                });
                            } else {
                                layer.msg("删除失败");
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            layer.msg(jqXHR.responseText, {
                                time: 2000,
                                icon: 5
                            });
                        }
                    });
                });
            }
        },
    };

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
        return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + (fluid.outerHeight(true) - fluid.height()) + 2;
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
            minWidth: 180,
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
            field: "deviceSoType",
            title: "终端软件类型",
            align: "center",
            minWidth: 150,
            hide: isHidden("deviceSoType"),
            templet:function(d) {

                return layui.admin.getDictText("DEVICE_SOFTWARE_TYPE", d.deviceSoType);
            }
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
            field: "fileName",
            title: "更新包",
            align: "center",
            minWidth: 150,
            hide: isHidden("fileName")

        }, {
            field: "uploader",
            title: "上传人",
            align: "center",
            minWidth: 150,
            hide: isHidden("uploader")
        }, {
            field: "versionUploadTime",
            title: "上传时间",
            align: "center",
            minWidth: 200,
            hide: isHidden("versionUploadTime"),
            templet:function (data) {
             return layui.util.toDateString(data.versionUploadTime, "yyyy-MM-dd HH:mm:ss");
            }
        }, {
            field: "remarks",
            title: "备注",
            align: "center",
            minWidth: 120,
            hide: isHidden("remarks")
        }, {
            title: "操作",
            align: "center",
            fixed: "right",
            width: 150,
            toolbar: "#table-device-list"
        }
        ]]
    });

    //监听操作事件
    table.on("tool(LAY-app-device-list)", function (e) {
        //当前行数据
        debugger;
        var data = e.data;
        //edit 下载
        if (e.event == "edit") {
            var filePath = encodeURIComponent(e.data.downloadUrl);
            var filename = encodeURIComponent(e.data.fileName);
            //var url = "<%= request.getContextPath() %>/upload/download?filePath=" + filePath ;
            var url =  "<%= request.getContextPath() %>/update/loaderInterface?APPId=1";
            //创建a标签，用于点击
            var a = document.createElement("a");
                a.download = filename;
                a.href = url;
                //兼容firefox
                $('body').append(a);
                a.click();
                $(a).remove();
        } else if (e.event == "del") {
            //删除
            layer.confirm("确定删除该条资源信息单号？", {
                icon: 3,
                title: "系统提示"
            }, function (index) {
                var uploadIds =new Array();
                uploadIds[0] = data.uploadId;
                $.ajax({
                    url: "<%= request.getContextPath() %>/upload/batchDelete",
                    type: "DElETE",
                    data: JSON.stringify(uploadIds),
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
            });
        }
        else if (e.event == "view") {
            top.layer.open({
                type: 2,
                title: "查看更新包详情",
                content: "<%= request.getContextPath() %>/update/update_package_detailed.jsp",
                area: ["800px", "560px"],
                resize: false,
                btn: ["确定", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        data: data,
                        win: window
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    var edit = layero.find("iframe").contents().find("#layuiadmin-app-form-edit");
                    edit.click();
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