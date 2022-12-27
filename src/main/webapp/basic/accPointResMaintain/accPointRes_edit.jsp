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
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <%--	需要隐藏主键,主键必要	--%>
    <input type="hidden" name="accPointResId" value="default">
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>接入点名称:</label>
            <div class="layui-input-block">
                <input id="accPointResName" type="text" name="accPointResName" lay-verify="required|accPointResName"
                       placeholder="请输入接入点名称(必填)" autocomplete="off" class="layui-input" lay-filter="accPointResName">
            </div>
        </div>

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>接入点代码:</label>
            <div class="layui-input-block">
                <input id="accPointResCode" type="text" name="accPointResCode" lay-verify="required|accPointResCode"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>是否启用:</label>
            <div class="layui-input-block">
                <select name="isEnable" id="isEnable" lay-filter="isEnable"
                        lay-verify="required|isEnable" type="select">
                    <option value=""></option>
                    <option value="是">是</option>
                    <option value="否">否</option>
                </select>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>基地代码:</label>
            <div class="layui-input-block">
                <%--   lay-filter 对应下面的form.on事件过滤         --%>
                <select name="matrixCode" id="matrixCode" lay-filter="matrixCode" lay-verify="required"
                        type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
        <div class="layui-col-sm6">
        <label class="layui-form-label">基地名称:</label>
            <div class="layui-input-block">
                <input id="matrixName" type="text" name="matrixName" lay-verify="" placeholder="请先选择基地代码" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

<div class="layui-form-item layui-row layui-col-space10">
    <div class="layui-col-sm6">
        <label class="layui-form-label"><span style="color:red">*</span>工厂代码:</label>
        <div class="layui-input-block">
            <select name="factoryCode" id="factoryCode" lay-filter="factoryCode" lay-verify=""
                    type="select">
                <option value=""></option>
            </select>
        </div>
    </div>

    <div class="layui-col-sm6">
        <label class="layui-form-label">工厂名称:</label>
        <div class="layui-input-block">
            <input id="factoryName" type="text" name="factoryName"
                   lay-verify=""
                   placeholder="请先选择工厂代码" autocomplete="off" class="layui-input">
        </div>
    </div>
</div>

<div class="layui-form-item layui-row layui-col-space10">
    <div class="layui-col-sm6">
        <label class="layui-form-label"><span style="color:red">*</span>工序代码：</label>
        <div class="layui-input-block">
            <select name="processCode" id="processCode" lay-filter="processCode" lay-verify=""
                    type="select">
                <option value=""></option>
            </select>
        </div>
    </div>

    <div class="layui-col-sm6">
        <label class="layui-form-label">工序名称：</label>
        <div class="layui-input-block">
            <input id="processName" type="text" name="processName" lay-verify=""
                   placeholder="请先选择工序代码" autocomplete="off" class="layui-input" readonly>
        </div>
    </div>
</div>
<div class="layui-form-item layui-row layui-col-space10">
    <div class="layui-col-sm12">
        <label class="layui-form-label">工序描述:</label>
        <div class="layui-input-block">
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="processRemarks" id="processRemarks"
                      autocomplete="off"
                      class="layui-input" lay-verify="" readonly></textarea>
        </div>
    </div>
</div>

<div class="layui-form-item layui-row layui-col-space12" style="padding-top: 30px">
    <div class="layui-form-item layui-row layui-hide">
        <div class="layui-input-block">
            <%--java代码--%>
            <%IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();%>
            <input type="text" class="layui-hide" name="updater" value="<%=usetObject.getUserName()%>" readonly/>
        </div>
    </div>
    <div class="layui-input-block">
        <input type="text" class="layui-hide" name="updateTime"
               value="<%=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())%>" readonly/>
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
    function SetData(data) {
        win = data.win ? data.win : window;
        var data = data.data;
        form.val("layuiadmin-app-form-list", {
            //要有主键
            "accPointResId": data.accPointResId,
            "accPointResName": data.accPointResName,
            "accPointResCode": data.accPointResCode,
            "isEnable": data.isEnable,
            "matrixCode": data.matrixCode,
            "matrixName": data.matrixName,
            "factoryCode": data.factoryCode,
            "factoryName": data.factoryName,
            "processCode": data.processCode,
            "processName": data.processName,
            "processRemarks": data.processRemarks,
        });
    }

    form.render();


    // 判断字符
    form.verify({
        accPointResName: function (value, item) {
            if (value.length > 20) {
                return "接入点名称不能超过20字符";
            }
        }

    });

    form.render();
    //下拉选择框动态赋值，将基地代码赋值给下拉选择框
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

    //对应lay-verify事件过滤，选择下拉值相应的基地代码获取相应的基地名称返回给基地名称输入框
    form.on("select(matrixCode)", function (data) {
        debugger;
        var matrixCode = data.value;
        if (data.value == null || data.value == "") {
            $("#matrixName").val("");
            $("#factoryCode").empty();
            $("#factoryName").val("");
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
                        $("#processCode").empty();
                        $("#processName").val("");
                        $("#processRemarks").val("");
                        //从后端获取的返回值数据存储到到allDatas
                        var allDatas = result.data;
                        var matrixNameVal = allDatas[0].matrixName;
                        //将后端获取的版本号赋值给最新版本号的输入框
                        $("#matrixName").val(matrixNameVal);
                        var parentid = allDatas[0].infoId;
                        //下拉选择框动态赋值，将工厂代码赋值给下拉选择框
                        $.ajax({
                            url: "<%= request.getContextPath() %>/FactoryController/selectFactoryCode?infoId=" + parentid,
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
            $("#processCode").find("option").remove();
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
                        $("#processCode").find("option").remove();
                        $("#processName").val("");
                        $("#processRemarks").val("");
                        var allDatas = result.data;
                        var factoryNameVal = allDatas[0].factoryName;
                        //将后端获取的版本号赋值给最新版本号的输入框
                        $("#factoryName").val(factoryNameVal);
                        var parentid = allDatas[0].infoId;
                        //下拉选择框动态赋值，得到工序代码赋值给下拉选择框
                        $.ajax({
                            url: "<%= request.getContextPath() %>/ProcessController/selectProcessCode?infoId=" + parentid,
                            dataType: "json",
                            async: false,
                            type: "get",
                            success: function (data) { //注意后端代码返回数据key值必须同名 为data
                                console.log(data)
                                //使用循环遍历，给下拉列表赋值
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
                        $("#processName").val("");
                        $("#processRemarks").val("");
                        var allDatas = result.data;
                        var processNameVal = allDatas[0].processName;
                        var processRemarksVal = allDatas[0].processRemarks;
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
    form.on("submit(layuiadmin-app-form-edit)", function (data) {
        var submitData = JSON.stringify(data.field);
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