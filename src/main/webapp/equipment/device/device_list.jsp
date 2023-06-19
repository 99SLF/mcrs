<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<!-- 
  - Author(s): 林俊杰，李伟杰
  - Date: 2022-12-01 16:11:58
  - Description:
-->
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <title>终端管理</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/common/layui/css/layui.css"/>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/std/dist/style/admin.css"/>
    <link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v=1.0.0">
    <link rel="stylesheet" href="<%=request.getContextPath() %>/iconfont/iconfont.css">
    <style>
        .layui-card {
            margin-bottom: 0px
        }

        .layui-layer-adminRight {
            top: 0px !important;
            bottom: 0;
            box-shadow: 1px 1px 10px rgba(0, 0, 0, .1);
            border-radius: 0;
            overflow: auto
        }

        .layui-form-item .layui-inline {
            margin-bottom: 0px !important;
            margin-right: 0px !important;
        }

        .layui-form-label {
            width: 120px !important;
            padding: 5px 0px !important;
        }

        .layui-form-item .layui-input-inline {
            float: left;
            width: 150px;
            margin-right: 10px;
        }

        .layui-input {
            height: 30px !important;
        }

        .layui-layer-dialog .layui-layer-padding {
            padding: 20px 20px 20px 20px;
            text-align: center;
        }
    </style>
