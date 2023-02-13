<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2022-12-21 22:10:17
  - Description:
-->
<head>
    <title>基础数据树管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8"/>
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/layui/ext/dtree/dtree.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/layui/ext/dtree/font/dtreefont.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css" media="all">
    <style type="text/css">
        .layui-btn-group .layui-icon {
            color: #000000;
        }

        .tree-txt-active {
            color: red;
        }

        .layui-side div {
            background-color: #FAFAFA;
        }
    </style>
</head>
<body class="layui-layout-body">
<div id="LAY_app">
    <div class="layui-side layui-side-menu" style="width:280px">
        <div class="layui-card" style="height:100%;width:280px; border-radius:0px;">
            <div class="layui-card-body" style="margin-left: -20px" id="toolbarDiv">
                <ul id="demoTree" class="dtree" data-id="0"></ul>
            </div>
        </div>
    </div>
    <div class="layadmin-pagetabs layui-hide" id="LAY_app_tabs" style="display:none"></div>
    <!-- 主页内容 -->
    <div class="layui-body" id="LAY_app_body" style="margin-left:60px;height: 100%; max-height: 100%">
        <div class="layui-card" style="height:100%;overflow: auto;">
            <div class="layui-card-body" style="height:95%; max-height: 100%">
                <%--切换tab风格layui-tab-brief--%>
                <div class="layui-tab layui-tab-brief" lay-filter="LAY-app-subject-tab" style="height:100%;">
                    <ul class="layui-tab-title">
                        <li id="matrix_list" class="layui-this">基地列表</li>
                        <li id="matrix_info" class="layui-hide" style="font-weight: bold">基地信息</li>
                        <li id="factory_list" class="layui-hide" style="font-weight: bold">工厂列表</li>
                        <li id="factory_info" class="layui-hide" style="font-weight: bold">工厂信息</li>
                        <li id="process_list" class="layui-hide" style="font-weight: bold">工序列表</li>
                        <li id="process_info" class="layui-hide" style="font-weight: bold">工序信息</li>
                    </ul>

                    <%--scr tab页面，用scr--%>
                    <div class="layui-tab-content" style="height:100%;">
                        <div class="layui-tab-item layui-show" style="height:100%;">
                            <iframe id="matrix_list_iframe" width="100%" height="100%" scrolling="yes" frameborder="0"
                                    src="<%=request.getContextPath() %>/basic/matrixInfo/matrix/matrix_list_show.jsp"></iframe>
                        </div>
                        <div class="layui-tab-item" style="height:100%;">
                            <iframe id="matrix_info_iframe" width="100%" height="100%" scrolling="yes" frameborder="0"
                                    src="<%=request.getContextPath() %>/basic/matrixInfo/matrix/matrix_info.jsp"></iframe>
                        </div>
                        <div class="layui-tab-item" style="height:100%;">
                            <iframe id="factory_list_iframe" width="100%" height="100%" scrolling="yes" frameborder="0"
                                    src="<%=request.getContextPath() %>/basic/matrixInfo/factoryInfo/factory_list_show.jsp"></iframe>
                        </div>
                        <div class="layui-tab-item" style="height:100%;">
                            <iframe id="factory_info_iframe" width="100%" height="100%" scrolling="yes" frameborder="0"
                                    src="<%=request.getContextPath() %>/basic/matrixInfo/factoryInfo/factory_info.jsp"></iframe>
                        </div>
                        <div class="layui-tab-item" style="height:100%;">
                            <iframe id="process_list_iframe" width="100%" height="100%" scrolling="yes" frameborder="0"
                                    src="<%=request.getContextPath() %>/basic/matrixInfo/process/process_list_show.jsp"></iframe>
                        </div>
                        <div class="layui-tab-item" style="height:100%;">
                            <iframe id="process_info_iframe" width="100%" height="100%" scrolling="yes" frameborder="0"
                                    src="<%=request.getContextPath() %>/basic/matrixInfo/process/process_info.jsp"></iframe>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

</div>
<script src="<%= request.getContextPath() %>/common/layui/layui.all.js" type="text/javascript"></script>
<script src="<%=request.getContextPath()%>/common/layui/ext/dtree/dtree.js"></script>
<script>
    layui.config({
        base: "<%=request.getContextPath()%>/"
    });
