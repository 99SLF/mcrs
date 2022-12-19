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
                <div class="layui-col-md4"><br><br><br>
                    <h1>点位组配置</h1>
                </div>
                <div class="layui-col-md4 layui-col-md-offset">
                    <label>APPID：</label><br>
                    <label>设别资源号：</label><br>
                    <label>接入点IP：</label><br>
                    <label>端口号：</label><br>
                </div>
            </div>

        </div>
        <div class="layui-card-body">
            <div class="layui-toolbar" id="toolbarPlc" hidden="true">
                <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i
                        class="layui-icon layui-icon-add-circle-fine"></i>新建PLC点位组
                </button>
            </div>
            <div class="layui-toolbar" id="toolbarRfid" hidden="true">
                <button class="layui-btn layuiadmin-btn-list layui-btn-sm" lay-event="add"><i
                        class="layui-icon layui-icon-add-circle-fine"></i>新建RFID点位组
                </button>
            </div>
            <div class="layui-tab layui-tab-brief">
                <ul class="layui-tab-title">
                    <li class="layui-this">PLC点位组</li>
                    <li>RFID点位组</li>
                </ul>
                <div class="layui-tab-content">
                    <div class="layui-tab-item layui-show">
                        <div class="layui-card-body">
                            <table id="plc" lay-filter="plc"  class="layui-table " lay-skin="none"></table>
                        </div>
                    </div>
                    <div class="layui-tab-item">
                        <div class="layui-card-body">
                            <table id="rfid" lay-filter="rfid"  class="layui-table " lay-skin="none"></table>
                        </div>
                    </div>
                </div>
            </div>
            <script type="text/html" id="table-plc">
                <button class="layui-btn layui-btn-primary layui-btn-xs" title="新增PLC点位组" lay-event="addPlc"><i class="layui-icon layui-icon-add-circle-fine layuiadmin-button-btn"></i></button>
            </script>
            <script type="text/html" id="table-rfid">
                <button class="layui-btn layui-btn-primary layui-btn-xs" title="新增RFID点位组" lay-event="addRfid"><i class="layui-icon layui-icon-add-circle-fine layuiadmin-button-btn"></i></button>
            </script>

        </div>
    </div>
</div>
<script type="text/html" id="table-plc-list">
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
            class="layui-icon layui-icon-edit"></i>编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
            class="layui-icon layui-icon-delete"></i>删除</a>
</script>
<script type="text/html" id="table-rfid-list">
    <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
            class="layui-icon layui-icon-edit"></i>编辑</a>
    <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
            class="layui-icon layui-icon-delete"></i>删除</a>
