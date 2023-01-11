<%--
  Created by IntelliJ IDEA.
  User: 王广玉
  Date: 2023/1/11
  Time: 13:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>新增配置文件</title>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css" />
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.1">
</head>
<body>
<div class="layui-fluid">
    <div class="layui-form" lay-filter="coding-add" id="coding-add" style="padding: 20px 30px 0 0;">
        <div class="layui-row layui-col-space10 layui-form-item" >
            <input type="text"  class="layui-hide" name="configPath" id="configPath">
            <input type="text"  class="layui-hide" name="appId" id="appId">
            <input type="text"  class="layui-hide" name="fileName" id="fileName">
            <input type="text"  class="layui-hide" name="fileId" id="fileId">
            <input type="text"  class="layui-hide" name="filePath" id="filePath">
            <div class="layui-input-block">
                <textarea class="layui-textarea" id="fileCont" name="fileCont" style="height: 350px"></textarea>
            </div>
        </div>

        <div class="layui-form-item layui-hide">
            <button class="layui-btn layui-btn-normal layui-hide" id='save_data' lay-submit lay-filter="save_data"></button>
        </div>
    </div>
</div>

<script src="<%=request.getContextPath()%>/common/layui/layui.all.js"></script>
<script>
    layui.config({
        base: "<%=request.getContextPath()%>/"
    });
</script>
<script src="<%=request.getContextPath()%>/std/dist/index.all.js"></script>
<script type="text/javascript">
    var layer = layui.layer;
    var table = layui.table;
    var form = layui.form;
    var $ = layui.jquery;
    var appId = null;

    form.verify({
        //数组的两个值分别代表：[正则匹配、匹配不符时的提示文字]
        chinese: function(value, item){ //value：表单的值、item：表单的DOM对象
            var reg = new RegExp("[\\u4E00-\\u9FFF]+", "g");
            if((reg.test(value))){
                return '此项不能包含中文';
            }
        },
        english: function(value, item){ //value：表单的值、item：表单的DOM对象
            var reg = new RegExp("[\\u4E00-\\u9FFF]+", "g");
            var reg1 = /[a-zA-Z]/;
            if((reg.test(value)|| reg1.test(reg1))){
                return '此项不能包含中英文';
            }
        },
        length11: function(value, item){ //value：表单的值、item：表单的DOM对象
            if(value.length>11){
                return '字数已达上限';
            }
        },
        length9: function(value, item){ //value：表单的值、item：表单的DOM对象
            if(value.length>9){
                return '字数已达上限';
            }
        },
        length4: function(value, item){ //value：表单的值、item：表单的DOM对象
            if(value.length>4){
                return '字数已达上限';
            }
        },
        length2: function(value, item){ //value：表单的值、item：表单的DOM对象
            if(value.length>2){
                return '字数已达上限';
            }
        },
        length32: function(value, item){ //value：表单的值、item：表单的DOM对象
            if(value.length>32){
                return '字数已达上限';
            }
        },
        length100: function(value, item){ //value：表单的值、item：表单的DOM对象
            if(value.length>100){
                return '字数已达上限';
            }
        },
        length255: function(value, item){ //value：表单的值、item：表单的DOM对象
            if(value.length>255){
                return '字数已达上限';
            }
        }
    });


    var win=null;
    function SetData(obj) {
        win = obj.win ? obj.win : window;
        data = obj.data ? obj.data : null;
        fileCont = obj.fileCont ? obj.fileCont : null;
        form.val("coding-add",{
            "appId": data.appId,
            "fileCont" : fileCont,
            "fileId": data.fileId,
            "configPath": data.configPath,
            "filePath": data.filePath,
            "fileName": data.fileName
        });
    }

    //监听按钮提交事件
    var submit = false;
    form.on('submit(save_data)', function(data) {
        if(submit == false){
            submit = true ;
            //JSON.stringify(data.field)

            $.ajax({
                url : "<%=request.getContextPath() %>/updateConfig/updatefile",
                type : 'POST',
                data : JSON.stringify(
                    data.field
                ),
                cache : false,
                contentType : 'text/json',
                success : function(result) {
                    if(result.code == "200"){
                        layer.msg(result.msg, {icon : 1,time : 1500},function() {
                            var index = top.layer.getFrameIndex(window.name);
                            win.layui.table.reload('tableReload');
                            top.layer.close(index);
                        });
                    } else {
                        layer.msg(result.msg, {icon : 2,time : 1500},function() {
                            submit = false;
                        });
                    }
                }
            });
        }else{
            layer.msg("正在提交中，请不要点击确定和取消！",{
                time:2000,
                icon:0,
            });
        }
    });

    //禁用按钮3秒
    function disabledSubmitButton(submitButtonName){
        $("#"+submitButtonName).attr({"disabled":"disabled"});     //控制按钮为禁用
        var timeoutObj = setTimeout(function () {
            $("#"+submitButtonName).removeAttr("disabled");//将按钮可用
            /* 清除已设置的setTimeout对象 */
            clearTimeout(timeoutObj)
        }, 3000);
    }

</script>
</body>
</html>