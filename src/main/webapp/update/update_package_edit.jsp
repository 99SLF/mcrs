<%@ page import="com.zimax.cap.party.IUserObject" %>
<%@ page import="com.zimax.cap.datacontext.DataContextManager" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰 林俊杰
  - Date: 2023-1-30 20:13:14
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>终端编辑</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <style>
        .layui-form-label {
            width: 120px;
        }

        .layui-input-block {
            margin-left: 150px;
            min-height: 30px
        }

        .layui-textarea {
            height: 5px !important;
            /*min-height: 60px!important;*/
        }
    </style>
    <script src="common/layui/layui.all.js"></script>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <%--	需要隐藏主键,主键必要	--%>
    <input type="hidden" name="uploadId" value="default">
    <div class="layui-form-item layui-row layui-col-space10">

        <div class="layui-col-sm6">
            <label class="layui-form-label">终端类型：</label>
            <div class="layui-input-block">
                <input id="deviceSoType" type="text" name="deviceSoType" lay-verify="deviceSoType|required"
                       placeholder=""
                       autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-col-sm4">
            <label class="layui-form-label">类型最新版本：</label>
            <div class="layui-input-block">
                <input id="lastversion" type="text" name="lastversion" lay-verify="lastversion|required" placeholder=""
                       autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label">是否为主要版本：</label>
            <div class="layui-input-block">
                <input id="majorVersion" type="text" name="majorVersion" lay-verify="required|majorVersion"
                       placeholder=" " autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
        <div class="layui-col-sm4">
            <label class="layui-form-label">当前更新包版本：</label>
            <div class="layui-input-block">
                <%--从上往下加载顺序--%>
                <input id="version" type="text" name="version" lay-verify="version|required" placeholder=""
                       autocomplete="off" class="layui-input" disabled>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>更新策略：</label>
            <div class="layui-input-block">
                <%--下拉选择框--%>
                <select name="uploadStrategy" id="uploadStrategy" lay-filter="uploadStrategy"
                        lay-verify="uploadStrategy|required" type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
    </div>
    <div>
        <div class="layui-form-item layui-row layui-col-space10">
            <div class="layui-col-sm6">
                <label class="layui-form-label">更新包：</label>
                <div class="layui-input-block">
                    <input id="fileName" type="text" name="fileName"
                           autocomplete="off" class="layui-input" disabled>
                </div>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm12">
            <label class="layui-form-label">备注：</label>
            <div class="layui-input-block">
                <textarea class="layui-textarea field-effect field-content" name="remarks" id="remarks"
                          autocomplete="off" placeholder="" lay-verify="remarks"></textarea>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-row layui-col-space12">
        <div class="layui-col-sm6">
            <label class="layui-form-label" style="margin-top: 10px;">制单时间：</label>
            <div class="layui-input-block" id="div" style="width: 200px;margin-top: 10px; ">
                <input type="text" class="layui-input" name="versionUploadTime" id="myDiv" size="150" readonly/>
            </div>
        </div>
        <div class="layui-col-sm6">
            <%--需要通过id--%>
            <label class="layui-form-label" style="margin-top: 10px;">制单人：</label>
                <div class="layui-input-block" style="width: 200px;margin-top: 10px; ">
                    <input id="uploader" type="text" name="uploader"
                           autocomplete="off" class="layui-input" disabled>
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
    var util = layui.util;


    // 获取终端软件类型的下拉值
    layui.admin.renderDictSelect({
        elem: "#uploadStrategy",
        dictTypeId: "UPDATESTRATEGY"
    });
    form.render();


    //禁用选择设备资源号按钮
    $('#selectEquipment').addClass("layui-btn-disabled").attr("disabled", true);

    function SetData(data) {
        debugger;
        win = data.win ? data.win : window;
        var data = data.data;
        var deviceSoTypeVal = data.deviceSoType;
        var uploadIdVal = data.uploadId;
        //通过终端软件类型查询最新的上传更新包版本号
        var lastversionVal = "";
        $.ajax({
            url: "<%= request.getContextPath() %>/upload/getLastVersion?deviceSoType=" + deviceSoTypeVal,
            dataType: "json",
            type: "get",
            success: function (data) { //注意后端代码返回数据key值必须同名 为data
                lastversionVal = data.data[0].version
                $("#lastversion").val(lastversionVal);


            }
        })
        form.val("layuiadmin-app-form-list", {
            //需要传入主键
            "uploadId": data.uploadId,
            "deviceSoType": layui.admin.getDictText("DEVICE_SOFTWARE_TYPE", data.deviceSoType),
            "lastversion": lastversion,
            "majorVersion": layui.admin.getDictText("ISMAINVERSION", data.majorVersion),
            "version": data.version,
            "uploadStrategy": data.uploadStrategy,
            "fileName": data.fileName,
            "remarks": data.remarks,
            "versionUploadTime": util.toDateString(data.versionUploadTime, "yyyy-MM-dd HH:mm:ss"),
            //, "versionUploadTime": util.toDateString(data.versionUploadTime, "yyyy年MM月dd日 HH:mm:ss") //json数据不允许
            "uploader" : data.uplName

        });
    }

    //判断字符
    form.verify({
        uploadStrategy: function (value, item) { //value：表单的值、item：表单的DOM对象
            if (value.length < 1) {
                return '请选择更新策略';
            }
        },
    });


    //监听提交
    form.on("submit(layuiadmin-app-form-edit)", function (data) {
        debugger;
        var submitData = JSON.stringify(data.field);
        if (submit == false) {
            submit = true;
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/upload/update",
                    type: "POST",
                    data: submitData,
                    cache: false,
                    contentType: "text/json",
                    success: function (result) {
                        debugger;
                        layer.msg("修改成功", {
                            icon: 1,
                            time: 500
                        }, function () {
                            var index = parent.layer.getFrameIndex(window.name);
                            win.layui.table.reload("LAY-app-update_package-list-reload");
                            win.formReder();
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