</head>
<body>
<div class="layui-card">
    <script type="text/html" id="toolbar">
        <div class="layui-form layuiadmin-card-header-auto" lay-filter="layuiadmin-device-form"
             id="layuiadmin-device-form">
            <div class="layui-form-item">
                <div class="layui-inline">
                    <label class="layui-form-label">终端名称：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="deviceName" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">设备资源号：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="equipmentId" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline">
                    <label class="layui-form-label">设备IP：</label>
                    <div class="layui-input-inline">
                        <input type="text" name="equipmentIp" placeholder="" autocomplete="off"
                               class="layui-input">
                    </div>
                </div>
                <div class="layui-inline layui-hide">
                    <button id="LAY-app-device-list-search" class="layui-btn layuiadmin-btn-list" lay-submit
                            lay-filter="LAY-app-device-list-search">
                        <i class="layui-icon layui-icon-search layuiadmin-button-btn"></i>
                    </button>
                </div>
            </div>
        </div>
    </script>
    <div class="layui-card-body">
        <table id="LAY-app-device-list" lay-filter="LAY-app-device-list"></table>

        <script type="text/html" id="table-device-list">
            <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="configurationFile"><i
                    class="layui-icon layui-icon-edit"></i>配置文件</a>
            <a class="layui-btn layui-btn-normal layui-btn-xs" lay-event="edit"><i
                    class="layui-icon layui-icon-edit"></i>编辑</a>
            <a class="layui-btn layui-btn-danger layui-btn-xs" lay-event="del"><i
                    class="layui-icon layui-icon-delete"></i>删除</a>
        </script>
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
    var table = layui.table;
    var form = layui.form;
    var $ = layui.jquery;
    var util = layui.util;
    var admin = layui.admin;
    var view = layui.view;

    //全局参数
    var req_data;

    //功能名
    var funName = "device_list";

    // 高级查询参数
    var advancedFormData = {};
    // 焦点名称
    var focusName = null;

    var hiddenFields = [];

    var formData = {};

    //监听搜索
    form.on("submit(LAY-app-device-list-search)", function (data) {
        var field = data.field;
        reloadData(field);
        formData = {
            deviceName: field.deviceName,
            equipmentId: field.equipmentId,
            equipmentIp: field.equipmentIp
        };
        form.val("layuiadmin-device-form", formData);
        advancedFormData = $.extend(advancedFormData, formData);
        // table.reload("LAY-app-device-list-reload", {
        //     where: field
        // });
    });

    function reloadData(formData) {
        table.reload("LAY-app-device-list-reload", {
            where: formData,
            page: {
                curr: 1
            }
        });
        formReder();
        if (focusName) {
            $("input[name=" + focusName + "]").focus();
        }
    }

    function setFormData(data) {
        advancedFormData = data;
        reloadData(data);
        form.val("layuiadmin-device-form", {
            deviceName: data.deviceName,
            equipmentId: data.equipmentId,
            equipmentIp: data.equipmentIp
        });
    }

    // //软件类型下拉框监听事件
    // form.on("select(deviceSoftwareType)", function (data) {
    //     var submit = $("#LAY-app-device-list-search");
    //     submit.click();
    // });
    //
    // //启用下拉框监听事件
    // form.on("select(enable)", function (data) {
    //     var submit = $("#LAY-app-device-list-search");
    //     submit.click();
    // });
    //
    // //获取软件类型的下拉值
    // layui.admin.renderDictSelect({
    //     elem: "#deviceSoftwareType",
    //     dictTypeId: "DEVICE_SOFTWARE_TYPE",
    // });
    // form.render();
    //
    //
    // //获取启用类型的下拉值
    // layui.admin.renderDictSelect({
    //     elem: "#enable",
    //     dictTypeId: "IS_USE",
    // });
    // form.render();


    // //文本框回车事件
    // $(".layui-input").on("keydown", function (event) {
    //     if (event.keyCode == 13) {
    //         var submit = $("#LAY-app-device-list-search");
    //         submit.click();
    //         return false;
    //     }
    // });


    var active = {
        //查询按钮
        search: function () {
            var submit = $("#LAY-app-device-list-search");
            submit.click();
            return false;
        },
        //高级搜索
        query: function () {
            var url = "<%=request.getContextPath() %>/equipment/device/device_form_query.jsp";
            admin.popupRight({
                type: 2,
                content: [url, "yes"],
                btn: ["查询", "重置", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        win: window,
                        data: advancedFormData
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    var submit = layero.find("iframe").contents().find("#LAY-app-device-search-advanced");
                    submit.click();
                    top.layer.close(index);
                },
                btn2: function (index, layero) {
                    layero.find("iframe")[0].contentWindow.reset();
                }
            });
        },
        //终端注册
        add: function () {
            top.layer.open({
                type: 2,
                title: "注册终端",
                content: "<%= request.getContextPath() %>/equipment/device/devicel_regist.jsp",
                area: ["600px", "560px"],
                resize: false,
                btn: ["确定", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        win: window,
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    var submit = layero.find("iframe").contents().find("#layuiadmin-app-form-submit");
                    submit.click();
                }
            });
        },
        //升级
        upgrade: function () {

            //获取表单的所有内容
            var checkStatus = table.checkStatus("LAY-app-device-list-reload");
            var data = checkStatus.data;
            var numLength = data.length;
            var maxVersions = new Array();


            //获取所有返回数据的版本号
            for (var i = 0; i < data.length; i++) {
                maxVersions[i] = data[i].version;
            }

            // 获取最大值版本号最大值：
            var maxVersion = maxVersions[0];

            //返回选择数据中所有版本号中的最大值maxVersion
            for (var i = 1; i < maxVersions.length; i++) {
                var cur = maxVersions[i];
                cur > maxVersion ? maxVersion = cur : null
            }
            // console.log(maxVersion);

            if (data.length == 0) {
                layer.msg("请至少选中一条记录！");
            }
            if (data.length > 0) {
                var deviceIds = new Array();
                var deviceSoftwareTypes = new Array();
                var enables = new Array();
                var registerStatuses = new Array();
                for (var i = 0; i < data.length; i++) {
                    deviceIds[i] = data[i].deviceId;
                }
                for (var i = 0; i < data.length; i++) {
                    deviceSoftwareTypes[i] = data[i].deviceSoftwareType;
                }

                //判断该数组中的内容是否都一样，1、如果数组长度为一，就返回true
                function same(arr) {
                    if (arr.length === 1) {
                        return true;
                    } else {
                        //2、如果数组长度大于一
                        if (arr.length > 0) {
                            return !arr.some(function (value, index) {
                                return value !== arr[0];
                            });
                        } else {
                            return true;
                        }

                    }
                }

                //获取是否启用值
                for (var i = 0; i < data.length; i++) {
                    enables[i] = data[i].enable;
                }
                //获取注册状态
                for (var i = 0; i < data.length; i++) {
                    registerStatuses[i] = data[i].registerStatus;
                }


                //数值中是否存在未启用(注册状态)的一条数据
                function contains(arr, val) {
                    for (var i = 0; i < arr.length; i++) {
                        if (arr[i] === val) {
                            return true;
                        }
                    }
                    return false;
                }

                //101 是 102 否
                var isab = contains(enables, '102');

                //101 已注册 102 未注册
                var isre = contains(registerStatuses, '102');
                var isSame = same(deviceSoftwareTypes);
                var deviceSoftwareType = deviceSoftwareTypes[0];
                var deviceSoftwareTypeLength = layui.admin.getDictText("DEVICE_SOFTWARE_TYPE", deviceSoftwareType);
                if (isre == true) {
                    layer.msg("升级的终端，存在未注册！");
                } else {
                    if (isab == true) {
                        layer.msg("所选终端未启用，无法升级！");
                    } else {
                        if (isSame == false) {
                            layer.msg("升级的终端类型，类型必须一致！");
                        } else {
                            // layer.confirm("确定升级所选终端？", {
                            //     icon: 3,
                            //     title: "系统提示"
                            // }, function (index) {
                            // layer.msg('<span style="color: red">终端类型：</span>' + deviceSoftwareTypeLength +'</br>'+ '<span>终端数量：</span>' + numLength , {
                            //     icon: 3,
                            //     time : 800000,
                            //     shade: 0.6,
                            //     success: function(layero,index){
                            //         var msg = layero.text();
                            //         var i = 300;
                            //         var timer = null;
                            //         var fn = function() {
                            //             layero.find(".layui-layer-content").text('倒计时：'+i +msg);
                            //             if(!i) {
                            //                 layer.close(index);
                            //                 clearInterval(timer);
                            //             }
                            //             i--;
                            //         };
                            //         timer = setInterval(fn, 1000);
                            //         fn();
                            //     },
                            // }, function() {
                            layer.alert('<span>终端类型：</span>' + deviceSoftwareTypeLength + '</br>' + '<span>终端数量：</span>' + numLength, {
                                time: 5 * 1000
                                , skin: 'layui-layer-molv' //样式类名
                                , btn: ["升级"]
                                , closeBtn: ''
                                , success: function (layero, index) {
                                    var timeNum = this.time / 1000, setText = function (start) {
                                        layer.title((start ? timeNum : --timeNum) + ' 秒后自动关闭', index);
                                    };
                                    setText(!0);
                                    this.timer = setInterval(setText, 1000);
                                    if (timeNum <= 0) clearInterval(this.timer);
                                }
                                , end: function () {
                                    clearInterval(this.timer);
                                    top.layer.open({
                                        //弹窗
                                        type: 2,
                                        title: "选择更新版本",
                                        content: "<%=request.getContextPath() %>/update/update_package_selectVersion.jsp",
                                        area: ["800px", "560px"],
                                        resize: false,
                                        btn: ["确定", "取消"],
                                        success: function (layero, index) {
                                            var dataJson = {
                                                win: window,
                                                deviceIds: deviceIds,
                                                maxVersion: maxVersion,
                                                deviceSoftwareType: deviceSoftwareType
                                            };
                                            layero.find("iframe")[0].contentWindow.SetData(dataJson);
                                        },
                                        yes: function (index, layero) {
                                            var submit = layero.find("iframe").contents().find("#upgrade");
                                            submit.click();

                                            //top.layer.close(index);
                                            <%--top.layui.index.openTabsPage("<%=request.getContextPath() %>/equipment/deviceUpgrade/device_upgrade_list.jsp", "升级记录");--%>
                                        }
                                    });
                                }
                            });
                            // table.reload("LAY-app-device-list-reload");
                            // });


                        }
                    }
                }


            }

        },
//日志文件查看
        viewLog:function (){
            var checkStatus = table.checkStatus("LAY-app-device-list-reload");
            var data = checkStatus.data;
           if(data.length==0){
               layer.msg("请选中一条记录！");
           }else if(data.length>1){
                layer.msg("请选中一条记录！");
            }else{
               top.layer.open({
                   //弹窗
                   type: 2,
                   title: "日志文件查看",
                   content: "<%=request.getContextPath() %>/equipment/logFile/list.jsp",
                   area: ["1024px", "560px"],
                   resize: false,
                   btn: ["关闭"],
                   success: function (layero, index) {
                       var dataJson = {
                           win: window,
                           equipmentId: data[0].equipmentId,
                           port: data[0].equipmentContinuePort,
                           equipmentIp: data[0].equipmentIp
                       };
                       layero.find("iframe")[0].contentWindow.SetData(dataJson);
                   },
                   yes: function (index, layero) {
                       top.layer.close(index);
                       <%--top.layui.index.openTabsPage("<%=request.getContextPath() %>/equipment/deviceUpgrade/device_upgrade_list.jsp", "升级记录");--%>
                   }
               });
           }
        },
        //回退
        rollback: function () {
            var checkStatus = table.checkStatus("LAY-app-device-list-reload");
            var data = checkStatus.data;
            var numLength = data.length;
            var minVersions = new Array();
            for (var i = 0; i < data.length; i++) {
                minVersions[i] = data[i].version;
            }

            // 获取最小值：
            var minVersion = minVersions[0];
            for (var i = 1; i < minVersions.length; i++) {
                var cur = minVersions[i];
                cur < minVersion ? minVersion = cur : null
            }
            console.log(minVersion)

            //至少选择了一条注释
            if (data.length == 0) {
                layer.msg("请至少选中一条记录！");
            }
            if (data.length > 0) {

                //终端主键数组
                var deviceIds = new Array();
                var deviceSoftwareTypes = new Array();
                var enables = new Array();
                var registerStatuses = new Array();
                //存放到终端数组
                for (var i = 0; i < data.length; i++) {
                    deviceIds[i] = data[i].deviceId;
                }
                for (var i = 0; i < data.length; i++) {
                    deviceSoftwareTypes[i] = data[i].deviceSoftwareType;
                }

                //1、如果数组长度为一，就返回true
                function same(arr) {
                    if (arr.length === 1) {
                        return true;
                    } else {
                        //2、如果数组长度大于一
                        if (arr.length > 0) {
                            return !arr.some(function (value, index) {
                                return value !== arr[0];
                            });
                        } else {
                            return true;
                        }

                    }
                }

                //获取启用状态
                for (var i = 0; i < data.length; i++) {
                    enables[i] = data[i].enable;
                }
                //获取注册状态
                for (var i = 0; i < data.length; i++) {
                    registerStatuses[i] = data[i].registerStatus;
                }

                function contains(arr, val) {
                    for (var i = 0; i < arr.length; i++) {
                        if (arr[i] === val) {
                            return true;
                        }
                    }
                    return false;
                }

                //101 是 102 否
                var isab = contains(enables, '102');

                //101 已注册 102 未注册
                var isre = contains(registerStatuses, '102');
                var isSame = same(deviceSoftwareTypes);
                var deviceSoftwareType = deviceSoftwareTypes[0];
                var deviceSoftwareTypeLength = layui.admin.getDictText("DEVICE_SOFTWARE_TYPE", deviceSoftwareType);
                if (isre == true) {
                    layer.msg("回退的终端，存在未注册！");
                } else {
                    if (isab == true) {
                        layer.msg("所选终端未启用，无法回退！");
                    } else {
                        if (minVersion == "1.0") {
                            layer.msg("所选终端存在初始版本，无需回退！");
                        } else {
                            if (isSame == false) {
                                layer.msg("回退的终端类型，类型必须一致！");
                            } else {

                                layer.alert('<span>终端类型：</span>' + deviceSoftwareTypeLength + '</br>' + '<span>终端数量：</span>' + numLength, {
                                    time: 5 * 1000
                                    , skin: 'layui-layer-molv' //样式类名
                                    , btn: ["回退"]
                                    , closeBtn: ''
                                    , success: function (layero, index) {
                                        var timeNum = this.time / 1000, setText = function (start) {
                                            layer.title((start ? timeNum : --timeNum) + ' 秒后自动关闭', index);
                                        };
                                        setText(!0);
                                        this.timer = setInterval(setText, 1000);
                                        if (timeNum <= 0) clearInterval(this.timer);
                                    }
                                    , end: function () {
                                        clearInterval(this.timer);
                                        top.layer.open({
                                            //弹窗
                                            type: 2,
                                            title: "选择回退版本",
                                            content: "<%=request.getContextPath() %>/update/update_package_selectVersion_rollback.jsp",
                                            area: ["800px", "560px"],
                                            resize: false,
                                            btn: ["确定", "取消"],
                                            success: function (layero, index) {
                                                var dataJson = {
                                                    win: window,
                                                    deviceIds: deviceIds,
                                                    minVersion: minVersion,
                                                    deviceSoftwareType: deviceSoftwareType
                                                };
                                                layero.find("iframe")[0].contentWindow.SetData(dataJson);
                                            },
                                            yes: function (index, layero) {

                                                var submit = layero.find("iframe").contents().find("#rollback");
                                                submit.click();

                                                //top.layer.close(index);
                                                <%--top.layui.index.openTabsPage("<%=request.getContextPath() %>/equipment/deviceUpgrade/device_upgrade_list.jsp", "升级记录");--%>
                                            }
                                        });
                                    }
                                });

                                // table.reload("LAY-app-device-list-reload");
                            }
                        }
                    }

                }


            }

        },

        //批量删除
        batchdel: function () {
            var checkStatus = table.checkStatus("LAY-app-device-list-reload");
            var data = checkStatus.data;
            if (data.length == 0) {
                layer.msg("请至少选中一条记录！");
            }
            if (data.length > 0) {
                var deviceIds = new Array();
                for (var i = 0; i < data.length; i++) {
                    deviceIds[i] = data[i].deviceId;
                }
                layer.confirm("确定删除所选终端信息？", {
                    icon: 3,
                    title: "系统提示"
                }, function (index) {
                    $.ajax({
                        url: "<%= request.getContextPath() %>/equipment/device/batchDelete",
                        type: "DELETE",
                        data: JSON.stringify(deviceIds),
                        cache: false,
                        contentType: "text/json",
                        success: function (result) {
                            if (result.exception) {
                                layer.alert(result.exception.message, {
                                    icon: 2,
                                    title: "系统提示"
                                });
                            } else if (result) {
                                layer.msg("删除成功", {
                                    icon: 1,
                                    time: 2000
                                }, function () {
                                    table.reload("LAY-app-device-list-reload");
                                    formReder();

                                });
                            } else {
                                layer.msg("删除失败");
                            }

                        },
                        error: function (jqXHR, textStatus, errorThrown) {
                            layer.msg(jqXHR.responseText, {
                                time: 2000,
                                icon: 5
                            });
                        }
                    });
                });
            }
        },
    };

    table.on('sort(LAY-app-device-list)', function (obj) {
        table.reload('LAY-app-device-list-reload', {
            initSort: obj,
            where: {
                feld: obj.field,
                order: obj.type
            }
        });
        formReder();
    });

    //左侧表头按钮事件监听
    table.on("toolbar(LAY-app-device-list)", function (obj) {
        var type = obj.event;
        active[type] ? active[type].call(this) : "";
    });

    //表格排序

    function getFullSize() {
        var fluid = $(".layui-fluid");
        var header = $(".layui-card-header");
        var cardbody = $(".layui-card-body");
        return header.outerHeight(true) + (cardbody.outerHeight(true) - cardbody.height()) + (fluid.outerHeight(true) - fluid.height()) + 2;
    }


    $(window).resize(function () {

        //LAY-app-device-list-reload
        table.reload("LAY-app-device-list-reload", {
            height: "full-" + getFullSize()
        });
        formReder();
    });

    // 查询过滤字段
    $.ajax({
        url: "<%=request.getContextPath() %>/cols/filter/query/" + funName,
        type: "GET",
        async: false,
        cache: false,
        contentType: "text/json",
        success: function (result) {
            if (result) {
                hiddenFields = result.data
            } else {
                layer.msg("查询失败");
            }
        }
    });

    //判断是否隐藏函数
    function isHidden(field) {
        for (var i = 0; i < hiddenFields.length; i++) {
            if (hiddenFields[i].field == field) {
                return true;
            }
        }
        return false;
    }


    table.render({
        elem: "#LAY-app-device-list",
        id: "LAY-app-device-list-reload",
        url: "<%= request.getContextPath() %>/equipment/device/query",
        method: "GET",
        height: "full-" + getFullSize(),
        page: true,
        limit: 30,
        limits: [30, 50, 70, 100],
        toolbar: "#toolbar",
        defaultToolbar: [{
            title: "查询",
            layEvent: "search",
            icon: "layui-icon layui-icon-search layuiadmin-button-btn",
        }, {
            title: "高级查询",
            layEvent: "query",
            icon: "icon iconfont icon-gaojichaxun",
        }, {
            title: "终端注册",
            layEvent: "add",
            icon: "layui-icon layui-icon-add-circle-fine",
        }, {
            title: "批量删除",
            layEvent: "batchdel",
            icon: "layui-icon layui-icon-delete ",
        }, {
            title: "升级",
            layEvent: "upgrade",
            icon: "layui-icon layui-icon-upload-circle",
        }, {
            title: "回退",
            layEvent: "rollback",
            icon: "layui-icon layui-icon-transfer",
        }, {
            title: "日志文件查看",
            layEvent: "viewLog",
            icon: "layui-icon layui-icon-file",
        },"filter"],
        colHideChange: function (col, checked) {
            var field = col.field;
            var hidden = col.hide;
            $.ajax({
                url: "<%=request.getContextPath() %>/cols/filter/set?funName=" + funName + "&field=" + field + "&hidden=" + hidden,
                type: "GET",
                cache: false,
                contentType: "text/json",
                success: function (result) {
                    if (result) {
                    } else {
                        layer.msg("列筛选失败");
                    }
                }
            });
        },
        parseData: function (res) {
            return {
                code: res.code,
                msg: res.msg,
                count: res.total,
                data: res.data
            };
        },
        cols: [[{
            type: "checkbox"
        }, {
            title: "序号",
            type: "numbers"
        }, {
            field: "deviceName",
            title: "终端名称",
            align: "center",
            minWidth: 150,
            hide: isHidden("deviceName"),
            //打开监听
            event: "view",
            //监听打开详情页面
            templet: function (data) {
                return '<span style="color: #09bbfd">' + data.deviceName + '</span>';
            }
        }, {
            field: "deviceSoftwareType",
            title: "终端类型",
            align: "center",
            minWidth: 120,
            hide: isHidden("deviceSoftwareType"),
            templet: function (d) {
                return layui.admin.getDictText("DEVICE_SOFTWARE_TYPE", d.deviceSoftwareType);
            }
        }, {
            field: "version",
            title: "版本号",
            align: "center",
            minWidth: 100,
            hide: isHidden("version")
        }, {
            field: "needUpdate",
            title: "需要更新",
            align: "center",
            minWidth: 120,
            hide: isHidden("needUpdate")
        }, {
            field: "registerStatus",
            title: "注册状态",
            align: "center",
            minWidth: 120,
            hide: isHidden("registerStatus"),
            templet: function (d) {
                return layui.admin.getDictText("REGISTER_STATUS", d.registerStatus);
            }
        }, {
            field: "enable",
            title: "启用",
            align: "center",
            minWidth: 120,
            hide: isHidden("enable"),
            templet: function (d) {
                return layui.admin.getDictText("IS_USE", d.enable);
            }
        }, {
            field: "aPPId",
            title: "APPID",
            align: "center",
            minWidth: 300,
            hide: isHidden("aPPId")
        }, {
            field: "accPointResName",
            title: "接入点名称",
            align: "center",
            minWidth: 100,
            hide: isHidden("accPointResName")
        }, {
            field: "equipmentId",
            title: "设备资源号",
            align: "center",
            minWidth: 140,
            hide: isHidden("equipmentId")
        }, {
            field: "equipTypeName",
            title: "设备类型",
            align: "center",
            minWidth: 100,
            hide: isHidden("equipTypeName"),
        }, {
            field: "equipmentIp",
            title: "设备IP",
            align: "center",
            minWidth: 120,
            hide: isHidden("equipmentIp")
        }, {
            field: "equipmentContinuePort",
            title: "设备连接端口",
            align: "center",
            minWidth: 150,
            hide: isHidden("equipmentContinuePort")
        }, {
            field: "processName",
            title: "工序名称",
            align: "center",
            minWidth: 150,
            hide: isHidden("processName")
        }, {
            field: "factoryName",
            title: "工厂名称",
            align: "center",
            minWidth: 150,
            hide: isHidden("factoryName")
        }, {
            field: "accessMethod",
            title: "接入方式",
            align: "center",
            minWidth: 100,
            hide: isHidden("accessMethod"),
            templet: function (d) {
                return layui.admin.getDictText("ACCESS_METHOD", d.accessMethod);
            }
        }, {
            field: "createName",
            title: "创建人",
            align: "center",
            minWidth: 100,
            hide: isHidden("createName")
        }, {
            field: "createTime",
            title: "创建时间",
            align: "center",
            minWidth: 200,
            hide: isHidden("createTime"),
            templet: function (d) {
                return layui.util.toDateString(d.createTime);
            }

        }, {
            field: "remarks",
            title: "备注",
            align: "center",
            minWidth: 200,
            hide: isHidden("remarks")
        }, {
            title: "操作",
            align: "center",
            fixed: "right",
            width: 250,
            toolbar: "#table-device-list"
        }]]
    });
    formReder();

    function formReder() {

        // 文本框回车事件
        $(".layui-input").on("keydown", function (event) {
            if (event.keyCode == 13) {
                focusName = event.target.name;
                var submit = $("#LAY-app-device-list-search");
                submit.click();
                return false;
            }
        });

        //软件类型下拉框监听事件
        form.on("select(deviceSoftwareType)", function (data) {
            var submit = $("#LAY-app-device-list-search");
            submit.click();
        });

        //启用下拉框监听事件
        form.on("select(enable)", function (data) {
            var submit = $("#LAY-app-device-list-search");
            submit.click();
        });

        //获取软件类型的下拉值
        layui.admin.renderDictSelect({
            elem: "#deviceSoftwareType",
            dictTypeId: "DEVICE_SOFTWARE_TYPE",
        });
        form.render();


        //获取启用类型的下拉值
        layui.admin.renderDictSelect({
            elem: "#enable",
            dictTypeId: "IS_USE",
        });
        form.render();

        form.val("layuiadmin-device-form", formData);
    }

    //监听操作事件
    table.on("tool(LAY-app-device-list)", function (e) {
        var data = e.data;
        if (e.event == "edit") {
            top.layer.open({
                type: 2,
                title: "编辑终端信息",
                content: "<%= request.getContextPath() %>/equipment/device/device_edit.jsp",
                area: ["800px", "560px"],
                resize: false,
                btn: ["确定", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        data: data,
                        win: window
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    var edit = layero.find("iframe").contents().find("#layuiadmin-app-form-edit");
                    edit.click();
                }

            });
        } else if (e.event == "del") {
            layer.confirm("确定删除该终端？", {
                icon: 3,
                title: "系统提示"
            }, function (index) {
                $.ajax({
                    url: "<%= request.getContextPath() %>/equipment/device/logoutDevice/" + data.deviceId,
                    type: "DElETE",
                    data: JSON.stringify({
                        device: data
                    }),
                    cache: false,
                    contentType: "text/json",
                    success: function (result) {
                        if (result.exception) {
                            layer.alert(result.exception.message, {
                                icon: 2,
                                title: "系统提示"
                            });
                        } else if (result) {
                            layer.msg("删除成功", {
                                icon: 1,
                                time: 500
                            }, function () {
                                table.reload("LAY-app-device-list-reload");
                                formReder();
                            });
                        } else {
                            layer.msg("删除失败！", {
                                icon: 2,
                                time: 2000
                            });
                        }
                    },
                    error: function (jqXHR, textStatus, errorThrown) {
                        layer.msg(jqXHR.responseText, {
                            time: 500,
                            icon: 5
                        });
                    }
                });
            });
        } else if (e.event == "configurationFile") {
            var appId = data.aPPId;
            top.layer.open({
                type: 2,
                title: "配置文件列表",
                content: "<%= request.getContextPath() %>/updateConfigFile/list.jsp",
                area: ["1000px", "560px"],
                resize: false,
                btn: ["确定", "取消"],
                success: function (layero, index) {
                    var dataJson = {
                        appId: appId,
                        win: window
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                }
            });
        } else if (e.event == "view") {
            top.layer.open({
                type: 2,
                title: "查看终端详情",
                content: "<%= request.getContextPath() %>/equipment/device/device_view.jsp",
                area: ["1000px", "560px"],
                resize: false,
                btn: ["关闭"],
                success: function (layero, index) {
                    var dataJson = {
                        data: data,
                        win: window
                    };
                    layero.find("iframe")[0].contentWindow.SetData(dataJson);
                },
                yes: function (index, layero) {
                    parent.layer.close(index);
                }

            });
        }
    });

    //批量选中
    $("body").on("click", ".layui-table-body table.layui-table tbody tr td", function () {
        if ($(this).attr("data-field") === "0") return;
        $(this).siblings().eq(0).find("i").click();
    });
</script>
</body>
</html>