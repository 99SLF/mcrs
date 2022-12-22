<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>点位管理</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/custom.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/layout.css">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/iconfont/iconfont.css">
    <style>
        .layui-form-label{
            width: 120px;
        }
        .layui-input-block {
            margin-left: 130px;
            min-height: 36px
        }
    </style>

</head>
<body style="background-color: white;">
<div class="layui-fluid">
    <div class="layui-card">
        <div class="layui-form layui-card-header layuiadmin-card-header-auto">
            <div class="layui-row">
                <div class="layui-col-md4">
                    <h1>点位管理</h1>
                </div>
            </div>
        </div>
        <script type="text/html" id="toolbar">
            <div class="layui-form layui-card-header layuiadmin-card-header-auto" lay-filter="queryForm">
                <div class="layui-form-item">
                    <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="addPointDispose"><i
                            class="layui-icon layui-icon-add-circle-fine"></i>新建点位配置
                    </button>
                    <div class="layui-inline layui-search"style="float:right">
                        <button class="layui-btn layuiadmin-btn-list" lay-submit lay-filter="LAY-app-equipmentlist-search"
                                id="LAY-app-equipmentlist-search">
                            <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                        </button>
                    </div>
                    <div class="layui-inline" style="float:right">
                        <div class="layui-input-block">
                            <input type="text" name="equipmentName" id="equipmentName" placeholder="请输入终端名称" autocomplete="off" class="layui-input">
                        </div>
                    </div>

                </div>
            </div>
        </script>
        <div class="layui-card-body">
            <table id="pointDispose" lay-filter="pointDispose"></table>
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
    var submit = false;
    var isExist = false;
    var $ = layui.jquery;
    var reg=/^\d+$|^\d*\.\d+$/;
    var laydate = layui.laydate;
    form.render();
    //监听普通搜索按钮点击事件
    var funName = "point_list";
    //过滤字段
    var hiddenFields = [];
    table.on('sort(pointDispose)', function(obj){ //注：sort 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
        table.reload('pointDispose', {
            initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。
            ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                field: obj.field //排序字段
                ,order: obj.type //排序方式
            }
        });

    });
    //查询过滤字段
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

    //文本框回车事件
    $(".layui-input").on("keydown", function(event) {
        if (event.keyCode == 13) {
            var submit = $("#search");
            submit.click();
            return false;
        }
    });

    function getFullSize() {
        var fluid = $(".layui-fluid");
        var header = $(".layui-card-header");
        var cardbody = $(".layui-card-body");
        return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + (fluid.outerHeight(true) - fluid.height()) + 2;
    }
    $(window).resize(function () {
        table.reload("tableReload", {
            height: "full-" + getFullSize()
        });
    });

    table.on('toolbar(pointDispose)', function(obj){
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });



    //监听按钮点击事件
    var active = {
        addPointDispose: function(){
            top.layer.open({
                type: 2,
                title: "点位配置",
                content: "<%= request.getContextPath() %>/equipment/point/point_add.jsp",
                area: ["1200px", "600px"],
                resize: false,
                maxmin: true,
                btn: ["保存","关闭"],
                success: function(layero, index) {
                    var dataJson = {
                        win: window
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    var submit = layero.find("iframe").contents().find("#layuiadmin-app-form-submit");
                    submit.click();
                }
            })
        }
    }

    /*   分码信息查看 */

    table.render({
        elem: "#pointDispose",
        id: "pointDispose",
        data:[],
        height: "full-" + getFullSize(),
        toolbar:"#toolbar",
        defaultToolbar: [""],
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
        cols:[[{
            title:'序号',
            type:'numbers',
            hide:false
        },  {
            field: "plcName",
            title: "组别名称",
            align: "center",
            minWidth: 120,
        }, {
            field: "plcType",
            title: "组别类型",
            edit : 'text',
            align: "left",
            minWidth: 100,
        }, {
            field: "rfidName",
            title: "组映射RFID名称",
            edit : 'text',
            align: "center",
            minWidth: 100,
        }, {
            field: "rfidCode",
            title: "RFID天线编码",
            edit : 'text',
            align: "center",
            minWidth: 100,
        },{
            field: "remark",
            title: "备注",
            edit : 'text',
            align: "center",
            minWidth: 120,
        },{
            title: "操作",
            align: "center",
            fixed: "right",
            width: 200,
        }]],
    });
    table.on('tool(pointDispose)', function(obj) {

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