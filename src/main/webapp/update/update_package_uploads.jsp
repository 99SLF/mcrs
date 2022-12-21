<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="com.zimax.cap.party.IUserObject" %>
<%@ page import="com.zimax.cap.datacontext.DataContextManager" %>
<%@ page import="javax.management.relation.InvalidRoleInfoException" %>
<%@ page import="com.zimax.mcrs.update.pojo.UpdateUpload" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!--
  - Author(s): 李伟杰
  - Date: 2022-12-01 16:12:23
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=equipment-width, initial-scale=1, maximum-scale=1">
    <title>更新包上传</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <script src="common/layui/layui.all.js"></script>
</head>
<body>
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list" enctype="multipart/form-data" style="padding: 20px 30px 0 0;">
    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-md4">
            <label class="layui-form-label"><span style="color:red">*</span>更新包单号:</label>
            <div class="layui-input-block">
                <%--lay-verify="uploadNumber|required 自定义校验要有顺序--%>
                <input id="uploadNumber" type="text" name="uploadNumber" lay-verify="uploadNumber|required"
                       placeholder="" autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

        <div class="layui-col-md4">
            <label class="layui-form-label"><span style="color:red">*</span>是否为主要版本</label>
            <div class="layui-input-block">
                <select name="majorVersion" id="majorVersion" lay-filter="majorVersion" lay-verify="majorVersion|required type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>

        <div class="layui-col-md4">
            <label class="layui-form-label">版本号：</label>
            <div class="layui-input-block">
                <%--从上往下加载顺序--%>
                <input id="version" type="text" name="version" lay-verify="version|required" placeholder=""
                       autocomplete="off" class="layui-input" readonly>
            </div>
        </div>

    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm4">
            <label class="layui-form-label"><span style="color:red">*</span>终端软件类型:</label>
            <div class="layui-input-block">
                <%--下拉选择框--%>
                <select name="deviceSoType" id="deviceSoType" lay-filter="deviceSoType"  lay-verify="deviceSoType|required" majorVersiontype="select">
                    <option value=""></option>
                </select>
            </div>
        </div>

        <div class="layui-col-sm4">
            <label class="layui-form-label"><span style="color:red">*</span>更新策略:</label>
            <div class="layui-input-block">
                <%--下拉选择框--%>
                <select name="uploadStrategy" id="uploadStrategy" lay-filter="uploadStrategy" lay-verify="uploadStrategy|required" type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>
        <div>
            <div class="layui-form-item layui-row layui-col-space10">
                <div class="layui-col-sm4">
                    <label class="layui-form-label"><span style="color:red">*</span>更新包</label>
                    <div class="layui-input-block layui-upload" style="width: 400px">
                        <button type="button" name="url" class="layui-btn layui-btn-sm"
                                id="test1"><i class="layui-icon">&#xe67c;</i>附件上传
                        </button>
                        <span id="demoListView"></span>
                    </div>
                </div>
            </div>

            <div class="layui-form-item layui-row layui-col-space10">
                <label class="layui-form-label">备注：</label>
                <div class="layui-input-block">
        <textarea class="layui-textarea field-effect field-content" name="remarks" id="remarks"
                  autocomplete="off" placeholder="" lay-verify="remarks"></textarea>
                </div>
                <div>

                    <div class="layui-form-item layui-row layui-col-space12">
                        <div class="layui-col-sm4">
                            <label class="layui-form-label">制单时间：</label>
                            <div class="layui-input-block">
                                <input type="text" class="layui-input" name="versionUploadTime"
                                       value="<%=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())%>"
                                       readonly/>
                            </div>
                        </div>
                        <div class="layui-col-sm4">
                            <label class="layui-form-label">制单人:</label>
                            <div class="layui-input-block">
                                <%
                                    IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();
                                %>
                                <input type="text" class="layui-input" id="uploader" name="uploader"
                                       value="<%=usetObject.getUserName()%>" readonly/>
                            </div>
                        </div>

                    </div>
                    <div class="layui-form-item layui-hide">
                        <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit" id="layuiadmin-app-form-submit" value="确认添加">
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
                    //文件上传依赖组件
                    var upload = layui.upload;
                    var submit = false;
                    var isExist = false;
                    var win = null;

                    //表单填充校验，自定义lay-verify
                    form.verify({
                        uploadNumber: function(value, item) { //value：表单的值、item：表单的DOM对象
                            if(value.length < 1 ) {
                                return '请选择附件';
                            }
                        },
                    });
                    form.verify({
                        majorVersion: function(value, item) { //value：表单的值、item：表单的DOM对象
                            if(value.length < 1 ) {
                                return '请选择是否为主要版本';
                            }
                        },
                    });

                    form.verify({
                        version: function(value, item) { //value：表单的值、item：表单的DOM对象
                            if(value.length < 1 ) {
                                return '请选择是否为主要版本';
                            }
                        },
                    });

                    form.verify({
                        deviceSoType: function(value, item) { //value：表单的值、item：表单的DOM对象
                            if(value.length < 1 ) {
                                return '请选择是终端软件类型';
                            }
                        },
                    });

                    form.verify({
                        uploadStrategy: function(value, item) { //value：表单的值、item：表单的DOM对象
                            if(value.length < 1 ) {
                                return '请选择更新策略';
                            }
                        },
                    });

                    layui.admin.renderDictSelect({    //获取终端软件类型
                        elem: "#deviceSoType",
                        dictTypeId: "DEVICE_SOFTWARE_TYPE",
                    });
                    layui.admin.renderDictSelect({	 //获取更新策略
                        elem: "#uploadStrategy",
                        dictTypeId: "UPDATESTRATEGY"
                    });
                    layui.admin.renderDictSelect({	   //是否为主版本号
                        elem: "#majorVersion",
                        dictTypeId: "ISMAINVERSION"
                    });
                    $("#deviceSoType").val();
                    $("#uploadStrategy").val();
                    $("#majorVersion").val();
                    //表单加载，字典项数据
                    form.render();

                    function SetData(data) {
                        win = data.win ? data.win : window;
                    }
                    //通过选择的是否为主要版本带出版本号
                    form.on("select(majorVersion)", function(data) {
                        valuetrue="<%="V2.0"+""%>"
                        valuefalse="<%="V1.0"+""%>"
                        if(data.value == null){
                            /*流水单号*/
                            $("#version").val();

                        } else if(data.value == '001') {
                            $("#version").val(valuetrue);

                        }else {
                            $("#version").val(valuefalse);
                        }

                    });

                    //上传
                    var test = upload.render({
                        //根据绑定id，打开本地
                        elem: "#test1",
                        //上传后台接受接口
                        url: "<%= request.getContextPath() %>/upload/package/upload",
                        //true，为选中文件直接提交，false为不提交根据bindAction属性上的id提交，后端做了判断走了两次的接口，直接是选择就提交了
                        //bindAction: "#layuiadmin-app-form-submit",
                        //是否接受拖拽的文件上传，设置 false 可禁用。不支持ie8/9
                        drag: false,
                        accept: 'file',
                        // //允许上传的文件后缀。一般结合 accept 参数类设定。假设 accept 为 file 类型时，那么你设置 exts: 'zip|rar|7z' 即代表只允许上传压缩格式的文件。如果 accept 未设定，那么限制的就是图片的文件格式
                        // exts: 'txt|rar|zip|doc|docx|pdf|xls|xlsx|jpg|png',//允许上传的文件类型
                        exts: 'zip|rar|7z',
                        //和后端接口命名相同的文件名
                        field:"file",
                        //是否选完文件后自动上传。如果设定 false，那么需要设置 bindAction 参数来指向一个其它按钮提交上传
                        auto: false,
                        dataType:'json',
                        //动态赋值表单值
                        data: {
                            uploadNumber:()=>{
                                return $('#uploadNumber').val();//实现动态传值
                            },
                            majorVersion:()=>{
                                return $('#majorVersion').val();//实现动态传值
                            },
                            version:()=>{
                                return $('#version').val();//实现动态传值
                            },
                            deviceSoType:()=>{
                                return $('#deviceSoType').val();//实现动态传值
                            },
                            uploadStrategy:()=>{
                                return $('#uploadStrategy').val();//实现动态传值
                            },
                            remarks:()=>{
                                return $('#remarks').val();//实现动态传值
                            },
                            // versionUploadTime:()=>{
                            //     return $('#versionUploadTime').val();//实现动态传值
                            // },
                            // uploader:()=>{
                            //     return $('#uploader').val();//实现动态传值
                            // },
                        },
                        // //是否允许多文件上传。设置 true即可开启。不支持ie8/9
                        // multiple: true,
                        // //指定允许上传时校验的文件类型，可选值有：images（图片）、file（所有文件）、video（视频）、audio（音频）

                        //选择文件后的回调函数。返回一个object参数
                        choose: function(obj){
                            obj.preview(function(index, file, result){
                                uploadfileName = file.name;
                                //获取更新包的文件名，将文件名赋值到表单的资源包单号
                                document.getElementById("demoListView").innerHTML= uploadfileName;
                                /*将后端的流水单号绑定前端显示*/
                                value="<%="GX"+(new SimpleDateFormat("yyyy-MM-dd")).format(new Date())+""%>"
                                $("#uploadNumber").val(value);
                            });
                        },
                        done: function (res) {
                            //上传成功刷新页面
                            layer.msg("上传成功", {
                                icon: 1,
                                time: 2000
                            }, function () {
                                var index = parent.layer.getFrameIndex(window.name);
                                win.layui.table.reload("LAY-app-device-list-reload");
                                top.layer.close(index);
                            });
                        },
                        error: function () {
                            // //演示失败状态demoText是图片上传的哪个预读框，并实现重传
                            // var demoText = $("#demoText")
                            // demoText.html('<span style="color: #FF5722;">上传失败</span><a class= "layui-btn layui-btn-mini demo-reload" >重试</a > ');
                            // demoText.find('.demo - reload').on('click', function () {
                            //     uploadInst.upload();
                            //
                            // });
                        }
                    });
                    //提交表单数据
                    form.on('submit(layuiadmin-app-form-submit)', function (data) {
                        debugger;
                        test.upload();
                    });

                    //禁用按钮3秒
                    function disabledSubmitButton(submitButtonName) {
                        $("#" + submitButtonName).attr({"disabled": "disabled"});     //控制按钮为禁用
                        var timeoutObj = null;
                        timeoutObj = setTimeout(function () {
                            $("#" + submitButtonName).removeAttr("disabled");//将按钮可用
                            /* 清除已设置的setTimeout对象 */
                            clearTimeout(timeoutObj);
                        }, 3000);
                    }




                </script>
</body>
</html>