</script>
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
    var TimeFn = null;
    var isOp = "";
    var reg=/^\d+$|^\d*\.\d+$/;
    var laydate = layui.laydate;
    var bomId=null;
    var processId,modeNum="",modePhoto="";
    var obj2=null;
    layui.admin.renderDictSelect({    	//客户状态下拉框搜索
        elem: "#status",
        dictTypeId: "MODELING_STATUS"
    });
    form.render();
    //监听普通搜索按钮点击事件
    form.on('select(status)', function(rel) {
        var submit = $("#search");
        submit.click();
        return false;
    });
    var funName = "Modeling";
    //过滤字段
    var hiddenFields = [];
    table.on('sort(Modeling)', function(obj){ //注：sort 是工具条事件名，test 是 table 原始容器的属性 lay-filter="对应的值"
        table.reload('Modeling', {
            initSort: obj //记录初始排序，如果不设的话，将无法标记表头的排序状态。
            ,where: { //请求参数（注意：这里面的参数可任意定义，并非下面固定的格式）
                field: obj.field //排序字段
                ,order: obj.type //排序方式
            }
        });

    });
    //查询过滤字段
    $.ajax({
        url: "com.zimax.components.coframe.tools.ColsFilter.queryHiddenField.biz.ext",
        type: "POST",
        async: false ,
        data: JSON.stringify({
            funName: funName
        }),
        cache: false,
        contentType: "text/json",
        success: function(result) {
            if (result) {
                hiddenFields = result.colsFilters
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

    table.on('toolbar(processBom)', function(obj){
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });



    //监听按钮点击事件
    var active = {
        save: function() {
            if(checkHave()==0){
                top.layer.alert("请选择一条数据！",{icon : 2, title : "系统提示"});
                return;
            }
            if(isOp==1){
                top.layer.alert("该型体已通过审核，不可操作！",{icon : 2, title : "系统提示"});
                return;
            }
            var bomData = table.cache["processBom"];
            if((processId==""||processId==null)&&bomData.length==0){
                return;
            }
            if(bomData==null)
                return;
            for (var i in bomData) {
                if( bomData[i].partId == ""||bomData[i]. partId==null){
                    top.layer.alert("部件不能为空！",{icon : 2, title : "系统提示"});
                    return;
                }
                if( bomData[i].matterId == ""||bomData[i]. matterId==null){
                    top.layer.alert("物料不能为空！",{icon : 2, title : "系统提示"});
                    return;
                }
                if( bomData[i].unit == ""||bomData[i]. unit==null){
                    top.layer.alert("单耗量不能为空！",{icon : 2, title : "系统提示"});
                    return;
                }
                if( bomData[i].unitPrice == ""||bomData[i].unitPrice==null){
                    top.layer.alert("单价不能为空！",{icon : 2, title : "系统提示"});
                    return;
                }
                if(!reg.test(bomData[i].unit)){
                    top.layer.alert("单耗量为数字！",{icon : 2, title : "系统提示"});
                    return;
                }
                if(bomData[i].splitCode==""||bomData[i].splitCode==null)
                    bomData[i].splitCode = 0;
            }
            var processData ={};
            processData.processId = processId;
            processData.modeNum = modeNum;
            processData.processBoms = bomData
            var submitData = JSON.stringify({
                processData: processData, bomLength: bomData.length
            })
            $.ajax({
                url: "com.zimax.mes.bom.BomManger.saveProcess.biz.ext",
                type: "POST",
                async: false ,
                data: submitData,
                cache: false,
                contentType: "text/json",
                success: function(result) {
                    layer.msg(result.msg, {
                        icon: 1,
                        time: 2000
                    });
                }
            });
            reloadProcess(modeNum)
        },showImage: function() {
            if(checkHave()==0){
                top.layer.alert("请选择一条数据！",{icon : 2, title : "系统提示"});
                return;
            }
            if(modeNum==null){
                top.layer.alert('请选中一条记录！',{icon: 2, title:'系统提示'});
                return;
            }
            if(modePhoto==""){
                top.layer.alert('该型体没有图片！',{icon: 2, title:'系统提示'});
                return;
            }
            layer.open({
                type:1
                ,title:false
                ,closeBtn:0
                ,area: [600 + 'px', 400 + 'px']
                ,skin:'layui-layer-nobg'
                ,shadeClose:true
                ,content:'<img src="com.zimax.mes.esop.showXls.flow?field='+ modePhoto+ '"style="width:600px;height:400px;#ccc">'
                ,scrollbar:false
            })
        },examine: function() {
            var checkStatus = table.checkStatus('Modeling');
            var data = checkStatus.data;
            if(data.length==0){
                top.layer.alert("请选择一条数据！",{icon : 2, title : "系统提示"});
                return;
            }
            if(isOp==1){
                top.layer.alert("该型体已通过审核，不可操作！",{icon : 2, title : "系统提示"});
                return;
            }
            var bomData = table.cache["processBom"];
            var status="";
            layer.confirm('审核型体bom?',{
                btn: ['通过', '不通过'],//按钮
            },function(index) {
                status = "102";
                var submitData = JSON.stringify({models: data,status: status});
                layer.close(index);
                changeStatus(submitData)
            },function(){
                status = "103";
                var submitData = JSON.stringify({models: data,status: status});
                changeStatus(submitData)
            })
        },cancelSave: function() {
            if(modeNum==""||modeNum==null)
                return;
            reloadProcess(modeNum)
        }
    }

    /*   分码信息查看 */

    table.render({
        elem: "#plc",
        id: "plc",
        data:[],
        height: "full-" + getFullSize(),
        toolbar:"#toolbarPlc",
        defaultToolbar: [""],
        colHideChange: function(col, checked) {
            var field = col.field;
            var hidden = col.hide;
            $.ajax({
                url: "com.zimax.components.coframe.tools.ColsFilter.setHiddenField.biz.ext",
                type: "POST",
                data: JSON.stringify({
                    hidden: hidden,
                    colsFilter: {
                        funName: funName,
                        field: field
                    }
                }),
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
            toolbar: "#table-plc-list"
        }]],
    });

    table.render({
        elem: "#rfid",
        id: "rfid",
        data:[],
        defaultToolbar: [""],
        toolbar:"#toolbarRfid",
        height: "full-" + getFullSize(),
        colHideChange: function(col, checked) {
            var field = col.field;
            var hidden = col.hide;
            $.ajax({
                url: "com.zimax.components.coframe.tools.ColsFilter.setHiddenField.biz.ext",
                type: "POST",
                data: JSON.stringify({
                    hidden: hidden,
                    colsFilter: {
                        funName: funName,
                        field: field
                    }
                }),
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
        }, {
            field: "rawMaterial",
            title: "加工方法",
            align: "center",
            width: 120,
            templet:function(d) {
                return layui.admin.getDictText("BIZ_RAWMATERIAL", d.rawMaterial);
            }
        }, {
            field:'matterNum',
            title:'物料编号',
            align:'center',
            minWidth: 140,
            templet:function(d) {
                return d.queryMatter == null? "" : d.queryMatter.matterNum;
            }
        }, {
            field : 'matterName',
            title : '材料名称/加工方法',
            minWidth : 100,
            align : "center",
            templet:function(d) {
                return d.queryMatter == null? "" : d.queryMatter.matterName;
            }
        },{
            field:'secondaryUnit',
            title:'二级单位',
            align:'center',
            minWidth: 100,
            templet:function(d) {
                return d.queryMatter == null? "" : layui.admin.getDictText("SECONDARY_UNIT", d.queryMatter.secondaryUnit);
            }
        }, {
            field:'coefficient',
            title:'系数',
            align:'center',
            minWidth: 100,
        }, {
            field:'singleQuantity',
            title:'单耗量',
            align:'center',
            minWidth: 100,
        }, {
            field : 'supplierName',
            title : '供应商',
            minWidth : 100,
            align : "center",
            templet:function(d) {
                return d.supplier ==null? "" : d.supplier.supplierName;
            }
        },{
            field:'issuingMethod',
            title:'发料方式',
            align:'center',
            minWidth: 100,
            templet:function(d) {
                return layui.admin.getDictText("BIZ_ISSUANCEMETHOD", d.issuingMethod);
            }
        }, {
            field:'issuingWarehouse',
            title:'发料仓',
            align:'center',
            minWidth: 100,
            templet:function(d) {
                return  layui.admin.getDictText("BIZ_ISSUINGWAREHOUSE", d.issuingWarehouse);
            }
        },{
            title: "操作",
            align: "center",
            fixed: "right",
            width: 200,
            toolbar: "#table-rfid-list"
        } ]]
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