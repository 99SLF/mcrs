<%@ page import="com.zimax.cap.party.IUserObject" %>
<%@ page import="com.zimax.cap.datacontext.DataContextManager" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2022-12-21 16:13:14
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>接入点信息维护编辑</title>
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
    <%--	需要隐藏主键,主键必要	--%>
    <input type="hidden" name="accPointResId" value="default">
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>接入点代码：</label>
            <div class="layui-input-block">
                <input id="accPointResCode" type="text" name="accPointResCode" lay-verify="required|accPointResCode"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>接入点名称：</label>
            <div class="layui-input-block">
                <input id="accPointResName" type="text" name="accPointResName" lay-verify="required|accPointResName"
                       placeholder="请输入接入点名称(必填)" autocomplete="off" class="layui-input" lay-filter="accPointResName">
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>是否启用：</label>
            <div class="layui-input-block">
                <select name="isEnable" id="isEnable" lay-filter="isEnable" lay-verify="required|isEnable"
                        type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
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
                <input id="factoryName" type="text" name="factoryName" lay-verify="" placeholder="请先选择工厂代码"
                       autocomplete="off" class="layui-input" readonly>
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
                <input id="processName" type="text" name="processName" lay-verify="" placeholder="请先选择工序代码"
                       autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm12">
            <label class="layui-form-label">工序描述：</label>
            <div class="layui-input-block">
                <textarea cols="50" rows="10" style="width:100%;height:100px" name="processRemarks" id="processRemarks"
                          autocomplete="off" class="layui-textarea" lay-verify="" readonly></textarea>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="layuiadmin-app-form-edit" id="layuiadmin-app-form-edit"
               value="确认修改">
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
    var form = layui.form;
    var laydate = layui.laydate;
    var $ = layui.jquery;
    var isExist = false;
    var submit = false;
    var win = null;

    layui.admin.renderDictSelect({
        elem: "#isEnable",
        dictTypeId: "IS_USE"
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

            var checkResult = "";
            $.ajax({
                url: "<%=request.getContextPath()%>/accPointResController/check/ProcessCode/update?processCode=" + value + "&processId=" + processId,
                type: "GET",
                async: false,
                contentType: "text/json",
                cache: false,
                success: function (text) {
                    if (text.code == "1") {
                        checkResult = "新选择的工序已被其他接入点使用";
                    }
                },
                error: function () {
                }
            });
            return checkResult;
        },
        processName: function (value, item) {
            if (value.length = 0) {
                return "工序名称不能为空";
            }
        }


    });
    form.render();

    function init(results) {
        //下拉选择框动态赋值，将基地代码赋值给下拉选择框(初始化)
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
                var matrixCodeOld = results.matrixCode
                $("#matrixCode").val(matrixCodeOld);
                layui.form.render("select")//重新渲染 固定写法

            }
        })
        //下拉选择框动态赋值，将工厂代码赋值给下拉选择框(初始化)
        var matrixCodeVal = results.matrixCode;
        $.ajax({
            url: "<%= request.getContextPath() %>/FactoryController/selectFactoryCodeInit?matrixCode=" + matrixCodeVal,
            dataType: "json",
            type: "get",
            success: function (data) { //注意后端代码返回数据key值必须同名 为data
                console.log(data)
                //使用循环遍历，给下拉列表赋值
                $.each(data.data, function (index, value) {
                    $("#factoryCode").append(new Option(value.factoryCode, value.id))//对应映射字段名 第一个为显示的值  第二个为value值
                });
                var factoryCodeOld = results.factoryCode
                $("#factoryCode").val(factoryCodeOld);
                layui.form.render("select")//重新渲染 固定写法

            }
        })
        //下拉选择框动态赋值，将工厂代码赋值给下拉选择框(初始化)
        var factoryCodeVal = results.factoryCode;
        $.ajax({
            url: "<%= request.getContextPath() %>/ProcessController/selectProcessCodeInit?factoryCode=" + factoryCodeVal,
            dataType: "json",
            type: "get",
            success: function (data) { //注意后端代码返回数据key值必须同名 为data
                console.log(data)
                //使用循环遍历，给下拉列表赋值
                $.each(data.data, function (index, value) {
                    $("#processCode").append(new Option(value.processCode, value.id))//对应映射字段名 第一个为显示的值  第二个为value值
                });
                var processCodeOld = results.processCode
                var processIdOld = results.processId
                $("#processCode").val(processCodeOld);
                $("#processId").val(processIdOld);
                layui.form.render("select")//重新渲染 固定写法

            }
        })

    }
    var accPointResId ="";
    var processId ="";
    function SetData(data) {
        //编辑页面取的是管理页面表格数据，做编辑操作，表格值必须都要有
        win = data.win ? data.win : window;
        var results = data.data;
         accPointResId = results.accPointResId;
        processId = results.processId;

        init(results);

        form.val("layuiadmin-app-form-list", {
            //要有主键
            "accPointResId": results.accPointResId,
            "accPointResName": results.accPointResName,
            "accPointResCode": results.accPointResCode,
            "isEnable": results.isEnable,
            "matrixCode": results.matrixCode,
            "matrixName": results.matrixName,
            "factoryCode": results.factoryCode,
            "factoryName": results.factoryName,
            "processId": results.processId,
            "processCode": results.processCode,
            "processName": results.processName,
            "processRemarks": results.processRemarks,
        });
    }


    //对应lay-verify事件过滤，选择下拉值相应的基地代码获取相应的基地名称返回给基地名称输入框
    form.on("select(matrixCode)", function (results) {
        var matrixCode = results.value;
        if (results.value == null || results.value == "") {
            layer.msg("更多基地数据请前往目录树添加");
            $("#matrixName").val("");
            $("#factoryCode").empty();
            $("#factoryCode").append(new Option("", ""));
            $("#factoryName").val("");
            $("#processId").val("");
            $("#processCode").empty();
            $("#processCode").append(new Option("", ""));
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
                        $("#factoryCode").append(new Option("", ""));
                        $("#factoryName").val("");
                        $("#processId").val("");
                        $("#processCode").empty();
                        $("#processCode").append(new Option("", ""));
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
                                if(data.data.length == 0){
                                    layer.msg("该基地下暂无工厂");
                                    $("#factoryCode").find("option").remove();
                                    $("#factoryCode").append(new Option("", ""));
                                    form.render("select");
                                    form.render();
                                }else {
                                    //使用循环遍历，给下拉列表赋值
                                    // $("#factoryCode").empty();
                                    // $("#processCode").empty();
                                    $("#factoryCode").find("option").remove();
                                    $("#factoryCode").append(new Option("", ""));
                                    $("#factoryName").val("");
                                    $("#processId").val("");
                                    $("#processCode").find("option").remove();
                                    $("#processCode").append(new Option("", ""));
                                    $("#processName").val("");
                                    $("#processRemarks").val("");
                                    $.each(data.data, function (index, value) {
                                        // $("#factoryCode").append(new Option("", ""));
                                        $("#factoryCode").append(new Option(value.factoryCode, value.id))//对应映射字段名 第一个为显示的值  第二个为value值
                                    });
                                    layui.form.render("select")//重新渲染 固定写法
                                }


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


    form.on("select(factoryCode)", function (results) {
        var factoryCode = results.value;
        if (results.value == null || results.value == "") {
            layer.msg("找不到可选工厂代码，可以尝试选择新的基地代码");
            $("#factoryName").val("");
            $("#processId").val("");
            $("#processCode").find("option").remove();
            $("#processCode").append(new Option("", ""));
            $("#processName").val("");
            $("#processRemarks").val("");
            form.render();
        } else {
            //调用查询的后端
            $.ajax({

                //查询出工厂名称
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
                        $("#processCode").append(new Option("", ""));
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
                                if(data.data.length == 0){
                                    layer.msg("该工厂下暂无工序");
                                    $("#processCode").find("option").remove();
                                    $("#processCode").append(new Option("", ""));
                                    form.render("select");
                                    form.render();
                                }else{
                                    //使用循环遍历，给下拉列表赋值
                                    $("#processId").val("");
                                    $("#processCode").find("option").remove();
                                    $("#processCode").append(new Option("", ""));
                                    $("#processName").val("");
                                    $("#processRemarks").val("");
                                    $.each(data.data, function (index, value) {
                                        // $("#processCode").append(new Option("", ""));
                                        $("#processCode").append(new Option(value.processCode, value.id))//对应映射字段名 第一个为显示的值  第二个为value值
                                    });
                                    layui.form.render("select")//重新渲染 固定写法
                                }


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
    form.on("select(processCode)", function (results) {
        var processCode = results.value;
        if (results.value == null || results.value == "") {
            layer.msg("找不到可选工序代码，可以尝试选择新的工厂代码");
            $("#processId").val("");
            $("#processName").val("");
            $("#processRemarks").val("");
            form.render();
        } else {
            //调用查询的后端
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
    form.on("submit(layuiadmin-app-form-edit)", function (results) {
        var submitData = JSON.stringify(results.field);
        if (submit == false) {
            submit = true;
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/accPointResController/update",
                    type: "POST",
                    data: submitData,
                    cache: false,
                    contentType: "text/json",
                    success: function (result) {
                        layer.msg("修改成功", {
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