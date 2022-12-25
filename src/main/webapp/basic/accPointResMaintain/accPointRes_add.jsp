<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.zimax.cap.party.IUserObject" %>
<%@ page import="com.zimax.cap.datacontext.DataContextManager" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2022-12-21 22:10:17
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>接入点信息新增</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <style>
        .layui-form-label {
            width: 120px;
        }

        .layui-input-block {
            margin-left: 150px;
            min-height: 36px
        }
    </style>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">

    <div class="layui-form-item layui-row layui-col-space10">

        <%--        <div class="layui-col-sm6">--%>
        <%--            <label class="layui-form-label"><span style="color:red">*</span>设备类型代码:</label>--%>
        <%--            <div class="layui-input-block">--%>
        <%--                <input id="equipTypeCode" type="text" name="equipTypeCode" lay-verify="required|equipTypeCode"--%>
        <%--                       placeholder="请输入设备类型代码(必填)" autocomplete="off" class="layui-input">--%>
        <%--            </div>--%>
        <%--        </div>--%>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>接入点名称:</label>
            <div class="layui-input-block">
                <input id="accPointResName" type="text" name="accPointResName" lay-verify="required|accPointResName"
                       placeholder="请输入接入点名称(必填)" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>是否启用:</label>
            <div class="layui-input-block">
                <select name="equipTypeEnable" id="equipTypeEnable" lay-filter="required" type="select">
                    <option value="on">是</option>
                    <option value="off">否</option>
                </select>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>基地代码:</label>
                <div class="layui-input-block">
                    <select name="matrixCode" id="matrixCode" lay-filter="required" type="select">
<%--                        <option value="on">是</option>--%>
<%--                        <option value="off">否</option>--%>
                    </select>
                </div>
        </div>

    </div>

    <div class="layui-form-item layui-row layui-col-space10">

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>工厂代码:</label>
            <div class="layui-input-block">
                <select name="factoryCode" id="factoryCode" lay-filter="required" type="select">
                    <%--                        <option value="on">是</option>--%>
                    <%--                        <option value="off">否</option>--%>
                </select>
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>工厂名称:</label>
            <div class="layui-input-block">
                <input id="factoryName" type="text" name="factoryName"
                       lay-verify="required|factoryName"
                       placeholder="工厂名称" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>工序代码：</label>
            <div class="layui-input-block">
                <select name="processCode" id="processCode" lay-filter="required" type="select">
                    <%--                        <option value="on">是</option>--%>
                    <%--                        <option value="off">否</option>--%>
                </select>
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>工序名称：</label>
            <div class="layui-input-block">
                <input id="processName" type="text" name="processName" lay-verify="required|processName"
                       placeholder="工序名称" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm12">
            <label class="layui-form-label">工序描述:</label>
            <div class="layui-input-block">
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="processRemarks" id="processRemarks" autocomplete="off"
                      class="layui-input" lay-verify="processRemarks"></textarea>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-hide">
        <div class="layui-input-block">
            <input type="text" class="layui-hide" name="createTime"
                   value="<%=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())%>" readonly/>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-hide">
        <div class="layui-input-block">
            <%--java代码--%>
            <%
                IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
            %>
            <input type="text" class="layui-hide" name="creator" value="<%=usetObject.getUserName()%>"
                   readonly/>
        </div>
    </div>

    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit"
               id="layuiadmin-app-form-submit"
               value="确认添加">
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
    var submit = false;
    var isExist = false;
    var win = null;

    function SetData(data) {
        win = data.win ? data.win : window;
    }

    // 判断字符
    form.verify({
        accPointResName: function (value, item) {
            if (value.length > 20) {
                return "接入点名称不能超过20字符";
            }
        }
    });


    <%--rendTree();--%>
    <%--function rendTree() {--%>
    <%--    $.ajax({--%>
    <%--        url:"<%=request.getContextPath() %>/TreeInfo/queryCategoryTreeNode",--%>
    <%--        type:"get",--%>
    <%--        cache: false,--%>
    <%--        contentType:"text/json",--%>
    <%--        success: function(rel) {--%>
    <%--            debugger;--%>
    <%--            var data = rel;--%>
    <%--            var dataJson = toTreeData(data);--%>
    <%--        }--%>
    <%--    });--%>
    <%--}--%>




    <%--function toTreeData(data) {--%>
    <%--    debugger;--%>
    <%--    var tree = [];--%>
    <%--    var resData = data;--%>
    <%--    for (var i = 0; i < resData.length; i++){--%>
    <%--        if (resData[i].id == 2) {--%>
    <%--            var obj = {--%>
    <%--                id: resData[i].id,--%>
    <%--                title: resData[i].text,--%>
    <%--                parentId: "0",--%>
    <%--                children: []--%>
    <%--            };--%>
    <%--            tree.push(obj);--%>
    <%--            resData.splice(i,1);--%>
    <%--            i--;--%>
    <%--        }--%>
    <%--    }--%>

    <%--    var run = function(treeAttrs){--%>
    <%--        if (resData.length > 0 ) {--%>
    <%--            for (var i = 0; i < treeAttrs.length; i++) {--%>
    <%--                for (var j = 0; j < resData.length; j++) {--%>
    <%--                    if (resData[j]) {--%>
    <%--                        if (treeAttrs[i].id === resData[j].pid) {--%>
    <%--                            var obj = {--%>
    <%--                                id: resData[j].id,--%>
    <%--                                title: resData[j].text,--%>
    <%--                                parentId: resData[j].pid,--%>
    <%--                                children: []--%>
    <%--                            };--%>
    <%--                            treeAttrs[i].children.push(obj);--%>
    <%--                            resData.splice(j,1);--%>
    <%--                            j--;--%>
    <%--                        }--%>
    <%--                    }--%>
    <%--                    run(treeAttrs[i].children);--%>
    <%--                }--%>
    <%--            }--%>
    <%--        }--%>
    <%--    };--%>
    <%--    run(tree);--%>
    <%--    return tree;--%>
    <%--}--%>

    form.render();

    //监听提交
    form.on("submit(layuiadmin-app-form-submit)", function (data) {
        // var submitData = JSON.stringify(data.field);
        debugger;
        if (submit == false) {
            submit = true;
            var submitData = JSON.stringify(data.field);
            debugger;
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/accPointResController/add",
                    type: "POST",
                    data: submitData,
                    cache: false,
                    contentType: "text/json",
                    success: function (result) {
                        layer.msg("新增成功", {
                            icon: 1,
                            time: 500
                        }, function () {
                            var index = parent.layer.getFrameIndex(window.name);
                            win.layui.table.reload("LAY-app-device-list-reload");
                            top.layer.close(index);
                        });
                    }
                });
            }
        } else {
            layer.msg("请稍等");
        }
        return false;
    });
</script>
</body>
</html>
</body>
</html>
