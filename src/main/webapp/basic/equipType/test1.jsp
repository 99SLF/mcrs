<%@ page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <title>管理</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/layui/ext/dtree/dtree.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/common/layui/ext/dtree/font/dtreefont.css">
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css" media="all">
    <style type="text/css">
        .layui-btn-group .layui-icon {
            color: #000000;
        }
        .tree-txt-active{
            color :red;
        }
        .layui-side div {
            background-color:#FAFAFA;
        }
    </style>
</head>
<body class="layui-layout-body">
<div id="LAY_app">
    <div class="layui-side layui-side-menu" style="width:280px">
        <div class="layui-card" style="height:100%;width:280px;auto;border-radius:0px;">
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
                <!--<iframe id="list"></iframe>-->
                <div class="layui-tab"  lay-filter="LAY-app-subject-tab" style="height:100%;">
                    <div class="layui-tab-content" style="height:100%;">
                        <div class="layui-tab-item layui-show" style="height:100%;">
                            <iframe id="list"  width="100%" height="100%" scrolling="yes" frameborder="0"  ></iframe>
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

    var line_list = {
        id: "list",
        title: "产线列表",
        path: '<%=request.getContextPath() %>/basic/productionLine/dict_list.jsp'
    };

    var categoryTabs = [];
    categoryTabs.push(line_list);

    var device = layui.device(); //获取设备来源
    var source = 1;  // 默认电脑

    if (device.mobile || device.android || device.ios) { 		// 手机缩略
        source = 2;
    }

    function setUrlParam(url, params) {
        if (! url) {
            return url;
        }
        var paramsStr = [];
        for (var prop in params) {
            paramsStr.push(prop + "=" + encodeURIComponent(params[prop]));
        }
        if (url.indexOf("?") >= 0) {
            return url + "&" + paramsStr.join("&");
        } else {
            return url + "?" + paramsStr.join("&");
        }
    }

    function refreshTab(node) {
        var iframe = $(".layui-tab-item.layui-show").find("iframe");
        for (var i = 0; i < categoryTabs.length; i++) {
            var obj = categoryTabs[i];
            var settingTab = $("#" + obj.id);
            settingTab.attr("url", setUrlParam(obj.path,node));
        }
        iframe.attr("src", iframe.attr("url"));
    }

    $.ajax({
        url:"com.zimax.mes.basic.CategoryManager.queryCategoryTreeNode.biz.ext",
        type:"post",
        cache: false,
        contentType:"text/json",
        success: function(rel) {
            var data = rel.data;
            var dataJson = toTreeData(data);
            loadTree(dataJson);
        }
    });
    //加载树结构
    function loadTree(dataJson) {
        var DTree = dtree.render ({
            elem: "#demoTree",
            data: dataJson,
            initLevel: 2,
            width: "100%",
            height: "full-320",
            //cache:true,  //数据缓存，开启后，当节点收缩后再展开，不会重新访问url
            //ficon:"2",   //一级图标样式，1：方形加减，0：文件夹，2：三角形
            //icon:"0",    //二级图标样式
            //dataFormat:"list",
            record: true,
            /* menubar:true,
            menubarFun: {
            }, */
            /* formatter:{
                title:function(data){
                    var s = data.title;
                    if(data.children){
                        s +=' <span style=\'color:blue\'>(' + data.children.length + ')</span>';
                    }
                    return s;
                }
            }, */
            toolbar: true,
            toolbarWay: "follow", //"contextmenu":右键菜单；"fixed":固定在节点右侧；"follow":跟随节点
            toolbarLoad:"node", //"node":所有节点；"noleaf":非最后一级节点；"leaf":最后一级
            toolbarShow:["add", "edit", "delete"],
            scroll:"#toolbarDiv",
            toolbarBtn:[[{
                label: "显示顺序",
                name: "displayOrder",
                type: "text",
                verify: "required"
            }], [{
                label: "显示顺序",
                name: "displayOrder",
                type: "text",
                verify: "required"
            }]],
            toolbarFun: {   //工具栏事件加载
                addTreeNode: function(treeNode, $div){
                    var dataJson = {
                        category:{
                            "category/categoryId": (treeNode.parentId == "root" ? null : treeNode.parentId),
                            categoryName: treeNode.context,
                            displayOrder: treeNode.displayOrder
                        },
                        newCategoryName: treeNode.addNodeName
                    };
                    $.ajax({
                        url: "com.zimax.mes.basic.CategoryManager.saveCategory.biz.ext",
                        type: "post",
                        data: JSON.stringify(dataJson),
                        cache: false,
                        contentType: "text/json",
                        success: function(result){
                            if (result.retCode == 0) {
                                layer.msg(result.retMsg, {icon:1, time:2000}, function(){
                                    DTree.changeTreeNodeAdd(result.category.categoryId); // 添加成功，返回ID
                                    DTree.changeTreeNodeAdd(result.category.displayOrder);
                                    DTree.changeTreeNodeAdd(true); // 添加成功
                                    DTree.changeTreeNodeAdd("refresh"); //
                                });
                            } else {
                                layer.msg("添加失败", {
                                    icon:2,
                                    time:2000
                                }, function(){
                                    DTree.changeTreeNodeAdd(false); // 添加失败
                                });
                            }
                        },
                        error: function(){
                            layer.msg("添加失败", {
                                icon: 2,
                                time: 2000
                            }, function(){
                                DTree.changeTreeNodeAdd(false); // 添加失败
                            });
                        }
                    });
                },
                //编辑树节点之后的回调
                editTreeNode: function(treeNode, $div){
                    var dataJson = {
                        category:{
                            "category/categoryId":(treeNode.parentId == "root" ? null:treeNode.parentId),
                            categoryId:treeNode.nodeId,
                            categoryName:treeNode.context,
                            displayOrder:treeNode.displayOrder
                        },
                        newCategoryName:treeNode.editNodeName};
                    $.ajax({
                        url: "com.zimax.mes.basic.CategoryManager.updateCategory.biz.ext",
                        type: "post",
                        data: JSON.stringify(dataJson),
                        cache: false,
                        contentType: "text/json",
                        success: function(result){
                            if (result.retCode == 0) {
                                layer.msg(result.retMsg, {
                                    icon: 1,
                                    time: 2000
                                }, function(){
                                    DTree.changeTreeNodeEdit(true);// 修改成功
                                });
                            } else {
                                DTree.changeTreeNodeEdit(false); // 修改失败
                                layer.msg("修改失败", {icon:2, time:2000});
                            }
                        },
                        error: function(){
                            DTree.changeTreeNodeEdit(false); // 修改失败
                            layer.msg("修改失败", {
                                icon: 2,
                                time: 2000
                            });
                        }
                    });
                },
                //编辑树的数据回显，用于打开编辑时，回填数据
                editTreeLoad: function(treeNode){
                    var dataJson = {category:{
                            "category/categoryId":(treeNode.parentId == "root" ? null:treeNode.parentId),
                            categoryId: treeNode.nodeId,
                            categoryName: treeNode.context
                        }};
                    console.log(treeNode);
                    $.ajax({
                        url: "com.zimax.mes.basic.CategoryManager.getCategory.biz.ext",
                        type: "post",
                        data: JSON.stringify(dataJson),
                        contentType: 'text/json',
                        success: function(result){
                            if (result.category) {
                                var data = result.category;
                                DTree.changeTreeNodeDone({
                                    "displayOrder": data.displayOrder,
                                    "editNodeName":data.categoryName
                                });
                            }
                        }
                    });
                },
                //删除树节点之后的回调
                delTreeNode: function(treeNode, $div){
                    $.ajax({
                        url: "com.zimax.mes.basic.CategoryManager.deleteCategory.biz.ext",
                        type: "post",
                        data: JSON.stringify({"categoryId":treeNode.nodeId}),
                        cache: false,
                        contentType: 'text/json',
                        success: function(result){
                            if (result.retCode == 0) {
                                layer.msg(result.retMsg, {
                                    icon: 1,
                                    time: 2000
                                }, function(){
                                    DTree.changeTreeNodeDel(true); // 删除成功
                                });
                            } else if(result.retCode == 1){
                                layer.msg("删除失败", {
                                    icon: 2,
                                    time: 2000
                                });
                                DTree.changeTreeNodeDel(false); // 删除失败
                            } else if(result.retCode == 2){
                                layer.msg("删除失败", {
                                    icon: 2,
                                    time: 2000
                                });
                                DTree.changeTreeNodeDel(false); // 删除失败
                            }
                        },
                        error: function(){
                            layer.msg("删除失败", {icon:2, time:2000});
                            DTree.changeTreeNodeDel(false); // 删除失败
                        }
                    });
                },
                //右键菜单加载前的函数
                loadToolbarBefore:function(buttons,param,$div){
                    //增删改的图标
                    if (param.level == "1" ) {
                        buttons.editToolbar = "";
                        buttons.delToolbar = "";
                    }

                    return buttons; //将按钮对象返回
                }
            }
        });
        // 绑定节点点击
        dtree.on("node('demoTree')" ,function(obj){
            //切换页面
            refreshTab(obj.param);

            //点击文本展开
            if(!obj.param.leaf){
                var $div = obj.dom;
                DTree.clickSpread($div);  //调用内置函数展开节点
            }
        });
    }

    function toTreeData(data) {
        var tree = [];
        var resData = data;
        for (var i = 0; i < resData.length; i++){
            if (resData[i].id == 1) {
                var obj = {
                    id: resData[i].id,
                    title: resData[i].text,
                    parentId: "0",
                    children: []
                };
                tree.push(obj);
                resData.splice(i,1);
                i--;
            }
        }

        var run = function(treeAttrs){
            if (resData.length > 0 ) {
                for (var i = 0; i < treeAttrs.length; i++) {
                    for (var j = 0; j < resData.length; j++) {
                        if (resData[j]) {
                            if (treeAttrs[i].id === resData[j].pid) {
                                var obj = {
                                    id: resData[j].id,
                                    title: resData[j].text,
                                    parentId: resData[j].pid,
                                    children: []
                                };
                                treeAttrs[i].children.push(obj);
                                resData.splice(j,1);
                                j--;
                            }
                        }
                        run(treeAttrs[i].children);
                    }
                }
            }
        };
        run(tree);
        return tree;
    }

</script>
</body>
</html>