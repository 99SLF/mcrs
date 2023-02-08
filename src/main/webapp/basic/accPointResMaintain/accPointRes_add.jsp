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
            min-height: 30px
        }
        .layui-textarea{
            height: 5px!important;
            /*min-height: 60px!important;*/
        }
    </style>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>接入点名称：</label>
            <div class="layui-input-block">
                <input id="accPointResName" type="text" name="accPointResName" lay-verify="required|accPointResName"
                       placeholder="请输入接入点名称(必填)" autocomplete="off" class="layui-input">
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>是否启用：</label>
            <div class="layui-input-block">
                <select name="isEnable" id="isEnable" lay-filter="isEnable" lay-verify="required|isEnable"
                        type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>基地代码：</label>
            <div class="layui-input-block">
                <%--   lay-filter 对应下面的form.on事件过滤         --%>
                <select name="matrixCode" id="matrixCode" lay-filter="matrixCode" lay-verify="required|matrixCode"
                        type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">基地名称：</label>
            <div class="layui-input-block">
                <input id="matrixName" type="text" name="matrixName"
                       lay-verify=""
                       placeholder="请先选择基地代码" autocomplete="off" class="layui-input"
                       readonly>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>工厂代码：</label>
            <div class="layui-input-block">
                <select name="factoryCode" id="factoryCode" lay-filter="factoryCode" lay-verify="required|factoryCode"
                        type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">工厂名称：</label>
            <div class="layui-input-block">
                <input id="factoryName" type="text" name="factoryName"
                       lay-verify=""
                       placeholder="请先选择工厂代码" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <input id="processId" type="hidden" name="processId" lay-verify="processId" lay-filter="processId"
                   placeholder="工序Id" autocomplete="off" class="layui-input" readonly>
            <label class="layui-form-label"><span style="color:red">*</span>工序代码：</label>
            <div class="layui-input-block">
                <select name="processCode" id="processCode" lay-filter="processCode" lay-verify="required|processCode"
                        type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label">工序名称：</label>
            <div class="layui-input-block">
                <input id="processName" type="text" name="processName" lay-verify="processName" lay-filter="processName"
                       placeholder="请先选择工序代码" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm12">
            <label class="layui-form-label">工序描述：</label>
            <div class="layui-input-block">
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="processRemarks" id="processRemarks"
                      autocomplete="off"
                      class="layui-textarea" lay-verify="" readonly></textarea>
            </div>
        </div>
    </div>
<%--    <div class="layui-form-item layui-row layui-hide">--%>
<%--        <div class="layui-input-block">--%>
<%--            <input type="text" class="layui-hide" name="createTime"--%>
<%--                   value="<%=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())%>" readonly/>--%>
<%--        </div>--%>
<%--    </div>--%>