</script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script type="text/javascript">
    var layer = layui.layer;
    var $ = layui.jquery;
    var dtree = layui.dtree;
    var util = layui.util;
    var element = layui.element;
    var node = {};
    var device = layui.device(); //获取设备来源
    var source = 1;  // 默认电脑

    if (device.mobile || device.android || device.ios) { // 手机缩略
        source = 2;
    }

    //定义json数据
    var matrix_list = {
        id: "matrix_list",
        path: "<%=request.getContextPath() %>/basic/matrixInfo/matrix/matrix_list_show.jsp"
    }
    var matrix_info = {
        id: "matrix_info",
        path: "<%=request.getContextPath() %>/basic/matrixInfo/matrix/matrix_info.jsp"
    }
    var factory_list = {
        id: "factory_list",
        path: "<%=request.getContextPath() %>/basic/matrixInfo/factoryInfo/factory_list_show.jsp"
    }
    var factory_info = {
        id: "factory_info",
        path: "<%=request.getContextPath() %>/basic/matrixInfo/factoryInfo/factory_info.jsp"
    }
    var process_list = {
        id: "process_list",
        path: "<%=request.getContextPath() %>/basic/matrixInfo/process/process_list_show.jsp"
    }
    var process_info = {
        id: "process_info",
        path: "<%=request.getContextPath() %>/basic/matrixInfo/process/process_info.jsp"
    }

    //将数据放到map中
    var map = {};
    map["root"] = [matrix_list];
    map["matrix"] = [matrix_info, factory_list];
    map["factory"] = [factory_info, process_list];
    map["process"] = [process_info];

    //定义数据放置所有的选项卡信息
    var tabList = [matrix_list, matrix_info, factory_list, factory_info, process_list, process_info];

    //选项卡的加载，切换
    element.on("tab(layui-tab-content)", function (data) {
        var iframe = $(data.elem.find("iframe")[data.index]);
        var src = iframe.attr("src");
        var url = iframe.attr("url");
        if (src !== url) {
            iframe.attr("src", url);
        }
    });

    function setUrlParam(url, params) {
        if (!url) {
            return url;
        }
        var paramsStr = [];
        for (var prop in params) {

            //属性等于属性值
            paramsStr.push(prop + "=" + encodeURIComponent(params[prop]));
        }
        if (url.indexOf("?") >= 0) {
            return url + "&" + paramsStr.join("&");
        } else {
            return url + "?" + paramsStr.join("&");
        }
    }

    // 第一步加载树
    rendTree();

    function rendTree() {
        // debugger;//请求前
        $.ajax({
            <%--url: "<%=request.getContextPath() %>/TreeInfo/queryCategoryTreeNode",--%> //树表的目录树
            url: "<%=request.getContextPath() %>/TreeInfoTr/queryCategoryTreeNodeTr",  //无树表的目录树
            type: "get",
            cache: false,
            contentType: "text/json",
            iconfont:["dtreefont", "layui-icon", "iconfont"],
            success: function (rel) {
                var data = rel;

                //第二步，加载树框架
                var dataJson = toTreeData(data);  //全加载，将二维数据，转为目录树

                //第三步，对节点数据操作（文本下拉监听，选项卡）
                loadTree(dataJson); //对目录树节点进行监听
            }
        });
    }

    //对目录树节点进行监听

    function loadTree(dataJson) {
        var DTree = dtree.render({
            elem: "#demoTree",
            id : "treeID",
            data: dataJson,
            initLevel: 2,
            width: "100%",
            height: "full-320",
            record: true,
            menubar: true,
            menubarTips: {
                group: ["moveDown", "moveUp", "searchNode", "refresh"]
            },
            toolbar: true,
            toolbarWay: "follow", //"contextmenu":右键菜单；"fixed":固定在节点右侧；"follow":跟随节点
            toolbarLoad: "node", //"node":所有节点；"noleaf":非最后一级节点；"leaf":最后一级
            toolbarShow: [],
            scroll: "#toolbarDiv",
            //拓展按钮
            toolbarExt: [{
                toolbarId: "editTreeNode", icon: "dtree-icon-bianji", title: "编辑", handler: function (node, $div) {
                    var change = node.recordData.infoType;
                    var key = node.recordData.realId;
                    var context = node.context;
                    var detail = node.recordData.detail;
                    var parentId = node.recordData.realId;
                    switch (change) {
                        case "root":
                            z = "none", o = "";
                            break;
                        case "matrix":
                            z = "<%= request.getContextPath() %>/basic/matrixInfo/matrix/matrix_edit.jsp" , o = "编辑基地";
                            break;
                        case "factory":
                            z = "<%= request.getContextPath() %>/basic/matrixInfo/factoryInfo/factory_edit.jsp", o = "编辑工厂";
                            break;
                        case "process":
                            z = "<%= request.getContextPath() %>/basic/matrixInfo/process/process_edit.jsp", o = "编辑工序";
                            break;
                    }
                    // layer.msg(JSON.stringify(node));
                    // 你可以在此添加一个layer.open，里面天上你需要添加的表单元素，就跟你写编辑页面是一样的
                    top.layer.open({
                        type: 2,
                        title: o,
                        content: z,
                        area: ["800px", "500px"],
                        resize: false,
                        btn: ["确定", "取消"],
                        success: function (layero, index) {
                            var dataJson = {
                                win: window,
                                key: key,
                                context:context,
                                detail:detail,
                                parentId:parentId
                            };
                            layero.find("iframe")[0].contentWindow.SetData(dataJson);
                        },
                        yes: function (index, layero) {
                            var edit = layero.find("iframe").contents().find("#layuiadmin-app-form-edit");//layuiadmin-app-form-edit编辑表的事件监听
                            edit.click();
                        }
                    })
                }

            }, {
                toolbarId: "delTreeNode", icon: "dtree-icon-jian1", title: "删除", handler: function (node, $div) {
                    // layer.msg(JSON.stringify(node));
                    var change = node.recordData.infoType;
                    var realId = node.recordData.realId;
                    switch (change) {
                        case "root":
                            z = "none", o = "";
                            break;
                        case "matrix":
                            z = "<%= request.getContextPath() %>/MatrixController/removeMatrix?realId="+ realId  , o = "删除基地";
                            break;
                        case "factory":
                            z = "<%= request.getContextPath() %>/FactoryController/removeFactory?realId="+ realId , o = "删除工厂";
                            break;
                        case "process":
                            z = "<%= request.getContextPath() %>/ProcessController/removeProcess?realId="+ realId, o = "删除工序";
                            break;
                    }
                    layer.confirm("确定"+o+"信息？", {
                        icon: 3,
                        title: "系统提示"
                    },function (index){
                        $.ajax({
                            url: z,
                            type: "post",
                            cache: false,
                            contentType: "text/json",
                            success: function (result) {

                                if (result.exception) {
                                    layer.alert(result.exception.message, {
                                        icon: 2,
                                        title: "系统提示"
                                    });
                                } else if (result.code==0) {
                                    layer.msg("删除成功", {
                                        icon: 1,
                                        time: 500
                                    }, function () {
                                        // table.reload("LAY-app-equipment-list-reload");
                                        rendTree();

                                    });
                                } else if(result.code == 1) {
                                    layer.msg(result.msg, {
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

            }, {
                toolbarId: "addTreeNode", icon: "dtree-icon-jia1", title: "新增", handler: function (node, $div) {
                    var change = node.recordData.infoType;
                    var parentId = node.recordData.realId;
                    switch (change) {
                        case "root":
                            x = "<%= request.getContextPath() %>/basic/matrixInfo/matrix/matrix_add.jsp" , y = "新增基地"
                            break;
                        case "matrix":
                            x = "<%= request.getContextPath() %>/basic/matrixInfo/factoryInfo/factory_add.jsp", y = "新增工厂"
                            break;
                        case "factory":
                            x = "<%= request.getContextPath() %>/basic/matrixInfo/process/process_add.jsp", y = "新增工序"
                            break;
                        case "process":
                            x = "none", y = ""
                            break;
                    }
                    // 添加的表单元素，就新增页面
                    top.layer.open({
                        type: 2,
                        title: y,
                        content: x,
                        area: ["800px", "500px"],
                        resize: false,
                        btn: ["确定", "取消"],
                        success: function (layero, index) {
                            var dataJson = {
                                win: window,
                                parentId: parentId
                            };
                            layero.find("iframe")[0].contentWindow.SetData(dataJson);
                        },
                        yes: function (index, layero) {
                            var submit = layero.find("iframe").contents().find("#layuiadmin-app-form-submit");
                            submit.click();
                        }
                    })
                }


            }],
            //工具栏按钮
            toolbarFun: {
                loadToolbarBefore: function (buttons, param, $div) {
                    //增删改的图标
                    if (param.level == "1") {
                        buttons.editTreeNode = "";
                        buttons.delTreeNode = "";
                    }
                    if (param.level == "4") {
                        buttons.addTreeNode = "";

                    }

                    return buttons; //将按钮对象返回
                }
            }
        });

        //必须放树加载结构里面，否则clickSpread,会报错
        dtree.on("node('demoTree')", function (obj) {
            console.log(obj);
            // layer.msg(JSON.stringify(obj.param));
            //切换页面方法，加载选项切换方法
            refreshTab(obj.param);
            //点击文本展开
            if (!obj.param.leaf) {
                var $div = obj.dom;
                DTree.clickSpread($div);  //调用内置函数展开节点
            }

            // layer.msg(JSON.stringify(obj.param));
        });
    }


    //node 组件内置属性，当选中树节点时，会将树的当前选中节点的的结果放到该参数中，
    // 包含当前节点的全部信息 切换详情页面方法

    function refreshTab(node) {
        var infoType = node.recordData.infoType;
        var tabs = map[infoType];

        for (var i = 0; i < tabs.length; i++) {
            var obj = tabs[i];
            obj.url = setUrlParam(obj.path, node.recordData);
        }

        setTabs(tabs);
    }

    function setTabs(tabs) {
        for (var i = 0; i < tabList.length; i++) {
            var tab = tabList[i];
            for (var j = 0; j < tabs.length; j++) {
                var tab1 = tabs[j];
                if (tab.id == tab1.id) {
                    $("#" + tab.id).removeClass("layui-hide");
                    break;
                } else {
                    $("#" + tab.id).addClass("layui-hide");
                }
            }
        }

        for (var i = 0; i < tabs.length; i++) {
            var tab = tabs[i];
            $("#" + tab.id + "_iframe").attr("src", tab.url);
        }

        $("#" + tabs[0].id).click();
    }

    // 加载树结构


    function toTreeData(data) {
        var tree = [];
        var resData = data;
        for (var i = 0; i < resData.length; i++) {
            // if (resData[i].id == 2) {
            var obj = {
                id: resData[i].id,
                title: resData[i].text,
                parentId: "0",
                realId: resData[i].realId,
                detail : resData[i].detail,
                infoType: resData[i].infoType,//之前缺的
                children: []
            };
            tree.push(obj);
            // resData.splice(i,1);
            // i--;
            // }
        }
        var run = function (treeAttrs) {
            if (resData.length > 0) {
                for (var i = 0; i < treeAttrs.length; i++) {
                    for (var j = 0; j < resData.length; j++) {
                        if (resData[j]) {
                            if (treeAttrs[i].id === resData[j].pid) {
                                var obj = {
                                    id: resData[j].id,
                                    title: resData[j].text,
                                    parentId: resData[j].pid,
                                    realId: resData[j].realId,
                                    detail : resData[j].detail,
                                    infoType: resData[j].infoType,//之前缺的j
                                    children: []
                                };
                                treeAttrs[i].children.push(obj);
                                resData.splice(j, 1);
                                j--;
                            }
                        }
                        run(treeAttrs[i].children);
                    }
                }
            }
        };
        run(tree);
        for (var i = 0; i < tree.length; i++) {
            if (tree[i].id !== "root") {
                tree.splice(i, 1);
                i--;
            }
        }

        return tree;
    }

</script>
</body>
</html>