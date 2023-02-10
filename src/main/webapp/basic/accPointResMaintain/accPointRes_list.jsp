<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2022-12-21 16:11:58
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>接入点信息维护</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
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
        <div class="layui-form layuiadmin-card-header-auto" lay-filter="layuiadmin-accPoint-form"
             id="layuiadmin-accPoint-form">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">接入点代码：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="accPointResCode" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">接入点名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="accPointResName" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">启用：</label>
                    <div class="layui-input-inline">
                        <select name="isEnable" id="isEnable" lay-filter="isEnable"
                                type="select">
                            <option value=""></option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline layui-hide">
                    <button id="LAY-app-accPoint-list-search"
                            class="layui-btn layuiadmin-btn-list"
                            lay-submit lay-filter="LAY-app-accPoint-list-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </script>
    <div class="layui-card-body">
        <table id="LAY-app-accPoint-list" lay-filter="LAY-app-accPoint-list"></table>
        <script type="text/html" id="table-accPoint-list">
            <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
                    class="layui-icon layui-icon-edit"></i>编辑</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
                    class="layui-icon layui-icon-delete"></i>删除</a>
        </script>
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
    var admin = layui.admin;
    var view = layui.view;

    //全局参数
    var req_data;

    //功能名
    var funName = "list";

    var hiddenFields = [];

    //全加载：日期
    var laydate = layui.laydate;
    var isExits = false;

    // 焦点名称
    var focusName = null;

    // 高级查询参数
    var advancedFormData = {};


    //监听搜索
    form.on("submit(LAY-app-accPoint-list-search)", function (data) {

        var field = data.field;
        reloadData(field);
        var formData = {
            accPointResCode: field.accPointResCode,
            accPointResName: field.accPointResName,
            isEnable: field.isEnable
        };

        //设置整个表单数据 layuiadmin-update_package-form
        form.val("layuiadmin-accPoint-form", formData);
        advancedFormData = $.extend(advancedFormData, formData);


        // table.reload("LAY-app-device-list-reload", {
        //     where: field
        // });
    });

    function reloadData(formData) {

        //读取表格数据 表格id LAY-app-update_package-list-reload
        table.reload("LAY-app-accPoint-list-reload", {
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
        //将设置整个表单的数据
        form.val("layuiadmin-accPoint-form", {
            accPointResCode: data.accPointResCode,
            accPointResName: data.accPointResName,
            isEnable: data.isEnable
        });
    }

    var active = {
        search: function () {
            //点击搜索
            var submit = $("#LAY-app-accPoint-list-search");
            submit.click();
            return false;
        },
        //高级搜索
        query: function () {
            var url = "<%=request.getContextPath() %>/basic/accPointResMaintain/accPointRes_form_query.jsp";
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
                    var submit = layero.find("iframe").contents().find("#LAY-app-accPoint-search-advanced");
                    submit.click();
                    top.layer.close(index);
                },
                btn2: function (index, layero) {
                    layero.find("iframe")[0].contentWindow.reset();
                }
            });
        },
        add: function () {
            top.layer.open({
                type: 2,
                title: "新增接入点信息",
                content: "<%= request.getContextPath() %>/basic/accPointResMaintain/accPointRes_add.jsp",
                area: ["800px", "500px"],
                resize: false,
                btn: ["确定", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        win: window,
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    var submit = layero.find("iframe").contents().find("#layuiadmin-app-form-submit");
                    submit.click();
                }
            });
        },
        //批量删除
        batchdel: function () {
            var checkStatus = table.checkStatus("LAY-app-accPoint-list-reload");
            var data = checkStatus.data;
            if (data.length == 0) {
                layer.msg("请至少选中一条记录！");
            }
            if (data.length > 0) {
                var accPointResIds = new Array();
                for (var i = 0; i < data.length; i++) {
                    accPointResIds[i] = data[i].accPointResId;
                }
                layer.confirm("确定删除所选接入点信息？", {
                    icon: 3,
                    title: "系统提示"
                }, function (index) {
                    $.ajax({
                        url: "<%= request.getContextPath() %>/accPointResController/batchDelete",
                        type: "DELETE",
                        data: JSON.stringify(accPointResIds),
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
                                    table.reload("LAY-app-accPoint-list-reload");
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
        enable: function () {
            var checkStatus = table.checkStatus("LAY-app-accPoint-list-reload");
            var data = checkStatus.data;
            if (data.length == 0) {
                layer.msg("请至少选中一条记录！");
            }
            for (i = 0; i < data.length; i++) {
                debugger;
                if (data[i].isEnable == "101") {
                    isExits = true;
                    break;
                }
                isExits = false
            }
            if (isExits == false) {
                if (data.length > 0) {
                    var accPointResIds = new Array();
                    for (var i = 0; i < data.length; i++) {
                        accPointResIds[i] = data[i].accPointResId;
                    }
                    layer.confirm("确定启用所选接入点信息？", {
                        icon: 3,
                        title: "系统提示"
                    }, function (index) {
                        $.ajax({
                            url: "<%= request.getContextPath() %>/accPointResController/accPointRes/enable",
                            type: "POSt",
                            data: JSON.stringify(accPointResIds),
                            cache: false,
                            contentType: "text/json",
                            success: function (result) {
                                if (result.exception) {
                                    layer.alert(result.exception.message, {
                                        icon: 2,
                                        title: "系统提示"
                                    });
                                } else if (result) {
                                    layer.msg("启用成功", {
                                        icon: 1,
                                        time: 2000
                                    }, function () {
                                        table.reload("LAY-app-accPoint-list-reload");
                                    });
                                } else {
                                    layer.msg("启用失败");
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
            } else if (isExits == true) {
                layer.msg("当前接入点已启用");
            } else {
                layer.msg("启用失败");
            }
        }
    };

    table.on('sort(LAY-app-accPoint-list)', function (obj) {
        table.reload('LAY-app-accPoint-list-reload', {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
    });

    //左侧表头按钮事件监听
    table.on("toolbar(LAY-app-accPoint-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    //表格排序
    table.on("sort(LAY-app-accPoint-list)", function (obj) {
        table.reload("LAY-app-accPoint-list-reload", {
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
        table.reload("LAY-app-accPoint-list-reload", {
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

    // 查询
    table.render({
        elem: "#LAY-app-accPoint-list",
        id: "LAY-app-accPoint-list-reload",
        url: "<%= request.getContextPath() %>/accPointResController/query",
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
        }, {
            title: "新增接入点",
            layEvent: "add",
            icon: "layui-icon layui-icon-add-circle",
        }, {
            title: "批量删除",
            layEvent: "batchdel",
            icon: "layui-icon layui-icon-delete ",
        }, {
            title: "启用接入点",
            layEvent: "enable",
            icon: "layui-icon layui-icon-ok-circle",
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

        //编辑的是表单d的数据，只要在接口中铺垫出所有的数据就可以了（需要初始化下拉选择框的除外）
        cols: [[{
            type: "checkbox"
        }, {
            title: "序号",
            type: "numbers"
        }, {
            field: "accPointResCode",
            title: '接入点代码',
            align: "center",
            minWidth: 150,
            //打开监听
            event: "view",
            hide: isHidden("accPointResCode"),
            //监听打开详情页面
            templet: function (d) {
                return '<span style="color: #09bbfd">' + d.accPointResCode + '</span>';
            }
        }, {
            field: "accPointResName",
            title: "接入点名称",
            align: "center",
            minWidth: 150,
            hide: isHidden("accPointResName")
        }, {
            field: "isEnable",
            title: "启用",
            align: "center",
            minWidth: 60,
            hide: isHidden("isEnable"),
            templet: function (d) {

                return layui.admin.getDictText("IS_USE", d.isEnable);
            }
        }, {
            field: "matrixCode",
            title: "基地代码",
            align: "center",
            minWidth: 150,
            hide: isHidden("matrixCode")
        },
            //     {
            //     field: "matrixName",
            //     title: "基地名称",
            //     align: "center",
            //     minWidth: 150,
            //     hide: true
            // },
            {
                field: "factoryCode",
                title: "工厂代码",
                align: "center",
                minWidth: 150,
                hide: isHidden("factoryCode")
            }, {
                field: "factoryName",
                title: "工厂名称",
                align: "center",
                minWidth: 150,
                hide: isHidden("factoryName")
            },
            //     {
            //     field: "processId",
            //     title: "工序Id",
            //     align: "center",
            //     minWidth: 60,
            //     hide: true
            // },
            {
                field: "processCode",
                title: "工序代码",
                align: "center",
                minWidth: 150,
                hide: isHidden("processCode")
            }, {
                field: "processName",
                title: "工序名称",
                align: "center",
                minWidth: 150,
                hide: isHidden("processName")
            }, {
                field: "processRemarks",
                title: "工序描述",
                align: "center",
                minWidth: 200,
                hide: isHidden("processRemarks")
            }, {
                field: "accCreatorName",
                title: "创建人",
                align: "center",
                minWidth: 150,
                hide: isHidden("accCreatorName")
            }, {
                field: "createTime",
                title: "创建时间",
                align: "center",
                minWidth: 200,
                hide: isHidden("createTime"),
                templet: function (data) {
                    return layui.util.toDateString(data.createTime, "yyyy-MM-dd HH:mm:ss");
                }
            }, {
                field: "accUpdaterName",
                title: "修改人",
                align: "center",
                minWidth: 150,
                hide: isHidden("accUpdaterName")
            }, {
                field: "updateTime",
                title: "修改时间",
                align: "center",
                minWidth: 200,
                hide: isHidden("updateTime"),
                templet: function (d) {
                    if (d.updateTime != null) {
                        return layui.util.toDateString(d.updateTime);
                    } else {
                        return '';
                    }

                }

            }, {
                title: "操作",
                align: "center",
                fixed: "right",
                width: 150,
                toolbar: "#table-accPoint-list"
            }]]
    });


    formReder();

    function formReder() {
        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-accPoint-list-search");
                submit.click();
                return false;
            }
        });

        //软件类型下拉框监听事件
        form.on("select(isEnable)", function (data) {
            var submit = $("#LAY-app-accPoint-list-search");
            submit.click();
        });

        layui.admin.renderDictSelect({
            elem: "#isEnable",
            dictTypeId: "IS_USE",
        });
        form.render();
    }

    //监听操作事件
    table.on("tool(LAY-app-accPoint-list)", function (e) {
        var data = e.data;
        if (e.event == "edit") {
            top.layer.open({
                type: 2,
                title: "编辑接入点信息维护",
                content: "<%= request.getContextPath() %>/basic/accPointResMaintain/accPointRes_edit.jsp",
                area: ["800px", "500px"],
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
        } else if (e.event == "del") {
            layer.confirm("确定删除该接入点信息？", {
                icon: 3,
                title: "系统提示"
            }, function (index) {
                var accPointResIds = new Array();
                accPointResIds[0] = data.accPointResId;
                $.ajax({
                    url: "<%= request.getContextPath() %>/accPointResController/batchDelete",
                    type: "DElETE",
                    data: JSON.stringify(accPointResIds),
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
                                table.reload("LAY-app-accPoint-list-reload");
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
        } else if (e.event == "view") {
            top.layer.open({
                type: 2,
                title: "查看接入点信息维护",
                content: "<%= request.getContextPath() %>/basic/accPointResMaintain/accPointRes_detailed.jsp",
                area: ["800px", "500px"],
                resize: false,
                btn: ["关闭"],
                success: function (layero, index) {
                    debugger;
                    var dataJson = {
                        data: data,
                        win: window
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
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