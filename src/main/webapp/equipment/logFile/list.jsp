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
    <title>日志文件</title>
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
                <div class="layui-inline">
                    <label class="layui-form-label">日志文件类型：</label>
                    <div class="layui-input-inline">
                        <select name="logType" id="logType" lay-filter="logType"
                                type="select">
                            <option value="showInfo">信息日志</option>
                            <option value="runException">异常日志</option>
                        </select>
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">查看时间：</label>
                    <div class="layui-input-inline">
                        <input id="logTime" type="text" class="layui-input" name="logTime" autocomplete="off" readonly/>
                    </div>
                </div>
                <div class="layui-inline layui-search">
                    <button class="layui-btn layui-btn-primary layui-btn-xs" lay-submit lay-filter="searchSubmit" id="search" title="搜索">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
        <div class="layui-card-body">
            <table id="config-file-list" lay-filter="config-file-list"></table>
            <script type="text/html" id="table-config-file-list">
                <a class="layui-btn layui-btn layui-btn-xs" lay-event="view">查看</a>
                <a class="layui-btn layui-btn-warm layui-btn-xs" lay-event="update">更新</a>
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
    var laydate = layui.laydate;
    var util = layui.util;
    //过滤字段
    var hiddenFields = [];
    //功能名
    var funName = "logFile";
    var currentdate = "";
    var equipmentIp;
    var equipmentId;
    var port;
    getNowFormatDate();
    function getNowFormatDate() {
        var time = new Date();
        currentdate= time.getFullYear() + '-' + (time.getMonth() + 1) + '-' + time.getDate();
    }
    form.render();
    // 开始时间选择器
    laydate.render({
        elem: "#logTime",
        type: "date",
        trigger: "click",
        format: "yyyy-M-d",
        max:currentdate
    });
    function SetData(obj) {
        win = obj.win ? obj.win : window;
        equipmentIp = obj.equipmentIp;
        equipmentId = obj.equipmentId;
        port = obj.port;
    }
    //监听普通搜索按钮点击事件
    form.on('submit(searchSubmit)', function(rel) {
        var rels=rel.field;
        if(rels.logType==null ||rels.logType==""||rels.logTime==null ||rels.logTime==""){
            top.layer.alert("请将数据填写完整", {icon: 7, title:'系统提示'});
            return;
        }
        var dataJson = {
            "equipmentIp":equipmentIp,
            "equipmentId": equipmentId,
            "port":port,
            "logType":rels.logType,
            "logTime":rels.logTime
        };

        table.reload('tableReload',{
            url:"<%= request.getContextPath() %>/logFile/queryLogFile",
            method:"GET",
            where: dataJson,
            page: {
                curr: 1
            },
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
        data: [],
        method:"GET",
        title: '日志文件列表',
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
            if(res.code==1){
                top.layer.alert(res.msg, {icon: 7, title:'系统提示'});
            }
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
            field:'logFileName',
            title:'日志文件名',
            align:'center',
            minWidth: 220,
            hide: isHidden("logFileName"),
        }, {
            field:'logType',
            title:'日志文件类型',
            align:'center',
            hide: isHidden("fileStatus"),
            minWidth: 200,
            templet: function (d) {
                return d.logType=="showInfo"?"信息日志":"异常日志"
            }
        }, {
            field:'logTime',
            title:'日志生成时间',
            align:'center',
            minWidth: 220,
            hide: isHidden("logTime"),
        },{
            field:'createTime',
            title:'创建时间',
            align:'center',
            hide: isHidden("createTime"),
            minWidth: 160,
            templet: function (d) {
                return layui.util.toDateString(d.createTime);
            }
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
        if (obj.event == "view") {
            var fileCont = null;
            var logFileString = JSON.stringify(obj.data);
            $.ajax({
                url: "<%=request.getContextPath() %>/logFile/getFile",
                type: 'post',
                data: logFileString,
                cache: false,
                async: false,
                contentType: 'text/json',
                success: function (result) {
                    if (result.code == "0") {
                        fileCont = result.data;
                    } else {
                       return;
                    }
                }
            });
            var url = '<%=request.getContextPath() %>/equipment/logFile/view.jsp';
            top.layer.open({
                type: 2,
                title: "查看日志文件",
                content: [url, 'yes'],
                area: ['800px', '520px'],
                resize: false,
                maxmin: true,
                btn: ["关闭"],
                success: function(layero, index) {
                    var dataJson = {
                        fileCont : fileCont,
                        data: obj.data,
                        win: window
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function(index, layero) {
                    top.layer.close(index);
                }
            });
        }else if (obj.event == "update") {
            top.layer.confirm('是否确定更新？', {icon: 3, title:'系统提示'}, function(index) {
                var dataLog = obj.data;
                dataLog.equipmentIp = equipmentIp;
                dataLog.port = port;
                var logFile = JSON.stringify(obj.data);
                $.ajax({
                    url: "<%=request.getContextPath() %>/logFile/updateLogFile",
                    type: 'POST',
                    data: logFile,
                    cache: false,
                    contentType: 'text/json',
                    success: function (result) {
                        if (result.code == "0") {
                            top.layer.close(index);
                            layer.msg(result.msg, {icon: 1, time: 1500}, function () {
                                table.reload('tableReload');
                            });
                        } else {
                            top.layer.close(index);
                            layer.msg(result.msg, {icon: 2, time: 1500});
                        }
                    }
                });
            });
        }
    });

    function disabledSubmitButton(submitButtonName){
        $("#"+submitButtonName).attr({"disabled":"disabled"});     //控制按钮为禁用
        var timeoutObj = setTimeout(function () {
            $("#"+submitButtonName).removeAttr("disabled");//将按钮可用
            /* 清除已设置的setTimeout对象 */
            clearTimeout(timeoutObj)
        }, 3000);
    }

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