<%--    <div class="layui-form-item layui-row layui-hide">--%>
<%--        <div class="layui-input-block">--%>
<%--            <%IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();%>--%>
<%--            <input type="text" class="layui-hide" name="creator" value="<%=usetObject.getUserName()%>"--%>
<%--                   readonly/>--%>
<%--        </div>--%>
<%--    </div>--%>

    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" lay-filter="*"
               id="layuiadmin-app-form-submit" value="确认添加">
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

    // 全局变量，用户从存储从后端查询出来的结果数据
    function SetData(data) {
        win = data.win ? data.win : window;
    }

    layui.admin.renderDictSelect({
        elem: "#isEnable",
        dictTypeId: "IS_USE"
    });

    layui.admin.renderDictSelect({
        elem: "#processName",
        dictTypeId: "USE_PROCESS"
    });

    //数据字典项加载
    form.render();

    // 判断字符
    form.verify({
        accPointResName: function (value, item) {
            if(!new RegExp("^[a-zA-Z0-9\u4e00-\u9fa5]+$").test(value)){
                return "输入名称有误，只能输入汉字+英文+数字";
            }
            if (value.length > 20) {
                return "接入点名称不能超过20字符";
            }
        },

        isEnable: function (value, item) {
            if (value.length = 0) {
                return "请确定是否启用";
            }
        },

        matrixCode: function (value, item) {
            if (value.length = 0) {
                return "请选择基地代码";
            }
        },

        matrixName: function (value, item) {
            if (value.length = 0) {
                return "基地名称不能为空";
            }
        },
        factoryCode: function (value, item) {
            if (value.length = 0) {
                return "请选择工厂代码";
            }
        },
        factoryName: function (value, item) {
            if (value.length = 0) {
                return "工厂名称不能为空";
            }
        },

        processCode: function (value, item) {
            if (value.length = 0) {
                return "请选择工序代码";
            }
        },
        processName: function (value, item) {
            if (value.length = 0) {
                return "工序名称不能为空";
            }
        }


    });

    //下拉选择框动态赋值，将基地代码赋值给下拉选择框(接入点新增)
    $.ajax({
        url: "<%= request.getContextPath() %>/MatrixController/selectMatrixCode",
        dataType: "json",
        type: "get",
        success: function (data) { //注意后端代码返回数据key值必须同名 为data
            console.log(data)
            //使用循环遍历，给下拉列表赋值
            $.each(data.data, function (index, value) {
                $("#matrixCode").append(new Option(value.matrixCode, value.id))//对应映射字段名 第一个为显示的值  第二个为value值
            });
            layui.form.render("select")//重新渲染 固定写法

        }
    })

    //对应lay-verify事件过滤，选择下拉值相应的基地代码获取相应的基地名称返回给基地名称输入框（基地代码查询基地名称）
    form.on("select(matrixCode)", function (data) {
        debugger;
        var matrixCode = data.value;
        if (data.value == null || data.value == "") {
            $("#matrixName").val("");
            $("#factoryCode").empty();
            $("#factoryName").val("");
            $("#processId").val("");
            $("#processCode").empty();
            $("#processName").val("");
            $("#processRemarks").val("");
            //执行清空
            form.render("select");
            form.render();
        } else {
            //调用查询的后端
            $.ajax({
                //获取到基地名称
                url: "<%= request.getContextPath() %>/MatrixController/getMatrixName?matrixCode=" + matrixCode,
                type: "GET",
                async: false,//默认是true异步传输，false是同步传输,转全局变量的第一条件
                cache: false,
                contentType: "text/json",
                dataType: "json",//
                success: function (result) {
                    if (result) {
                        $("#matrixName").val("");
                        $("#factoryCode").empty();
                        $("#factoryName").val("");
                        $("#processId").val("");
                        $("#processCode").empty();
                        $("#processName").val("");
                        $("#processRemarks").val("");
                        //从后端获取的返回值数据存储到到allDatas
                        var allDatas = result.data;
                        var matrixNameVal = allDatas[0].matrixName;
                        //将后端获取的版本号赋值给最新版本号的输入框
                        $("#matrixName").val(matrixNameVal);
                        var matrixId = allDatas[0].matrixId;
                        //下拉选择框动态赋值，将工厂代码赋值给下拉选择框
                        $.ajax({
                            url: "<%= request.getContextPath() %>/FactoryController/selectFactoryCode?matrixId=" + matrixId,
                            dataType: "json",
                            async: false,
                            type: "get",
                            success: function (data) { //注意后端代码返回数据key值必须同名 为data
                                console.log(data)
                                //使用循环遍历，给下拉列表赋值
                                // $("#factoryCode").empty();
                                // $("#processCode").empty();
                                $("#factoryCode").find("option").remove();
                                $("#factoryName").val("");
                                $("#processId").val("");
                                $("#processCode").find("option").remove();
                                $("#processName").val("");
                                $("#processRemarks").val("");
                                $.each(data.data, function (index, value) {
                                    $("#factoryCode").append(new Option("", ""));
                                    $("#factoryCode").append(new Option(value.factoryCode, value.id))//对应映射字段名 第一个为显示的值  第二个为value值
                                });
                                layui.form.render("select")//重新渲染 固定写法

                            }
                        })
                    } else {
                        layer.msg("找不到数据");
                    }
                }
            });

        }

    });

    form.on("select(factoryCode)", function (data) {
        var factoryCode = data.value;
        if (data.value == null || data.value == "") {
            $("#factoryName").val("");
            $("#processId").val("");
            $("#processCode").find("option").remove();
            $("#processName").val("");
            $("#processRemarks").val("");
            form.render();
        } else {
            //调用查询的后端
            $.ajax({
                //查询出工厂名称(工厂代码查询工厂名称)
                url: "<%= request.getContextPath() %>/FactoryController/getFactoryName?factoryCode=" + factoryCode,
                type: "GET",
                async: false,//默认是true异步传输，false是同步传输,转全局变量的第一条件
                cache: false,
                contentType: "text/json",
                dataType: "json",//
                success: function (result) {
                    if (result) {
                        $("#factoryName").val("");
                        $("#processId").val("");
                        $("#processCode").find("option").remove();
                        $("#processName").val("");
                        $("#processRemarks").val("");
                        var allDatas = result.data;
                        var factoryNameVal = allDatas[0].factoryName;
                        //将后端获取的版本号赋值给最新版本号的输入框
                        $("#factoryName").val(factoryNameVal);
                        var factoryId = allDatas[0].factoryId;
                        //下拉选择框动态赋值，得到工序代码赋值给下拉选择框
                        $.ajax({
                            url: "<%= request.getContextPath() %>/ProcessController/selectProcessCode?factoryId=" + factoryId,
                            dataType: "json",
                            async: false,
                            type: "get",
                            success: function (data) { //注意后端代码返回数据key值必须同名 为data
                                console.log(data)
                                //使用循环遍历，给下拉列表赋值
                                $("#processId").val("");
                                $("#processCode").find("option").remove();
                                $("#processName").val("");
                                $("#processRemarks").val("");
                                $.each(data.data, function (index, value) {
                                    $("#processCode").append(new Option("", ""));
                                    $("#processCode").append(new Option(value.processCode, value.id))//对应映射字段名 第一个为显示的值  第二个为value值
                                });
                                layui.form.render("select")//重新渲染 固定写法

                            }
                        })
                    } else {
                        layer.msg("找不到数据");
                    }

                }
            });
        }
    });

    form.render();

    //监听工序代码，自动填充上工序名称和工序描述
    form.on("select(processCode)", function (data) {
        var processCode = data.value;
        if (data.value == null || data.value == "") {
            $("#processId").val("");
            $("#processName").val("");
            $("#processRemarks").val("");
            form.render();
        } else {
            //调用查询的后端
            debugger;
            $.ajax({
                //获取出工序名称和工序描述
                url: "<%= request.getContextPath() %>/ProcessController/getProcessNameDe?processCode=" + processCode,
                type: "GET",
                async: false,//默认是true异步传输，false是同步传输,转全局变量的第一条件
                cache: false,
                contentType: "text/json",
                dataType: "json",//
                success: function (result) {
                    if (result) {
                        $("#processId").val("");
                        $("#processName").val("");
                        $("#processRemarks").val("");
                        var allDatas = result.data;
                        var processNameVal = allDatas[0].processName;
                        var processRemarksVal = allDatas[0].processRemarks;
                        var processId = allDatas[0].processId;
                        // $("#processName").val(layui.admin.getDictText("USE_PROCESS", processNameVal));
                        $("#processId").val(processId);
                        $("#processName").val(processNameVal);
                        $("#processRemarks").val(processRemarksVal);


                    } else {
                        layer.msg("找不到数据");
                    }

                }
            });
        }

    });
    form.render();


    //监听提交
    form.on("submit(layuiadmin-app-form-submit)", function (data) {


        debugger;

        // var submitData = JSON.stringify(data.field);
        debugger;
        if (submit == false) {
            submit = true;
            var submitData = JSON.stringify(data.field);
            debugger;
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/accPointResController/add",
                    type: "POST",//post自动过滤掉field中不需要的数据，实体接什么就保留什么
                    data: submitData,
                    cache: false,
                    contentType: "text/json",
                    success: function (result) {
                        layer.msg("新增成功", {
                            icon: 1,
                            time: 500
                        }, function () {
                            var index = parent.layer.getFrameIndex(window.name);
                            win.layui.table.reload("LAY-app-accPoint-list-reload");
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
