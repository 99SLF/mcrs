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
    <style>
        .layui-form-label {
            width: 120px;
        }

        .layui-input-block {
            margin-left: 150px;
            min-height: 36px;

        }
    </style>
    <script src="common/layui/layui.all.js"></script>
    <script type="text/javascript">
        var obj; //建立全局变量
        function getTime() {
            obj = document.getElementById("myDiv"); //得到容器对象
            var myDate = new Date(); //得到时间对象
            var y = myDate.getFullYear(); //获取年
            var m = myDate.getMonth() + 1; //获取月
            m = m > 9 ? m : "0" + m; //如果月份小于10,则在前面加0补充为两位数字
            var d = myDate.getDay(); //获取日
            d = d > 9 ? d : "0" + d; //如果天数小于10,则在前面加0补充为两位数字
            var h = myDate.getHours(); //获取小时
            h = h > 9 ? h : "0" + h; //如果小时数字小于10,则在前面加0补充为两位数字
            var M = myDate.getMinutes(); //获取分
            M = M > 9 ? M : "0" + M; //如果分钟小于10,则在前面加0补充为两位数字
            var s = myDate.getSeconds(); //获取秒
            s = s > 9 ? s : "0" + s; //如果秒数小于10,则在前面加0补充为两位数字
            // var NowTime = y + "年" + m + "月" + d + "日" + h + ":" + M + ":" + s; //串联字符串用于输入
            var NowTime = y + "-" + m + "-" + d + "-" + h + ":" + M + ":" + s; //串联字符串用于输入
            obj.value = NowTime;// 在文本框中输入时间
            window.setTimeout("getTime()", 1000); //每隔1秒自动变换时间
        }
    </script>
</head>
<body onLoad="getTime()"><!--页面加载时候自动获取时间-->
<div class="layui-form" lay-filter="layuiadmin-app-form-list" id="layuiadmin-app-form-list"
     enctype="multipart/form-data" style="padding: 20px 30px 0 0;">
    <div class="layui-form-item layui-row layui-col-space10">
        <%--        <div class="layui-col-md4">--%>
        <%--            <label class="layui-form-label"><span style="color:red">*</span>更新包单号:</label>--%>
        <%--            <div class="layui-input-block">--%>
        <%--                &lt;%&ndash;lay-verify="uploadNumber|required 自定义校验要有顺序&ndash;%&gt;--%>
        <%--                <input id="uploadNumber" type="text" name="uploadNumber" lay-verify="uploadNumber|required"--%>
        <%--                       placeholder="请先选择需要上传的更新包" autocomplete="off" class="layui-input" disabled>--%>
        <%--            </div>--%>
        <%--        </div>--%>
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>终端软件类型:</label>
            <div class="layui-input-block">
                <%--下拉选择框--%>
                <select name="deviceSoType" id="deviceSoType" lay-filter="deviceSoType"
                        lay-verify="deviceSoType|required" type="select">
                    <option value=""></option>
                </select>
            </div>
        </div>

        <div class="layui-col-sm4">
            <label class="layui-form-label">最新版本号：</label>
            <div class="layui-input-block">
                <input id="lastversion" type="text" name="lastversion" lay-verify="lastversion|required" placeholder=""
                       autocomplete="off" class="layui-input" readonly>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>是否为主要版本</label>
            <div class="layui-input-block">
                <select name="majorVersion" id="majorVersion" lay-filter="majorVersion"
                        lay-verify="majorVersion|required" type="select" disabled>
                    <option value=""></option>
                </select>
            </div>
        </div>
        <div class="layui-col-sm4">
            <label class="layui-form-label">版本号：</label>
            <div class="layui-input-block">
                <%--从上往下加载顺序--%>
                <input id="version" type="text" name="version" lay-verify="version|required" placeholder=""
                       autocomplete="off" class="layui-input" disabled>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">

        <div class="layui-col-sm6">
            <label class="layui-form-label"><span style="color:red">*</span>更新策略:</label>
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
                <label class="layui-form-label"><span style="color:red">*</span>更新包</label>
                <div class="layui-input-block layui-upload" style="width: 400px">
                    <button type="button" name="url" class="layui-btn layui-btn-sm"
                            id="test1"><i class="layui-icon">&#xe67c;</i>附件上传
                    </button>
                    <span id="demoListView"></span>
                </div>
            </div>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space10">
        <label class="layui-form-label">备注：</label>
        <div class="layui-input-block">
                <textarea class="layui-textarea field-effect field-content" name="remarks" id="remarks"
                          autocomplete="off" placeholder="" lay-verify="remarks"></textarea>
        </div>
    </div>

    <div class="layui-form-item layui-row layui-col-space12">
        <div class="layui-col-sm6">
            <label class="layui-form-label" style="margin-top: 10px;">制单时间：</label>
            <div class="layui-input-block" id="div" style="width: 200px;margin-top: 10px; ">
                <%--                <input type="text" class="layui-input" name="versionUploadTime"--%>
                <%--                       value="<%=(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss")).format(new Date())%>"--%>
                <%--                       readonly/>--%>
                <input type="text" class="layui-input" name="versionUploadTime" id="myDiv" size="150"
                       readonly/>
            </div>
        </div>
        <div class="layui-col-sm6">
            <label class="layui-form-label" style="margin-top: 10px;">制单人:</label>
            <div class="layui-input-block" style="width: 200px;margin-top: 10px; ">
                <%IUserObject usetObject = DataContextManager.current().getMUODataContext().getUserObject();%>
                <input type="text" class="layui-input" id="uploader" name="uploader" value="<%=usetObject.getUserName()%>" size="150" readonly/>
            </div>
        </div>
    </div>
    <div class="layui-form-item layui-hide">
        <input type="button" lay-submit lay-filter="layuiadmin-app-form-submit"
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
<script>
    // var i=0;
    // function myDate(){
    // var now=new Date();
    // var year=now.getFullYear();
    // var month=now.getMonth()+1;
    // month=month>9?month:"0"+month;
    //     var day=now.getDate();
    // var hours=now.getHours();
    // var minutes=now.getMinutes();
    // var seconds=now.getSeconds();
    //
    // document.getElementById("div").innerHTML=year+"年"+month+"月"+day+"日"+hours+"时"+":"+minutes+"分"+":"+seconds+"秒";
    // }
    // setInterval(myDate,1000);
