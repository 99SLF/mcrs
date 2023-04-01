<%@ page import="com.zimax.cap.party.IUserObject" %>
<%@ page import="com.zimax.cap.datacontext.DataContextManager" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 施林丰
  - Date: 2022-12-01 15:57:53
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>预警等级编辑</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <style>
        .layui-textarea {
            height: 5px !important;
            /*min-height: 60px!important;*/
        }
    </style>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <div class="layui-fluid">
        <div class="layui-card">
            <div class="layui-form-item layui-row layui-col-space10">
                <div class="layui-col-sm6">
                    <label class="layui-form-label"><span style="color:red">*</span>预警等级:</label>
                    <div class="layui-input-block">
                        <input type="hidden" name="id">
                        <input id="warnGrade" type="text" name="warnGrade" lay-verify="required"
                               placeholder="预警等级(必填)" autocomplete="off" class="layui-input">
                    </div>
                </div>
            </div>

            <div class="layui-form-item layui-row layui-col-space10">
                <div class="layui-col-sm12">
                    <label class="layui-form-label">备注:</label>
                    <div class="layui-input-block">
                     <textarea cols="50" rows="10" style="width:100%;height:100px" name="remark"
                               id="remark" autocomplete="off"
                               class="layui-textarea" lay-verify="remark"></textarea>
                    </div>
                </div>
            </div>

            <div class="layui-form-item layui-hide">
                <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit"
                       value="确认添加">
            </div>
            <div class="layui-card-body">
                <h2>推送对象</h2>
                <div class="layui-toolbar" id="toolbar" hidden="true">
                    <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i
                            class="layui-icon layui-icon-add-circle-fine"></i>新增推送对象
                    </button>
                </div>


                <table id="LAY-app-alarmRule-list" lay-filter="LAY-app-alarmRule-list"></table>

                <script type="text/html" id="table-alarmRule-list">
                    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
                            class="layui-icon layui-icon-delete"></i>删除</a>
                </script>
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
    var laydate = layui.laydate;
    var form = layui.form;
    var $ = layui.jquery;
    var table = layui.table;
    var submit = false;
    var isExist = false;
    var win = null;

    //全局参数
    var req_data;

    //功能名
    var funName = "list";

    var hiddenFields = [];
    function SetData(data) {
        win = data.win ? data.win : window;
        var data = data.data;
        form.val('layuiadmin-app-form-list', {
            "id": data.id,
            "warnGrade": data.warnGrade,
            "remark": data.remark,
        });
        table.reload('LAY-app-alarmRule-list-reload',{
            data : data.warnToUser
        });
    }
    form.render();

    $("#warnGrade").blur(function() {
        var warnGrade = $("#warnGrade").val();
        if (warnGrade != null && warnGrade != "") {
            $.ajax({
                url: "<%= request.getContextPath() %>/warnManage/isExist?warnGrade="+warnGrade,
                type: "GET",
                cache: false,
                contentType: "text/json",
                cache: false,
                success: function (text) {

                    if (text.data <2) {
                        isExist = false;
                    } else {
                        isExist = true;
                    }
                }
            });
        } else {
            return;
        }
    });

    //监听提交
    form.on("submit(layuiadmin-app-form-submit)", function (data) {
        var alarmRule = data.field;
        var Data = table.cache["LAY-app-alarmRule-list-reload"];
        var warnToUser = Data;
        alarmRule.warnToUser = warnToUser;
        var submitData = JSON.stringify(alarmRule);
        if (submit == false) {
            submit = true;
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/warnManage/updateWarn",
                    type: "POST",
                    data: submitData,
                    cache: false,
                    contentType: "text/json",
                    success: function (result) {
                        layer.msg("更新成功", {
                            icon: 1,
                            time: 500
                        }, function () {
                            var index = parent.layer.getFrameIndex(window.name);
                            win.layui.table.reload("LAY-app-alarmEvent-list-reload");
                            top.layer.close(index);
                            win.window.formReder();
                        });
                    }
                });
            }else if (isExist == true) {
                layer.msg("预警等级已存在，请重新输入", {
                    icon: 2,
                    time: 2000
                });
                submit = false;
            }
        } else {
            layer.msg("正在添加...请稍等！");
        }
        return false;
    });

    table.on('sort(LAY-app-alarmRule-list)', function (obj) {
        table.reload('LAY-app-alarmRule-list-reload', {
            initSort: obj,
            where: {
                sortField: obj.field,
                sortOrder: obj.type
            }
        });
    });

    //左侧表头按钮事件监听
    table.on("toolbar(LAY-app-alarmRule-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    //表格排序
    table.on("sort(LAY-app-alarmRule-list)", function (obj) {
        table.reload("LAY-app-alarmRule-list-reload", {
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
        table.reload("LAY-app-alarmRule-list-reload", {
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

    var active = {
        //设备新建
        add: function () {
            top.layer.open({
                type: 2,
                title: "选择推送对象",
                content: "<%= request.getContextPath() %>/coframe/rights/role/role_select.jsp",
                area: ["1000px", "560px"],
                resize: false,
                btn: ["确定", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        win: window,
                    };
                    //layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {

                    var tableData = layero.find("iframe")[0].contentWindow.getData();
                    table.reload("LAY-app-alarmRule-list-reload", {
                        data: tableData
                    });
                    top.layer.close(index);


                }
            });
        },
    };

    table.render({
        elem: "#LAY-app-alarmRule-list",
        id: "LAY-app-alarmRule-list-reload",
        height: "full-" + getFullSize(),
        data: [],
        height: 270 ,
        toolbar: "#toolbar",
        defaultToolbar: ["filter"],
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
            //     type: "checkbox"
            // }, {
            //     title: "序号",
            //     type: "numbers"
            // },{
            field: "roleCode",
            title: "角色代码",
            align: "center",
            minWidth: 120,
            hide: isHidden("roleCode")
        }, {
            field: "roleName",
            title: "角色名称",
            align: "center",
            minWidth: 120,
            hide: isHidden("roleName")
        }, {
            field: "roleDesc",
            title: "角色描述",
            align: "center",
            minWidth: 120,
            hide: isHidden("roleDesc")
        },{
            title: "操作",
            align: "center",
            fixed: "right",
            width: 100,
            toolbar: "#table-alarmRule-list"
        } ]]
    });

    table.on("tool(LAY-app-alarmRule-list)", function (obj) {
        if(obj.event == "del") {
            var Data = table.cache["LAY-app-alarmRule-list-reload"];
            if (obj.tr.data("index") >= -1) {
                Data.splice(obj.tr.data("index"), 1);	//根据索引删除当前行
                table.reload('LAY-app-alarmRule-list-reload',{
                    data : Data
                });
            }
        }
    })

</script>
</body>
</html>