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
    <title>系统文件</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">

</head>
<body>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-card-body">
            <table id="LAY-app-device-list" lay-filter="LAY-app-device-list"></table>
            <script type="text/html" id="table-device-list">
                <a  class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
                        class="layui-icon layui-icon-edit" ></i>修改</a>
                <a  class="layui-btn layui-btn-normal layui-btn-xs" lay-event="download"><i
                        class="layui-icon layui-icon-del" ></i>下载</a>
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
<%--字典--%>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script type="text/javascript">
    var layer = layui.layer;
    var table = layui.table;
    var form = layui.form;
    var $ = layui.jquery;
    var util = layui.util;
    //全局参数
    var req_data;

    //功能名，查询过滤字段和列筛选
    var funName = "list";

    var hiddenFields = [];


    //数据字典项加载
    form.render();

    var active = {
        //更新包上传
        add: function () {
            top.layer.open({
                type: 2,
                title: "上传",
                content: "<%= request.getContextPath() %>/aboutSystem/system_file_upload.jsp",
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
                    var submit = layero.find("iframe").contents().find("#layuiadmin-app-form-submit");
                    submit.click();

                }
            });
        },
    };

    //左侧表头按钮事件监听
    table.on("toolbar(LAY-app-device-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
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


    table.render({
        elem: "#LAY-app-device-list",
        id: "LAY-app-device-list-reload",
        url: "<%= request.getContextPath() %>/systemFile/querySystemFile",
        method: "GET",
        height: "full-" + getFullSize(),
        limit: 3,
        defaultToolbar: [""],
        parseData: function (res) {
            return {
                code: res.code,
                msg: res.msg,
                count: res.data.length,
                data: res.data
            };
        },
        cols: [[{
            title: "序号",
            type: "numbers",
        },{
            field: "fileName",
            title: "文件名",
            align: "center",
            minWidth: 180
        }, {
            field: "version",
            title: "版本号",
            align: "center",
            minWidth: 80,
        }, {
            field: "creator",
            title: "上传人 ",
            align: "center",
        }, {
            field: "createTime",
            title: "上传时间",
            align: "center",
            minWidth: 120,
        }, {
            field: "remark",
            title: "备注",
            align: "center",
            minWidth: 150,
        },{
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
        var data = e.data;
        //edit 下载
        if (e.event == "download") {
            var filePath = encodeURIComponent(e.data.downloadUrl);
            var filename = encodeURIComponent(e.data.fileName);
            var url = "<%= request.getContextPath() %>/upload/download?filePath=" + filePath ;
            //var url =  "<%= request.getContextPath() %>/update/loaderInterface?APPId=1";
            //创建a标签，用于点击
            var a = document.createElement("a");
            a.download = filename;
            a.href = url;
            //兼容firefox
            $('body').append(a);
            a.click();
            $(a).remove();
        } else if (e.event == "edit") {
            top.layer.open({
                type: 2,
                title: "上传",
                content: "<%= request.getContextPath() %>/aboutSystem/system_file_upload.jsp",
                area: ["800px", "560px"],
                resize: false,
                btn: ["确定", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        win: window,
                        fileId: data.fileId
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    var submit = layero.find("iframe").contents().find("#layuiadmin-app-form-submit");
                    submit.click();

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