</script>

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

    // 全局变量，用户从存储从后端查询出来的结果数据
    var allDatas = null;

    //存储最新版本号的值
    var lastVersionVal = null;

    //表单填充校验，自定义lay-verify
    form.verify({
        uploadNumber: function (value, item) { //value：表单的值、item：表单的DOM对象
            if (value.length < 1) {
                return '请选择附件';
            }
        },
    });
    form.verify({
        majorVersion: function (value, item) { //value：表单的值、item：表单的DOM对象
            if (value.length < 1) {
                return '请选择是否为主要版本';
            }
        },
    });

    form.verify({
        version: function (value, item) { //value：表单的值、item：表单的DOM对象
            if (value.length < 1) {
                return '请选择是否为主要版本';
            }
        },
    });

    form.verify({
        deviceSoType: function (value, item) { //value：表单的值、item：表单的DOM对象
            if (value.length < 1) {
                return '请选择是终端软件类型';
            }
        },
    });

    form.verify({
        uploadStrategy: function (value, item) { //value：表单的值、item：表单的DOM对象
            if (value.length < 1) {
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


    form.on("select(deviceSoType)", function (data) {
        var deviceSoType = data.value;
        //调用更新包查询的后端
        $.ajax({
            url: "<%= request.getContextPath() %>/upload/getUpdateUpload?deviceSoType=" + deviceSoType,
            type: "GET",
            async: false,//默认是true异步传输，false是同步传输
            cache: false,
            contentType: "text/json",
            success: function (result) {
                if (result) {

                    //从后端获取的返回值数据存储到到allDatas
                    debugger;
                    if (data.value == null || data.value == "") {
                        $("#lastversion").val("");
                        $("#version").val("");
                        $("#majorVersion").val("");
                        form.render();
                    } else if (result.data.length == 0) {
                        //无最新的版本
                        $("#majorVersion").val("001");
                        $("#lastversion").val("无最新版本");
                        $("#majorVersion").attr("disabled", "disabled");
                        form.render();
                        var value = "1.0";
                        $("#version").val(value)
                    } else {
                        $("#majorVersion").val("");
                        $("#version").val("");
                        //取消下拉选择框的经用
                        $("#majorVersion").removeAttr("disabled");
                        //渲染，很重要
                        form.render();
                        allDatas = result.data;
                        lastVersionVal = allDatas[0].version;
                        //将后端获取的版本号赋值给最新版本号的输入框
                        $("#lastversion").val(lastVersionVal);
                    }

                } else {
                    layer.msg("找不到最新版本数据");
                }
            }
            // ,parseData: function(res){ //res 即为原始返回的数据。为表格数据使用
            //     versionData = res.data;
            //     return {
            //         "msg": res.msg, //解析提示文本
            //         "data": res //解析数据列表
            //     };
            // }
        });


    });
    //通过选择的是否为主要版本来确定版本递增
    form.on("select(majorVersion)", function (data) {
        debugger;
        if (data.value == "null" || data.value == "") {
            $("#version").val("");
        } else if (data.value == '001') {
            $("#version").val(Math.floor(Number(lastVersionVal) + 1).toFixed(1));

        } else {
            var result = (Number(lastVersionVal) + 0.1).toString().substr(0, 1)
                + (Number(lastVersionVal) + 0.1).toString().substring(1, 1 + (1 + 1));
            $("#version").val(result);

        }
        form.render();
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
        exts: 'zip|rar',
        //和后端接口命名相同的文件名
        field: "file",
        //是否选完文件后自动上传。如果设定 false，那么需要设置 bindAction 参数来指向一个其它按钮提交上传
        auto: false,
        dataType: 'json',
        //动态赋值表单值
        data: {
            // uploadNumber:()=>{
            //     return $('#uploadNumber').val();//实现动态传值
            // },
            majorVersion: () => {
                return $('#majorVersion').val();//实现动态传值
            },
            version: () => {
                return $('#version').val();//实现动态传值
            },
            deviceSoType: () => {
                return $('#deviceSoType').val();//实现动态传值
            },
            uploadStrategy: () => {
                return $('#uploadStrategy').val();//实现动态传值
            },
            remarks: () => {
                return $('#remarks').val();//实现动态传值
            },
            // versionUploadTime:()=>{//后端设置，前端不带了，前端只是显示
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
        choose: function (obj) {
            obj.preview(function (index, file, result) {
                uploadfileName = file.name;
                //获取更新包的文件名，将文件名赋值到表单的资源包单号
                document.getElementById("demoListView").innerHTML = uploadfileName;
                /*将后端的流水单号绑定前端显示*/
                value = "<%="GX"+(new SimpleDateFormat("yyyy-MM-dd")).format(new Date())+""%>"
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
                win.layui.table.reload("LAY-app-update_package-list-reload");
                win.formReder();
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
        if (document.getElementById("demoListView").innerHTML == null || document.getElementById("demoListView").innerHTML == "") {
            layer.msg("请选择文件");
        } else {
            test.upload();
        }
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