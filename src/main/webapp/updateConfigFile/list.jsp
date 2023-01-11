<%--
  Created by IntelliJ IDEA.
  User: 王广玉
  Date: 2023/1/11
  Time: 13:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>配置文件列表</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/custom.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/layout.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/iconfont/iconfont.css">
</head>
<body>
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-form-item">
                <h1>配置文件列表</h1>
            </div>
            <div class="layui-form-item">
                <button class="layui-btn layui-btn" lay-submit lay-filter="add" lay-event="add" title="新增配置文件">新增配置文件</button>
            </div>

        </div>
        <div class="layui-card-body">
            <table id="config-file-list" lay-filter="config-file-list"></table>
            <script type="text/html" id="table-config-file-list">
                <a class="layui-btn layui-btn layui-btn-xs" lay-event="edit">修改</a>
                <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del">删除</a>
            </script>
        </div>
    </div>
</div>

<script src="<%=request.getContextPath()%>/common/layui/layui.all.js"></script>
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
    //过滤字段
    var hiddenFields = [];
    //功能名
    var funName = "config_file";
    //var appId = null;
    var appId = "001";

    function SetData(data) {
        win = obj.win ? obj.win : window;
        appId = obj.appId ? obj.appId : null;
    }


    //新增
    form.on("submit(add)", function(rel) {
        var url = '<%=request.getContextPath() %>/updateConfigFile/add.jsp';
        top.layer.open({
            type: 2,
            title: "新增配置文件",
            content: [url, 'yes'],
            area: ['800px', '220px'],
            resize: false,
            maxmin: true,
            btn: ["确定", "取消"],
            success: function(layero, index) {
                var dataJson = {
                    win: window,
                    appId: appId
                };
                layero.find("iframe")[0].contentWindow.SetData(dataJson);
            },
            yes: function(index, layero) {
                var submit = layero.find('iframe').contents().find("#save_data");
                submit.click();
            }
        });
    });


    function getFullSize() {
        var fluid = $(".layui-fluid");
        var header = $(".layui-card-header");
        var cardbody = $(".layui-card-body");
        var size = 2;
        size += (fluid.outerHeight(true) - fluid.height());
        size += header.outerHeight(true);
        size += (cardbody.outerHeight(true) - cardbody.height());
        return size;
    }

    //表格排序
    table.on('sort(config-file-list)', function(obj){
        table.reload('tableReload', {
            initSort: obj ,
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
            if (hiddenFields[i].field == field ) {
                return true;
            }
        }
        return false;
    }

    //单号规则维护表格渲染
    table.render({
        elem:'#config-file-list',
        id:'tableReload',
        url: "<%=request.getContextPath() %>/updateConfig/query",
        where: {
            appId: appId
        },
        method:"GET",
        title: '配置文件列表',
        page: true,
        height: "full-" + getFullSize(),
        limit: 10,
        limits: [10, 15, 20, 30],
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
        defaultToolbar: [""],
        parseData: function(res) {
            return {
                code: res.code,
                msg: res.msg,
                count: res.total,
                data: res.data
            };
        },
        cols:[[{
            title:'序号',
            type:'numbers',
            hide:false
        }, {
            field:'fileName',
            title:'文件名',
            align:'center',
            minWidth: 220,
            hide: isHidden("fileName"),
            sort: true
        }, {
            field:'configPath',
            title:'终端文件获取路径',
            align:'center',
            minWidth: 220,
            hide: isHidden("configPath"),
            sort: true
        }, {
            field:'fileStatus',
            title:'配置文件状态',
            align:'center',
            hide: isHidden("fileStatus"),
            minWidth: 200,
            sort: true,
            templet: function (d) {
                return  layui.admin.getDictText("FileStatus", d.fileStatus);
            }
        }, {
            field:'creator',
            title:'配置人',
            align:'center',
            hide: isHidden("creator"),
            minWidth: 160,
            sort: true
        },  {
            field:'terminalTime',
            title:'终端配置时间',
            align:'center',
            hide: isHidden("terminalTime"),
            minWidth: 160,
            sort: true
        }, {
            field:'webTime',
            title:'Web更新时间',
            align:'center',
            hide: isHidden("webTime"),
            minWidth: 160,
            sort: true
        },  {
            title: "操作",
            align: "center",
            fixed: "right",
            minWidth: 150,
            toolbar: "#table-config-file-list"
        }]]
    });

    $(window).resize(function () {
        table.reload("tableReload", {
            height: "full-" + getFullSize()
        });
    });

    table.on('toolbar(config-file-list)', function(obj){
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    //监听工具栏按钮事件
    table.on('tool(config-file-list)', function(obj) {
        var data = obj.data;
        if (obj.event == "edit") {
            var fileCont = null;

            var configurationFile = JSON.stringify(obj.data);
            $.ajax({
                url: "<%=request.getContextPath() %>/updateConfig/getfile",
                type: 'post',
                data: configurationFile,
                cache: false,
                async: false,
                contentType: 'text/json',
                success: function (result) {
                    if (result.code == "200") {
                        fileCont = result.data;
                    } else {
                       return;
                    }
                }
            });
            var url = '<%=request.getContextPath() %>/updateConfigFile/edit.jsp';
            top.layer.open({
                type: 2,
                title: "修改配置文件",
                content: [url, 'yes'],
                area: ['800px', '520px'],
                resize: false,
                maxmin: true,
                btn: ["确定", "取消"],
                success: function(layero, index) {
                    var dataJson = {
                        fileCont : fileCont,
                        data: obj.data,
                        win: window
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function(index, layero) {
                    top.layer.confirm('修改会导致终端重新启动，是否确定修改？', {icon: 3, title:'系统提示'}, function(index) {
                        var submit = layero.find('iframe').contents().find("#save_data");
                        submit.click();
                        top.layer.close(index);
                    });
                }
            });
        }else if (obj.event == "del") {
            top.layer.confirm('是否确定删除？', {icon: 3, title:'系统提示'}, function(index) {
                var configurationFile = JSON.stringify(obj.data);
                $.ajax({
                    url: "<%=request.getContextPath() %>/updateConfig/del",
                    type: 'delete',
                    data: configurationFile,
                    cache: false,
                    contentType: 'text/json',
                    success: function (result) {
                        if (result.code == "200") {
                            layer.msg(result.msg, {icon: 1, time: 1500}, function () {
                                table.reload('tableReload');
                                top.layer.close(index);
                            });
                        } else {
                            layer.msg(result.msg, {icon: 2, time: 1500}, function () {
                                table.reload('tableReload');
                                top.layer.close(index);
                            });
                        }
                    }
                });
            });
        }
    });

    /* //删除部件
    form.on("submit(deleteCoding)", function(rel) {
        var checkStatus = table.checkStatus('tableReload');
        var data = checkStatus.data;
        if(data.length == 0) {
            top.layer.alert('请至少选中一条记录！',{icon: 2, title:'系统提示'});
        }else {
            top.layer.confirm('确定删除？', {icon: 3, title:'系统提示'}, function(index) {
                $.ajax({
                    url: "com.zimax.mes.basic.SerialNumber.deleteSerial.biz.ext",
                    type: 'POST',
                    data: JSON.stringify({serials : data}),
                    cache: false,
                    contentType: 'text/json',
                    success: function(result) {
                        if(result.code == 0){
                            top.layer.close(index);
                            layer.msg(result.msg,{icon:1,time:2000},function() {
                                table.reload('tableReload', {
                                    page: {
                                        curr: 1
                                    }
                                });
                            });
                        } else {
                            top.layer.close(index);
                            layer.msg(result.msg,{icon:2,time:2000},function() {
                                table.reload('tableReload', {
                                    page: {
                                        curr: 1
                                    }
                                });
                            });
                        }
                    },
                    error: function (result) {
                        top.layer.alert("未找到数据", {icon: 2, title:'系统提示'});
                    }
                });
            });
        }
    }); */

    //表格复选框选中事件
    table.on('checkbox(config-file-list)', function(obj){
        if(obj.type === "one"){
            if(obj.checked){
                obj.tr.addClass('layui-bg-blue');
            } else {
                obj.tr.removeClass('layui-bg-blue');
            }
        } else if(obj.type === "all"){
            $(".layui-table-body table.layui-table tbody tr").each(function(i){
                if(obj.checked){
                    $(this).addClass('layui-bg-blue');
                } else {
                    $(this).removeClass('layui-bg-blue');
                }
            });
        }

    });

    //单击行事件
    $('body').on("click", ".layui-table-body table.layui-table tbody tr td", function () {
        if ($(this).attr("data-field") === "0")
            return;
        $(this).siblings().eq(0).find('i').click();
    });

</script>
</body>
</html>
