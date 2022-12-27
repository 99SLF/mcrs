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
    <title>基础基地数据</title>
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
<div class="layui-fluid">
    <div class="layui-card-body">
        <div class="layui-row layui-col-space10">
            <div class="layui-col-md12">
                <div class="layui-form" lay-filter="matrix-add" id="matrix-add" style="padding:20px;">
                    <input type="hidden" name="processingMaterials" value="0"/>
                    <input type="hidden" name="supplierId" id="supplierId"/>
                    <div class="layui-row layui-col-space10 layui-form-item">
                        <div class="layui-col-sm4">
                            <label class="layui-form-label" ><h1>基地详情</h1></label>
                        </div>
                        <div class="layui-col-sm4">

                        </div>
                        <div class="layui-col-sm2">

                        </div>
                        <div class="layui-col-sm2">
                            <button class="layui-btn " id='save_data' lay-submit lay-filter="save_data">保存</button>
                            <button class="layui-btn " id='canle' lay-submit lay-filter="canle">取消</button>
                        </div>
                    </div>

                    <div class="layui-row layui-col-space10 layui-form-item">
                        <div class="layui-col-sm6">
                            <label class="layui-form-label" >基地名称：</label>
                            <div class="layui-input-block">
                                <input type="text" class="layui-input layui-hide" name="infoId" id="infoId"   autocomplete="off" >
                                <input type="text" class="layui-input layui-hide" name="matrixId" id="matrixId"   autocomplete="off" >
                                <input type="text" class="layui-input" name="matrixName" id="matrixName"   autocomplete="off" >
                            </div>
                        </div>

                        <div class="layui-col-sm6">
                            <label class="layui-form-label" >基地代码：</label>
                            <div class="layui-input-block">
                                <input type="text" class="layui-input" name="matrixCode" id="matrixCode"  lay-verify="length11|float5" autocomplete="off" placeholder="点击保存，自动生成" readonly>
                            </div>
                        </div>
                    </div>

                    <div class="layui-row layui-col-space10 layui-form-item">
                        <label class="layui-form-label" >基地地址：</label>
                        <div class="layui-input-block">
                            <textarea class="layui-textarea" placeholder="" lay-verify="length255" name="matrixAddress" id="matrixAddress"></textarea>
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


                </div>
            </div>
        </div>
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

    //获取树页面传输的树id
    var infoId = <%=request.getParameter("nodeId")%>;
    getmatrix(infoId);
    function getmatrix(infoId){
        debugger;
        //获取数据
        $.ajax({
            url:"<%=request.getContextPath() %>/MatrixController/query?infoId=" + infoId,
            type:"get",
            cache: false,
            contentType:"text/json",
            success: function(rel) {
                debugger;
                var data = rel.data;
                if (data == null ||data.length < 1) {
                    form.val("matrix-add", {
                        infoId: infoId,
                    });
                } else {
                    var data = data[0];
                    form.val("matrix-add", {
                        matrixId: data.matrixId,
                        infoId: data.infoId,
                        matrixName: data.matrixName,
                        matrixCode: data.matrixCode,
                        matrixAddress: data.matrixAddress
                    });
                }
            }
        });
    }


    //监听提交
    form.on("submit(save_data)", function (data) {
        debugger;
        var data = data.field
        if(data.matrixId == null || data.matrixId == "") {
            //新增
            var matrix = JSON.stringify(data);
            debugger;
            $.ajax({
                url: "<%=request.getContextPath() %>/MatrixController/add",
                type: "post",
                data: matrix,
                cache: false,
                contentType: "text/json",
                success: function(result){
                    if (result.code == 0) {
                        layer.msg(result.msg, {
                            icon: 1,
                            time: 2000
                        });
                    } else {
                        layer.msg("新增失败", {icon:2, time:2000});
                    }
                    getmatrix(infoId);
                },
                error: function(){
                    layer.msg("新增失败", {
                        icon: 2,
                        time: 2000
                    });
                }
            });
        } else {
            //修改
            var matrix = JSON.stringify(data);
            debugger;
            $.ajax({
                url: "<%=request.getContextPath() %>/MatrixController/update",
                type: "post",
                data: matrix,
                cache: false,
                contentType: "text/json",
                success: function(result){
                    if (result.code == 0) {
                        layer.msg(result.msg, {
                            icon: 1,
                            time: 2000
                        });
                    } else {
                        layer.msg("修改失败", {icon:2, time:2000});
                    }
                    getmatrix(infoId);
                },
                error: function(){
                    layer.msg("修改失败", {
                        icon: 2,
                        time: 2000
                    });
                }
            });


        }

    });

    //监听取消
    form.on("submit(canle)", function (data) {
        debugger;
        getmatrix(infoId);
    });

</script>
</body>
</html>