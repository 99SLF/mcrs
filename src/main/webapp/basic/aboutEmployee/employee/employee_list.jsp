<%@page pageEncoding="UTF-8" %>
<%--<%@page import="com.mes.foundation.eoscommon.ResourcesMessageUtil"%>--%>
<!DOCTYPE html>
<html>
<!--
  User: chen
  Date: 2023/6/14
  Time: 8:59
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>员工管理</title>
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
        <div class="layui-form layuiadmin-card-header-auto" lay-filter="layuiadmin-user-form"
             id="layuiadmin-user-form">
            <%--给租户id默认值--%>
            <input type="hidden" name="tenantId" value="default">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">工号：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="jobNo" placeholder="" autocomplete="off" class="layui-input">
                    </div>
                </div>
                <div class="layui-inline layui-hide">
                    <button id="LAY-app-employee-list-search"
                            class="layui-btn layuiadmin-btn-list"
                            lay-submit lay-filter="LAY-app-employee-list-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </script>
    <div class="layui-card-body">
        <%--        <div class="layui-toolbar" id="toolbar" hidden="true">--%>
        <%--            <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i--%>
        <%--                    class="layui-icon layui-icon-add-circle-fine"></i>添加--%>
        <%--            </button>--%>
        <%--            <button class="layui-btn layuiadmin-btn-list layui-btn-warm layui-btn-sm" lay-event="auth"><i--%>
        <%--                    class="layui-icon layui-icon-survey"></i>权限配置--%>
        <%--            </button>--%>
        <%--            <button class="layui-btn layuiadmin-btn-list layui-btn-primary layui-btn-sm" lay-event="authCalculate"><i--%>
        <%--                    class="layui-icon layui-icon-survey"></i>权限计算--%>
        <%--            </button>--%>
        <%--            <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="resetPassword"><i--%>
        <%--                    class="layui-icon layui-icon-read"></i>重置密码--%>
        <%--            </button>--%>
        <%--            <button class="layui-btn layuiadmin-btn-list layui-btn-danger layui-btn-sm" lay-event="batchdel"><i--%>
        <%--                    class="layui-icon layui-icon-delete"></i>删除--%>
        <%--            </button>--%>
        <%--        </div>--%>
        <table id="LAY-app-user-list" lay-filter="LAY-app-user-list"></table>
        <script type="text/html" id="table-user-list">
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
    var funName = "user_list";

    var hiddenFields = [];

    //全加载：日期
    var laydate = layui.laydate;
    var isExits = false;

    // 焦点名称
    var focusName = null;

    // 高级查询参数
    var advancedFormData = {};


    //监听搜索
    form.on("submit(LAY-app-employee-list-search)", function (data) {

        var field = data.field;
        reloadData(field);
        var formData = {
            jobNo: field.jobNo
            // roleNameList: field.roleNameList,
            // userType: field.userType
        };

        //设置整个表单数据 layuiadmin-update_package-form
        form.val("layuiadmin-user-form", formData);
        advancedFormData = $.extend(advancedFormData, formData);


        // table.reload("LAY-app-device-list-reload", {
        //     where: field
        // });
    });

    function reloadData(formData) {

        //读取表格数据 表格id LAY-app-update_package-list-reload
        table.reload("LAY-app-user-list-reload", {
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
        form.val("layuiadmin-accPoint-form", {
            jobNo: data.jobNo
            // userName: data.userName,
            // roleNameList: data.roleNameList,
            // userType: data.userType
        });
    }


    var active = {
        search: function () {
            //点击搜索
            var submit = $("#LAY-app-employee-list-search");
            submit.click();
            return false;
        },
        // 添加用户
        add: function () {
            top.layer.open({
                type: 2,
                title: "添加用户",
                content: "<%= request.getContextPath() %>/basic/aboutEmployee/employee/employee_add.jsp",
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
        auth: function () {
            var checkStatus = table.checkStatus("LAY-app-user-list-reload");
            var data = checkStatus.data;
            req_data = data;
            if (data.length == 0) {
                layer.msg("请至少选中一条记录！");
            } else if (data.length > 1) {
                layer.msg("最多只能选中一条记录！");
            } else {
                var jobId = data[0].jobId;
                // 权限配置路径
                var url = "<%= request.getContextPath() %>/basic/aboutEmployee/employee/employee_auth.jsp";
                top.layer.open({ //开启弹窗
                    type: 2,
                    title: "员工授权",
                    btn: ["关闭"],
                    closeBtn: '',
                    area: ["650px", "510px"],
                    resize: false,
                    content: [url, "yes"], //弹窗不出现滚动条
                    success: function (layero, index) {
                        var dataJson = {
                            win: window,
                            jobId: jobId
                        };
                        layero.find("iframe")[0].contentWindow.SetData(dataJson);

                    }
                });
            }
        },
    };


    table.on('sort(LAY-app-user-list)', function (obj) {
        table.reload('LAY-app-user-list-reload', {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
    });

    //左侧表头按钮事件监听
    table.on("toolbar(LAY-app-user-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    //表格排序
    table.on("sort(LAY-app-user-list)", function (obj) {
        table.reload("LAY-app-user-list-reload", {
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
        table.reload("LAY-app-user-list-reload", {
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
        elem: "#LAY-app-user-list",
        id: "LAY-app-user-list-reload",
        <%--url: "<%=request.getContextPath() %>/user/query",--%>
        url: "<%=request.getContextPath() %>/EmpController/query",
        method: "get",
        height: "full-" + getFullSize(),
        page: true,
        limit: 10,
        /*分页*/
        limits: [10, 15, 20, 30],
        toolbar: "#toolbar",
        defaultToolbar: [{
            title: "查询",
            layEvent: "search",
            icon: "layui-icon layui-icon-search layuiadmin-button-btn",
        },  {
            title: "新增员工",
            layEvent: "add",
            icon: "layui-icon layui-icon-add-circle",
        }, {
            title: "权限配置",
            layEvent: "auth",
            icon: "layui-icon layui-icon-auz ",
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
        parseData: function (res) {
            return {
                code: res.code,
                msg: res.msg,
                count: res.total,
                data: res.data //统一接口返回数据
            };
        },
        cols: [[{
            type: "checkbox",
        }, {
            title: "序号",
            type: "numbers"
        }, {
            field: "jobNo",
            title: "工号",
            align: "center",
            sort: true,
            event: "view",
            hide: isHidden("jobNo"),
            minWidth: 100,
            //监听打开详情页面
            // templet: function (d) {
            //     return '<span style="color: #09bbfd">' + d.userId + '</span>';
            // }
        }, {
            field: "grade",
            title: "等级",
            align: "center",
            sort: true,
            hide: isHidden("grade"),
            minWidth: 120
        }, {
            field: "roleNameList",
            title: "角色名称",
            align: "center",
            sort: true,
            hide: isHidden("roleNameList"),
            minWidth: 120,
            // templet: function (d) {
            //     return layui.admin.getDictText("USER_TYPE", d.userType);
            // }
        }, {
            field: "userName",
            title: "创建人",
            align: "center",
            hide: isHidden("userName"),
            minWidth: 100
        }, {
            field: "createTime",
            title: "创建时间",
            align: "left",
            hide: isHidden("createTime"),
            minWidth: 100,
            templet: function(d) {
                // 将 createTime 格式化为 yyyy-MM-dd
                return layui.util.toDateString(d.createTime, 'yyyy-MM-dd HH:mm:ss');
            }
        }, {
            title: "操作",
            align: "center",
            width: 160,
            toolbar: "#table-user-list"
        }]]
    });

    formReder();

    function formReder() {
        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-employee-list-search");
                submit.click();
                return false;
            }
        });



        form.render();
    }


    //监听操作事件
    table.on("tool(LAY-app-user-list)", function (e) {
        $('#authBtn').addClass("layui-btn-disabled").attr("disabled", true);
        var data = e.data;
        if (e.event == "edit") {
            top.layer.open({
                type: 2,
                title: "编辑用户",
                content: "<%= request.getContextPath() %>/basic/aboutEmployee/employee/employee_update.jsp",
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
        } else if (e.event == "view") {
            top.layer.open({
                type: 2,
                title: "查看用户详情",
                content: "<%= request.getContextPath() %>/coframe/rights/user/user_view.jsp",
                area: ["800px", "500px"],
                resize: false,
                btn: ["关闭"],
                closeBtn: '',
                success: function (layero, index) {

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
        } else if (e.event == "del") {
            layer.confirm("确定删除该用户？", {
                icon: 3,
                title: "系统提示"
            }, function (index) {
                var jobId = 0;
                jobId = data.jobId;
                $.ajax({
                    url: "<%= request.getContextPath() %>/EmpController/delete?jobId="+ jobId,
                    type: "DELETE",
                    // data: JSON.stringify(jobId),
                    cache: false,
                    contentType: "text/json",
                    success: function (result) {
                        if (result){
                            layer.msg("删除成功", {
                                icon: 1,
                                time: 2000
                            }, function () {
                                table.reload("LAY-app-user-list-reload");
                            });
                        } else if (result.exception){
                            layer.alert(result.exception.message, {
                                icon: 2,
                                title: "系统提示"
                            });
                        }else {
                            layer.msg("删除失败！", {
                                icon: 2,
                                time: 2000
                            });
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
    });

    $(window).resize(function () {
        table.reload("LAY-app-user-list-reload", {
            height: "full-" + getFullSize()
        });
    });

    //批量选中
    $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function () {
        if ($(this).attr("data-field") === "0") return;
        $(this).siblings().eq(0).find("i").click();
    });
</script>
</body>
</html>