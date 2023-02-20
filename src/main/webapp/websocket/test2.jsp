<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <title>Layui</title>
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
    <link rel="stylesheet" href="../static/lib/layui/css/layui.css" media="all">
    <!-- 注意：如果你直接复制所有代码到本地，上述css路径需要改成你本地的 -->
    <!--    <script type="text/javascript" src="../static/js/jquery-3.4.1.js"></script>-->
    <style>
        .memberstatus-span-left {
            font-size: 25px;
        }

        .memberstatus-span-right {
            font-size: 25px;
        }
    </style>
</head>
<body>

<table class="layui-hide" id="test" lay-filter="test"></table>

<script src="../static/lib/layui/layui.js" charset="utf-8"></script>
<!-- 注意：如果你直接复制所有代码到本地，上述js路径需要改成你本地的 -->

<script>
    layui.use(['table', 'element'], function () {
        var table = layui.table;
        var layer = layui.layer;
        //注意进度条依赖 element 模块，否则无法进行正常渲染和功能性操作
        var element = layui.element;

        table.render({
            elem: '#test'
            // ,url:'memberStatus?search=1'
            , cellMinWidth: 80 //全局定义常规单元格的最小宽度，layui 2.2.1 新增
            , data: []
            // ,autoSort: false //取消自动排序
            , cols: [
                [
                    // {field:'id', title: 'ID', align: 'center',sort: true}
                    , {
                    field: 'memberName',
                    title: '人员名称',
                    align: 'center',
                    sort: true
                } //width 支持：数字、百分比和不填写。你还可以通过 minWidth 参数局部定义当前单元格的最小宽度，layui 2.2.1 新增
                    , {
                    field: 'team',
                    title: '队伍',
                    align: 'center',
                    sort: true,
                    templet: function (d) {
                        if (parseInt(d.team) == '1') {
                            // return '<span style="background-color: #FF5722;">红队</span>'
                            return '<i class="layui-icon layui-icon-group" style="font-size: 30px; color: #FF5722;"></i>  '
                        } else if (parseInt(d.team) == '2') {
                            // return '<span style="background-color: #01AAED;">蓝队</span>'
                            return '<i class="layui-icon layui-icon-group" style="font-size: 30px; color: #01AAED;"></i>  '
                        } else {
                            return d.team
                        }
                    }
                } //单元格内容水平居中
                    , {field: 'deviceCode', title: '装备编号', align: 'center', sort: true} //width 支持：数字、百分比和不填写。你还可以通过 minWidth 参数局部定义当前单元格的最小宽度，layui 2.2.1 新增
                    // ,{field:'hp', title: '血量', align: 'center',sort: true}
                    , {
                    field: 'hp', title: '血量', align: 'center', sort: true, templet: function (d) {
                        //判断颜色
                        var ys = '';
                        if (30 < d.hp && d.hp < 100) {
                            ys = 'layui-bg-orange'
                        } else if (0 < d.hp && d.hp <= 30) {
                            ys = 'layui-bg-red'
                        }
                        return '<div class="layui-progress layui-progress-big" lay-showpercent="true"><div class="layui-progress-bar ' + ys + '" lay-percent="' + d.hp + '%"></div></div><br>'
                    }
                }
                    , {field: 'hitedNumber', title: '中弹数', align: 'center', sort: true}
                    , {field: 'hitNumber', title: '击中数', align: 'center', sort: true}
                    , {field: 'rePlenishBullet', title: '补弹次数', align: 'center', sort: true}
                    , {field: 'reviveNum', title: '复活次数', align: 'center', sort: true}

                ]
            ]
            , done: function (res, currentCount) {
                element.render()
            }
        });


        var websocket = null;

        //判断当前浏览器是否支持WebSocket
        if ('WebSocket' in window) {
            websocket = new WebSocket("ws://" + window.location.host + "/websocket/memberstatus");
        } else {
            alert('Dont support websocket')
        }

        //连接发生错误的回调方法
        websocket.onerror = function () {
            console.log("error");
        };

        //连接成功建立的回调方法
        websocket.onopen = function () {
            console.log("open");
        };

        //接收到消息的回调方法
        websocket.onmessage = function (event) {
            var obj = JSON.parse(event.data);
            if (obj && "memberstatus" == obj.type) {
                // console.log(obj.data)
                table.reload('test', {
                    elem: '#test'
                    , data: JSON.parse(obj.data)
                });
            }
        };

        //连接关闭的回调方法
        websocket.onclose = function () {
            console.log("close");
        };

        //监听窗口关闭事件，当窗口关闭时，主动去关闭websocket连接，防止连接还没断开就关闭窗口，server端会抛异常。
        window.onbeforeunload = function () {
            websocket.close();
        };

        //关闭连接
        function closeWebSocket() {
            websocket.close();
            window.clearInterval(intervalId);
        }

        //发送消息
        function send() {
            var message = document.getElementById('text').value;
            websocket.send(message);
        }


    });

</script>

</body>
</html>