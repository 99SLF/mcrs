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
    <title>设备类型信息维护编辑</title>
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
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     style="padding: 20px 30px 0 0;">
    <%--	需要隐藏主键,主键必要	--%>
    <input type="hidden" name="equipTypeId" value="default">

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>设备类型代码:</label>
            <div class="layui-input-block">
                <input id="equipTypeCode" type="text" name="equipTypeCode" lay-verify="required|equipTypeCode"
                       placeholder=" " autocomplete="off" class="layui-input" readonly >
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>厂家:</label>
            <div class="layui-input-block">
                <input id="manufacturer" type="text" name="manufacturer" lay-verify="required|manufacturer"
                       placeholder="请输入厂家(必填)" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>启用:</label>
            <div class="layui-input-block">
                <select name="equipTypeEnable" id="equipTypeEnable" lay-filter="equipTypeEnable" lay-verify="required|equipTypeEnable"
                        type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>设备类型名称:</label>
            <div class="layui-input-block">
                <input id="equipTypeName" type="text" name="equipTypeName" lay-verify="required|equipTypeName"
                       placeholder="请输入设备类型名称(必填)" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>控制器型号:</label>
            <div class="layui-input-block">
                <input id="equipControllerModel" type="text" name="equipControllerModel"
                       lay-verify="required|equipControllerModel"
                       placeholder="请输入控制器型号(必填)" autocomplete="off" class="layui-input">
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>通信协议:</label>
            <div class="layui-input-block">
                <input id="protocolCommunication" type="text" name="protocolCommunication"
                       lay-verify="required|protocolCommunication"
                       placeholder="请输入支持通信协议(必填)" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>MES连接IP地址：</label>
            <div class="layui-input-block">
                <input id="mesIpAddress" type="text" name="mesIpAddress" lay-verify="required|mesIpAddress"
                       placeholder="" autocomplete="off" class="layui-input">
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm12">
            <label class="layui-form-label">备注:</label>
            <div class="layui-input-block">
            <textarea cols="50" rows="10" style="width:100%;height:100px" name="remarks" id="remarks" autocomplete="off"
                      class="layui-textarea" lay-verify="remarks"></textarea>
            </div>
        </div>
    </div>
<%--    <div class="layui-form-item layui-row layui-col-space12" style="padding-top: 30px">--%>
<%--        <div class="layui-form-item layui-row layui-hide">--%>
<%--            <div class="layui-input-block">--%>
<%--                &lt;%&ndash;java代码&ndash;%&gt;--%>
<%--                <%--%>
<%--                    IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();--%>
<%--                %>--%>
<%--                <input type="text" class="layui-hide" name="updater" value="<%=usetObject.getUserName()%>"--%>
<%--                       readonly/>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--        <div class="layui-input-block">--%>
<%--            <input type="text" class="layui-hide" name="updateTime"--%>
<%--                   value="<%=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())%>" readonly/>--%>
<%--        </div>--%>
<%--    </div>--%>
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
    layui.admin.renderDictSelect({
        elem: "#equipTypeEnable",
        dictTypeId: "IS_USE"
    });

    //数据字典项加载
    form.render();
    var win = null;
    function SetData(data) {
        win = data.win ? data.win : window;
        var data = data.data;
        form.val("layuiadmin-app-form-list", {
            //要有主键不然修改不了
            "equipTypeId": data.equipTypeId,
            "equipTypeCode": data.equipTypeCode,
            "manufacturer": data.manufacturer,
            "equipTypeEnable":  data.equipTypeEnable,
            "equipTypeName": data.equipTypeName,
            "equipControllerModel": data.equipControllerModel,
            "protocolCommunication": data.protocolCommunication,
            "mesIpAddress": data.mesIpAddress,
            "remarks": data.remarks,
        });
    }
    form.render();


    form.verify({
        equipTypeName: function (value, item) {
            if(!new RegExp("^[a-zA-Z0-9\u4e00-\u9fa5]+$").test(value)){
                return "输入设备类型名称有误，只能输入汉字+英文+数字";
            }
            if (value.length > 20) {
                return "设备类型名称不能超过20字符";
            }
        },
        manufacturer: function (value, item) {
            if(!new RegExp("^[a-zA-Z0-9\u4e00-\u9fa5]+$").test(value)){
                return "输入厂家名称有误，只能输入汉字+英文+数字";
            }
            if (value.length > 20) {
                return "厂家不能超过20字";
            }
        },
        equipControllerModel: function (value, item) {
            if (value.length > 20) {
                return "使用控制器型号不能超过20字";
            }
        },
        protocolCommunication: function (value, item) {
            if (value.length > 50) {
                return "支持的通信协议不能超过50个字符";
            }
        },
        mesIpAddress: function (value, item) {
            function isValidIP(ip) {
                var reg = /^(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])\.(\d{1,2}|1\d\d|2[0-4]\d|25[0-5])$/
                return reg.test(ip);
            }
            if(isValidIP(value) == false){
                return '请输入正确的IP地址';
            }
        },
        remarks: function (value, item) {
            if (value.length > 255) {
                return "备注不能超过255个字符";
            }
        }
    });

    form.render();
    // //日期
    // laydate.render({
    // 	elem: '#invaldate',
    // 	format: 'yyyy-MM-dd',
    // 	//解决时间选择器一闪而过的情况
    // 	trigger: 'click',
    // });
    //
    // var startDate = laydate.render({
    // 	elem: '#star_time',
    // 	//设置日期的类型
    // 	type: 'date',
    // 	trigger:'click',
    // 	done: function(value, date) {
    // 		if (value != "") {
    // 			date.month = date.month - 1;
    // 			date.date = date.date + 1;
    // 			endDate.config.min = date;
    // 		} else {
    // 			endDate.config.min = startDate.config.min;
    // 		}
    // 	},
    // });
    //
    // var endDate = laydate.render({
    // 	//绑定的控件名称
    // 	elem: '#end_time',
    // 	//设置日期的类型
    // 	type: 'date',
    // 	//theme: '#2c78da',
    // 	trigger: 'click',
    // 	done: function(value, date) {
    // 		if (value != "") {
    // 			date.month = date.month - 1;
    // 			date.date = date.date - 1;
    // 			startDate.config.max = date;
    // 		} else {
    // 			startDate.config.max = endDate.config.max;
    // 		}
    // 	}
    // });

    //监听提交
    form.on("submit(layuiadmin-app-form-edit)", function (data) {
        var submitData = JSON.stringify(data.field);
        if (submit == false) {
            submit = true;
            if (isExist == false) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/EquipController/update",
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
                            win.layui.table.reload("LAY-app-equipmentType-list-reload");
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