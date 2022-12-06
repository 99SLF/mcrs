var pages;
var thispages;

function submit() {
    var form = layui.form;
    //注册
    form.on('submit(register)', function (data) {
    	var user = {userId:data.field.userId,userName:data.field.userId,password:data.field.password,mobile:data.field.mobile,email:data.field.email};
        $.post(contextPath + "/com.zimax.components.coframe.auth.LoginManager.register.biz.ext", user, function (res) {
            if (res.retCode == 1) {
                layer.msg("注册成功", { time: 2000, icon: 1 }, function() {
                    $("#userId").val(data.field.userId);
                    $("#password").val(data.field.password);
                    var login = document.getElementById("login");
                    login.click();
                });
            } else {
                layer.msg("用户已存在，注册失败", { time: 2000, icon: 5 });
            }
        }, 'json');
        return false;
    });

    /**
     * 登录
     */
    form.on("submit(login)", function(data) {
    	$.ajax({
    		url: contextPath + "/auth/login",
    		type: "POST",
    		async: true,
    		contentType: "text/json",
    		data: JSON.stringify(data.field),
    		success: function(res) {
    			var url = getQueryVariable("url");
    			if (res.code == 0) {
    				if (data.field.remember === "on") {
    					var exp = new Date;
    					exp.setDate(exp.getDate() + 7);
						document.cookie = "loginInfo=" + escape(JSON.stringify({
							userId: data.field.userId,
							password: data.field.password
						})) + ";expires=" + exp.toGMTString();
    				} else {
    					var exp = new Date();
    					exp.setTime(exp.getTime() - 1);
    					document.cookie = "loginInfo=" + escape({
							userId: data.field.userId,
							password: data.field.password
						}) + ";expires=" + exp.toGMTString();
    				}
    				layer.msg(res.msg, {
    				    time: 2000,
                        icon: 1
                    }, function() {
	    				 var  forward = document.referrer;
	   				     if (forward == "" || forward == undefined || forward == null) {
	   				         forward = contextPath + "/std/index.jsp";
	   				         window.location.href = forward;
	   				     } else {
	   				    	 var examLink = "com.zimes.mes.exammanage.examPage.flow";
	   				    	 var trainLink = "com.zimes.mes.training.signInLink.flow";
	   				    	 if (forward.indexOf(examLink) >= 0 || forward.indexOf(trainLink) >= 0) {
	   				    		 location.href = "" + forward + "";
	   				    	 } else {
	   				    	     forward = contextPath + "/std/index.jsp";
		   				         window.location.href = forward;
	   				    	 }
	   				     }
    				});
    			} else {
    				layer.msg(res.msg, {
    				    time: 2000,
                        icon: 5
    				});
    			}
    		}
    	});
    	return false;
    });

    //通过短信验证修改密码
    form.on('submit(LAY-user-forget-submit)', function (data) {
        $.post(contextPath + "/com.zimax.design.sms.check.biz.ext", data.field, function (res) {
            if (res.code) {
                $.post(contextPath + "/com.zimax.design.user.changepwd.biz.ext", data.field, function (res) {
                    if (res.code) {
                        $(top.document.body).append(res.data);
                        layer.msg(res.msg, { time: 2000, icon: 1 },function () {
                            $('#captchmobile').val('');
                            $('#newpass').val('');
                            $('#chekcmobile').val('');
                            var captchaBtn=$('#getmsg');
                            clearInterval(IntervalObj);
                            captchaBtn.html("获取验证码");
                            captchaBtn.addClass("new-verify-btn-active", true);
                            captchaBtn.removeAttr("disabled");
                            $('#tabopenid').show();
                            $('#openpassid').hide();
                        });
                    } else {
                        layer.msg(res.msg, { time: 2000, icon: 5 });
                            }
                }, 'json');
            } else {
                layer.msg(res.msg, { time: 2000, icon: 5 });
            }
        }, 'json');
        return false;
    });
    form.on('select(aihao_type)', function(data) {
        var pid=$('select[name="type"]').val();
        if (pid == '3d') {
            $('#file_upload').css('display', 'block');
            $('#images_upload').css('display', 'block');
            $('#image_upload').css('display', 'block');
        } else {
            $('#images_upload').css('display', 'none');
            $('#file_upload').css('display', 'none');
            $('#image_upload').css('display', 'none');
        }
    });
    //验证
    form.verify({
    	pass:function(value){
	  		if(value.length>16||value.length<6){
	  			return "密码长度为6-16位";
	  		}
	  	},
	  	user:function(value){
	  		if(value.length>16||value.length<4){
	  			return "登录名至少4个";
	  		}
	  	},
	  	mobile: function(value){
	  		var reg =/^((0\d{2,3}(-)?\d{7,8})|(1[3675894]\d{9}))$/; 
	  		if(reg.test(value) == false){
	  			return "电话号码格式有误";
	  		}
	  		
	  	},
        checklength: [
            /^[\S]{6,15}$/
            ,'项目ID必须6-15位，且不能出现空格'
        ],
        checkid:[
            /^[0-9a-zA-Z_]{1,}$/
            ,'项目ID由英文和数字组成'
        ]
    });
    //修改密码
    form.on('submit(setmypass)', function (data) {
        $.post(contextPath + "/com.zimax.design.user.changepwdedit.biz.ext", data.field, function (res) {
            if (res.code) {
                $(top.document.body).append(res.data);
                layer.closeAll('page');
                layer.msg(res.msg, { time: 2000, icon: 1 });
                setInterval(function(){
                    top.location.reload();
                },2000)
            } else {
                layer.msg(res.msg, { time: 2000, icon: 5 });
            }
        }, 'json');
        return false;
    });
}
function sendSms(mobile, event) {
	var captchaBtn = $('#getmsg');

	if (captchaBtn.attr('disabled')) {
		return false;
	}
    $.get(contextPath + "/com.zimax.design.sms.send.biz.ext", { mobile: mobile,event:event }, function (res) {
        layer.msg(res.msg);
        if (res.code) {
            ticking(captchaBtn);
        }
    }, 'json');
    return false;
}
var IntervalObj;
// captcha
//倒计时
function ticking(captchaBtn){
    var time = 60;
    // var captchaBtn = $('#captcha');
    captchaBtn.attr("disabled", true);
     IntervalObj = setInterval(function () {
        time--;
        captchaBtn.removeClass("new-verify-btn-active", true);
        captchaBtn.html(time + "秒");
        if (time == 0) {
            clearInterval(IntervalObj);
            captchaBtn.html("重新获取");
            captchaBtn.addClass("new-verify-btn-active", true);
            captchaBtn.removeAttr("disabled");
        }
    }, 1000)
}
//时间戳转换
function formatDate(date) {
    var date = new Date(date);
    var YY = date.getFullYear() + '-';
    var MM = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
    var DD = (date.getDate() < 10 ? '0' + (date.getDate()) : date.getDate());
    var hh = (date.getHours() < 10 ? '0' + date.getHours() : date.getHours()) + ':';
    var mm = (date.getMinutes() < 10 ? '0' + date.getMinutes() : date.getMinutes()) + ':';
    var ss = (date.getSeconds() < 10 ? '0' + date.getSeconds() : date.getSeconds());
    return YY + MM + DD +" "+hh + mm + ss;
}
function tabCrl(){
    $('#gointoregister').click(function () {
        $('.colselogin').show();
        $('.colseregister').hide();
    });
    $('#gointologin').click(function () {
        $('.colselogin').hide();
        $('.colseregister').show();
    });
    // 首页-找回密码
    $('#forgotpassword').click(function () {
        $('#tabopenid').hide();
        $('#openpassid').show();
    });
    $('#gobackbtn').click(function () {
        $('#tabopenid').show();
        $('#openpassid').hide();
    });
}
$(document).ready(function() {
    var laydate = layui.laydate;
        //自定义格式
//        laydate.render({
//            elem: '#end_time',
//        format:'yyyy-MM-dd'
//    });
    submit();

    function openmenuleft() {
        if ($(window).width() < 768) {
            $('.layui-layout').addClass('layui-layout-sidebox');
        } else {
            $('.layui-layout').removeClass('layui-layout-sidebox');
        };
    }
    openmenuleft();
    $('.navBtn').click(function () {
        $('.menutwo').toggle();
        $('#popBg').toggle();
    });

    $('#popBg').click(function () {
        $('#popBg').hide();
        $('.menutwo').hide();
    });
    //基本信息
    $('.openinfo').click(function () {
    	var area = ['540px', '580px'];
    	if ($(this).data('id')) {
    		area = ['540px', '630px'];
    	}
    	layer.open({
    		area: area,
    		type: 2,
    		offset: '50px',
    		title: '基本资料',
    		content: contextPath + "/design.user.info.flow"
    	});
    	layui.form.render();
    	layui.form.render();
    });
    //修改密码
    $('.openpassword').click(function () {
    	var area= ['540px', '330px'];
    	if ($(this).data('id')) {
    		area= ['540px', '360px'];
    	}
    	layer.open({
    		area: area,
    		type: 2,
    		offset: '150px',
    		title: '修改密码',
    		content: contextPath + "/design/user/password.jsp"
    	});
    	layui.form.render();
    	layui.form.render();
    });
    //第三方登录提示
    $(document).on('click','.thirdlogin',function () {

        layer.msg('暂不可用');
        return;
    });
    //创建应用
    $('.addAppBtn').click(function () {
        var getappindex=$('#appindex').val();
     
        var area= ['540px', '650px'];

        if(getappindex==1){
             area= ['540px', '600px'];
        }
        if($(this).data('id')){
            area= ['540px', '680px']
        }
        layer.open({
            area: area,
            type: 1,
            offset:'100px',
            title:'创建应用设计',
            content: $('#addAppHtml').html()
        });
        if($(this).data('id'))
        {
            $('#tplid').val($(this).data('id'));
            $('#tplname').val($(this).data('name'));
            $('#tplhtml').show();
            // $('#file_upload').css('display', 'none');
            // $('#images_upload').css('display', 'none');
            // $('#tplhtml').show();
            // $('#addprojectbtn').hide();
        }
        layui.form.render('select');
        layui.form.render('checkbox');
        // layui.form.render('upload');
        var upload = layui.upload; //得到 upload 对象
        //3d 上传视频
        var uploadInst =upload.render({
            elem: '#LAY_videoUpload'
            , url:"/api/common/uploadUpyun.html"
            , method:'post'
            , size: 1024*100
            , accept: 'video' //允许上传的文件类型
            , before: function(obj){ //obj参数包含的信息，跟 choose回调完全一致，可参见上文。
                layer.load(); //上传loading
            }
            , done: function(res, index, upload){
                layer.closeAll('loading'); //关闭loading
                var demoText = $('#demoText').html('');
                if (res.code ==1) {
                    $('#video_input').val(res.data.url);
                    return layer.msg('上传成功');
                }else{
                    return layer.msg('上传失败');
                }
            }
            , error: function(index, upload){
                layer.closeAll('loading'); //关闭loading
                // upload();
                var demoText = $('#demoText');
                demoText.html('<span style="color: #ff5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload" >重试</a>');
                demoText.find('.demo-reload').on('click', function () {
                    uploadInst.upload();
                });
                layer.msg('上传失败, 请重试！');
            }
        });
        //3d 上传预览长图
        upload.render({
            elem: '#images_upload'
            , url:"/api/common/uploadUpyun.html"
            , method:'post'
            , accept: 'images' //允许上传的文件类型
            , before: function(obj){ //obj参数包含的信息，跟 choose回调完全一致，可参见上文。
                layer.load(); //上传loading
            }
            , done: function(res, index, upload){
                layer.closeAll('loading'); //关闭loading
                if (res.code ==1) {
                    $('#images_input').val(res.data.url);
                    return layer.msg('上传成功');
                }else{
                    return layer.msg('上传失败');
                }
            }
            , error: function(index, upload){
                layer.closeAll('loading'); //关闭loading
                layer.msg('上传失败');
            }
        });
        //3d 上传预览缩略图
         upload.render({
            elem: '#image_upload'
            , url:"/api/common/uploadUpyun.html"
            , method:'post'
            , accept: 'images' //允许上传的文件类型
            , before: function(obj){ //obj参数包含的信息，跟 choose回调完全一致，可参见上文。
                layer.load(); //上传loading
            }
            , done: function(res, index, upload){
                layer.closeAll('loading'); //关闭loading
                if (res.code ==1) {
                    $('#image_input').val(res.data.url);
                    return layer.msg('上传成功');
                }else{
                    return layer.msg('上传失败');
                }
            }
            , error: function(index, upload){
                 layer.closeAll('loading'); //关闭loading
                 layer.msg('上传失败');
            }
        });

    });
    $('.login').on('click',function () {
        layer.open({
            area: ['540px', '490px'],
            type: 1,
            offset:'150px',
            content: $('#userLoginRegister').html()
        });
        $('.colselogin').show();
        $('.colseregister').hide();
        tabCrl()
    });

    $('.register').on('click',function () {
        layer.open({
            area: ['540px', '490px'],
            type: 1,
            offset:'150px',
            content: $('#userLoginRegister').html()
        });
        tabCrl();
        $('#captcha').click(function () {
            var mobile = $(':input[name=mobile]').val();
            if (mobile) {
                sendSms(mobile)
            }
            else {
                layer.msg('请先填写手机号', { time: 2000, icon: 1 });
            }
        });
    });

    $(document).on('click','#addprojectbtn',function () {

        var area=['540px', '420px'];
       
         pages=$(this).attr('pages');

        if(pages!=undefined){
            area=['500px', '350px'];
        }

       

         thispages=layer.open({
            area: area,
            type: 1,
            offset:'200px',
            content: $('#addproject').html()
        });

    });
  
    //打开项目设置窗口 添加项目成员
    $('.setprojectbtn').click(function () {
        var id= $(this).attr('ids');
        var clientWidth=document.body.clientWidth;

        var clientHeight=document.body.clientHeight;

        var Xlen='780';
        var Ylen='700';

        if (clientHeight<740){
            Xlen='580';
            Ylen='500';
        }
        var offset='100px';
        if (clientWidth<500){
            Xlen=clientWidth;
        }


        layer.open({
            area: [Xlen+'px', Ylen+'px'],
            type:2,
            offset:offset,
            title:'项目设置',
            content: "/index/project/setproject.html?id="+id
        });

    });
    //打开项目编辑窗口
    $('.editprojectbtn').click(function () {
        var id= $(this).attr('ids');
        var clientWidth=document.body.clientWidth;

        var clientHeight=document.body.clientHeight;

        var Xlen='540';
        var Ylen='320';

        if (clientHeight<740){
            Xlen='540';
            Ylen='320';
        }
        var offset='100px';
        if (clientWidth<500){
            Xlen=clientWidth;
        }
        layer.open({
            area: [Xlen+'px', Ylen+'px'],
            type:2,
            offset:'200px',
            title:'编辑项目',
            content: contextPath + "/design.editproject.flow?id="+id
        });

    });
    //打开统一配置项目成员窗口 添加项目成员
    $('#setallprojectbtn').click(function () {

        var clientWidth=document.body.clientWidth;

        var clientHeight=document.body.clientHeight;


        
        var Xlen='780';
        var Ylen='700';
        
        if (clientHeight<740){
            Xlen='580';
            Ylen='500';
        }
        var offset='100px';
        if (clientWidth<500){
            Xlen=clientWidth;
        }


        layer.open({
            area: [Xlen+'px', Ylen+'px'],
            type:2,
            offset:offset,
            title:'统一配置项目成员',
            content: "/index/project/setallproject.html"
        });

    });
    //删除项目
    $('.delprojectbtn').click(function () {
        // if (confirm('确定删除该项目？')==false) return false;
        var id= $(this).attr('ids');
        var name=$(this).attr('proname');

        layer.confirm('确定删除该"'+name+'"项目？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            
        $.ajax({
            type: "POST",
            url: contextPath + "/com.zimax.design.project.del.biz.ext",
            data: {
            	id: id
            },
            dataType: "json",
            beforeSend:function(){
                 var myopen=layer.msg('正在删除中，请稍候……', { icon: 16, shade: 0.01,shadeClose:false,time:60000});
            },
            success: function(res){
                if (res.code) {
                    layer.msg(res.msg, { time: 2000, icon: 1 },function () {
                        layer.closeAll('page');
                        location.reload();
                    });
                } else {
                    layer.msg(res.msg, { time: 2000, icon: 5 });

                }
            },
            complete:function () {
            }
        });
    

        }, function(){

        });




    });
    //打开部署环境新增页
    $('#addunderlinebtn').click(function () {


        if(level==0){
            layer.msg('<span style="color:red">体验账号</span>，无法创建线下部署，请联系管理员进行升级!', { time: 2000, icon: 5 });

            return;
        }



        var clientWidth=document.body.clientWidth;

        var clientHeight=document.body.clientHeight;



        var Xlen='560';
        var Ylen='620';

        if (clientHeight<740){
            Xlen='540';
            Ylen='520';
        }
        var offset='100px';
        if (clientWidth<500){
            Xlen=clientWidth;
        }


        layer.open({
            area: [Xlen+'px', Ylen+'px'],
            type: 2,
            offset:offset,
            title:'新增部署环境',
            content: "/index/underline/addpage.html"
        });
        layui.form.render('select');
        layui.form.render('checkbox');
     

        var upload = layui.upload; //得到 upload 对象
        //创建一个上传组件
        upload.render({
            elem: '.test'

            ,done: function(res, index, upload){ //上传后的回调
                var item = this.item;
                console.log(item);
            }
            //,accept: 'file' //允许上传的文件类型
            //,size: 50 //最大允许上传的文件大小
            //,……
        });

        


    });
    //打开部署环境编辑页
    $('.editunderlinebtn').click(function () {
        var id= $(this).attr('ids');

        var clientWidth=document.body.clientWidth;

        var clientHeight=document.body.clientHeight;



      
        var Xlen='560';
        var Ylen='620';

        if (clientHeight<740){
            Xlen='540';
            Ylen='520';
        }
        var offset='100px';
        if (clientWidth<500){
            Xlen=clientWidth;
        }

        layer.open({
            area: [Xlen+'px', Ylen+'px'],
            type: 2,
            offset:offset,
            title:'编辑部署环境',
            content: "/index/underline/editpage.html?id="+id,
            // scrollbar:false,
            // move:false
        });


        var upload = layui.upload; //得到 upload 对象

        //创建一个上传组件
        upload.render({
            elem: '.test'

            ,done: function(res, index, upload){ //上传后的回调
                var item = this.item;
                console.log(item);
            }
            //,accept: 'file' //允许上传的文件类型
            //,size: 50 //最大允许上传的文件大小
            //,……
        })

        layui.form.render('select');
        layui.form.render('checkbox');

    });
    //点击下载
    $('.downme').click(function () {
        var dataUrl=$(this).attr('datadown');
        var userinfo=getCookie('userinfo');
        if (userinfo==''){
            layer.msg('请重新登录', { time: 2000, icon: 5 });
            setInterval(function(){
                window.location.href='/index/user/logout';
            },2000)
            return;
        }
        $.ajax({
            url :dataUrl,
            type : "GET",
            contentType: "application/json; charset=utf-8",
            headers: {
                'cookies':userinfo
            },
            dataType:'json',
            data :{},
            success : function(data){
               if (data.code==1){
                   layer.msg(data.msg, { time: 2000, icon: 5 });
               }
            },
            error : function(data){
                console.log(data);            }
        });

    });
    //打开应用编辑
    $('.open_app_edit').click(function () {
        var getappindex=$('#appindex').val();
        var appindex='';
        var Xlen='540';
        var Ylen='680';
        if(getappindex==1){
            appindex='&appindex='+getappindex;
            Ylen='600';
        }

        var id= $(this).attr('ids');
        var clientWidth=document.body.clientWidth;

        var clientHeight=document.body.clientHeight;
      

        if (clientHeight<740){
            Xlen='540';
            Ylen='500';
        }
        var offset='100px';
        if (clientWidth<500){
            Xlen=clientWidth;
        }
        layer.open({
            area: [Xlen+'px', Ylen+'px'],
            offset:offset,
            type:2,
            title:'应用编辑',
            content: contextPath + "/design.editappdesign.flow?id=" + id + appindex
        });
    });
    //打开应用删除
    $('.open_app_del').click(function () {
        var id= $(this).attr('ids');
        var name=$(this).attr('appname');
        layer.confirm('确定删除"'+name+'"应用？', {
            btn: ['确定','取消'] //按钮
        }, function(){
            $.post(contextPath + "/com.zimax.design.appdesign.del.biz.ext", {id:id}, function (res) {
                if (res.code) {
                    layer.closeAll('page');
                    layer.msg(res.msg, { time: 2000, icon: 1 });
                    setInterval(function(){
                        location.reload();
                    },1000)
                } else {
                    layer.msg(res.msg, { time: 2000, icon: 5 });

                }
            }, 'json');

        }, function(){

        });


    });



    // 图片上传
    layui.use('upload', function () {
        var $ = layui.jquery
            , upload = layui.upload;

        //普通图片上传
        var uploadInst = upload.render({
            elem: '#LAY_avatarUpload',
            url: contextPath + "/com.zimax.design.user.uploadAvatar.biz.ext"
            , before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $('#imgUpload').attr('src', result); //图片链接（base64）
                });
            }
            , done: function (res) {
                //如果上传失败
                if (res.code ==1) {
                    $('#LAY_avatarSrcs').val(res.data.url);
                    $('#LAY_avatarSrc').val(res.data.url);
                    return layer.msg('上传成功');
                }else{
                    return layer.msg('上传失败');
                }
                //上传成功
            }
            , error: function () {
                //演示失败状态，并实现重传
                var demoText = $('#demoText');
                demoText.html('<span style="color: #FF5722;">上传失败</span> <a class="layui-btn layui-btn-xs demo-reload">重试</a>');
                demoText.find('.demo-reload').on('click', function () {
                    uploadInst.upload();
                });
            }
        });
        
        //单文件上传
        var uploadFile = upload.render({
            elem: '#fileUploard'
            , url:"/api/common/uploadUpyun.html"
            ,method:'post'
            ,accept: 'file' //允许上传的文件类型
            ,before: function(obj){ //obj参数包含的信息，跟 choose回调完全一致，可参见上文。
                layer.load(); //上传loading
            }
            ,done: function(res, index, upload){
                // console.log(res);

                layer.closeAll('loading'); //关闭loading
                if (res.code ==1) {
                    $('#hardware_info').val(res.data.url);
                    $('#urlback').val(res.data.url);

                    return layer.msg('上传成功');
                }else{
                    return layer.msg('上传失败');
                }

            }
            ,error: function(index, upload){
                layer.closeAll('loading'); //关闭loading
                layer.msg('上传失败');
            }
        });
        //多图片上传
        upload.render({
            elem: '#upimgmore'
            , url: '/upload/'
            , multiple: true
            , before: function (obj) {
                //预读本地文件示例，不支持ie8
                obj.preview(function (index, file, result) {
                    $('#upimgmoresee').append('<img src="' + result + '" alt="' + file.name + '" class="layui-upload-img">')
                });
            }
            , done: function (res) {
                //上传完毕
            }
        });
        //多文件列表示例
        var demoListView = $('#demoList')
            , uploadListIns = upload.render({
                elem: '#testList'
                , url: '/upload/'
                , accept: 'file'
                , multiple: true
                , auto: false
                , bindAction: '#testListAction'
                , choose: function (obj) {
                    var files = this.files = obj.pushFile(); //将每次选择的文件追加到文件队列
                    //读取本地文件
                    obj.preview(function (index, file, result) {
                        var tr = $(['<tr id="upload-' + index + '">'
                            , '<td>' + file.name + '</td>'
                            , '<td>' + (file.size / 1014).toFixed(1) + 'kb</td>'
                            , '<td>等待上传</td>'
                            , '<td>'
                            , '<button class="layui-btn layui-btn-xs demo-reload layui-hide">重传</button>'
                            , '<button class="layui-btn layui-btn-xs layui-btn-danger demo-delete">删除</button>'
                            , '</td>'
                            , '</tr>'].join(''));

                        //单个重传
                        tr.find('.demo-reload').on('click', function () {
                            obj.upload(index, file);
                        });

                        //删除
                        tr.find('.demo-delete').on('click', function () {
                            delete files[index]; //删除对应的文件
                            tr.remove();
                            uploadListIns.config.elem.next()[0].value = ''; //清空 input file 值，以免删除后出现同名文件不可选
                        });

                        demoListView.append(tr);
                    });
                }
                , done: function (res, index, upload) {
                    if (res.code == 0) { //上传成功
                        var tr = demoListView.find('tr#upload-' + index)
                            , tds = tr.children();
                        tds.eq(2).html('<span style="color: #5FB878;">上传成功</span>');
                        tds.eq(3).html(''); //清空操作
                        return delete this.files[index]; //删除文件队列已经上传成功的文件
                    }
                    this.error(index, upload);
                }
                , error: function (index, upload) {
                    var tr = demoListView.find('tr#upload-' + index)
                        , tds = tr.children();
                    tds.eq(2).html('<span style="color: #FF5722;">上传失败</span>');
                    tds.eq(3).find('.demo-reload').removeClass('layui-hide'); //显示重传
                }
        });     
        // 自定颜色
        layui.use('colorpicker', function () {
            var $ = layui.$
                , colorpicker = layui.colorpicker;
            colorpicker.render({
                elem: '#colorsetid'
                , color: '#c71585'
                , predefine: true // 开启预定义颜色
            });
        });
    });  
    // btn模板删除
    $('.delbtn-id').click(function () {
        layer.open({
            area: ['320px', '160px'],
            content: '您是真的删除吗？'
            , btn: ['确定', '取消']
            , yes: function (index) {
                layer.close(index);
                layer.msg('删除成功', {
                    icon: 6
                    , time: 1000
                });
            }
        });        
    });
    //点击勾选记住密码
    $(document).on('click','#remember',function () {

        if ($('#remembercheck').is(':checked')){
            $(this).removeClass('layui-form-checked');
            $('#remembercheck').prop('checked',false);
        }else{
            $(this).addClass('layui-form-checked');
            $('#remembercheck').prop('checked',true);
        }

    });

    $(document).on('click','#getmsg',function () {
    	var mobile = $('#chekcmobile').val();
    	sendSms(mobile, 'changepwd');
    });
    // 选择
    $('.layui-form-checkbox').click(function () {
        if ($(this).hasClass('layui-form-checked')) {
            $(this).removeClass('layui-form-checked');
        } else {
            $(this).addClass('layui-form-checked');
        }
    });    
    // 独立页面-找回密码切换
    $('#forgotpassword').click(function () {
        $('#tabopenid').hide();
        $('#openpassid').show();
    });
    $('#gobackbtn').click(function () {
        $('#tabopenid').show();
        $('#openpassid').hide();
    });
    // 关闭
    $('.closenormal').click(function () {
        $(".closenormalBox").hide();
    });
    $('#imgPreview').click(function () {
        $(".upimgBox").show();
    });   
    // 签到
    $('#signid').click(function () {
        layer.msg('签到成功', {
            icon: 1,
            time: 1000
        });
        $('#signid').addClass('signokbtn'); 
        layer.open({
            area: ['600px', '260px'],
            type: 1,
            content: $('#signBoxid').html(),
            btn: '确定',
        });
    });
    // 左导航收缩展开
    $('#openclosebtn').click(function () {
        if ($('#LAY_app_flexible').hasClass('layui-icon-shrink-right')) {
            $('#LAY_app_flexible').removeClass('layui-icon-shrink-right');
            $('#LAY_app_flexible').addClass('layui-icon-spread-left');
        } else {
            $('#LAY_app_flexible').removeClass('layui-icon-spread-left');            
            $('#LAY_app_flexible').addClass('layui-icon-shrink-right');
        };       
        if ($('.layui-layout').hasClass('layui-layout-sidebox')) {
            $('.layui-layout').removeClass('layui-layout-sidebox');
        } else {           
            $('.layui-layout').addClass('layui-layout-sidebox');
        }; 
    });   
    //  屏幕宽度-左导航收缩展开
    $(window).resize(function () {
        openmenuleft();
    });
    layui.use(['carousel', 'form'], function () {
        var carousel = layui.carousel;
        //图片轮播
        carousel.render({
            elem: '#test1'
            , width: '100%'
            , height: '675px'
            , interval: 3000
        });
       
    });
    // 头部导航滚动
    var headerBg = $(".header");
    $(window).scroll(function () {
        var scrollTop = $(document).scrollTop();
        if (scrollTop >= 500) {
            if (!headerBg.is(".addbg"))
                headerBg.addClass('addbg');
        } else {
            if (headerBg.is(".addbg"))
                headerBg.removeClass('addbg');
        }
    });

    //搜索
    $('.so-btn').click(function () {
        var url=$(this).attr('url');
        var searchModel=$('#searchModel').val();
        location.href=url+searchModel;
        return false;
    });
    $(document).on('keydown', function(e){
        if(e.keyCode === 13)
        {
            var colselogin=$(".colselogin").css("display");
            var colseregister=$(".colseregister").css("display");

            var url=$('.so-btn').attr('url');
            if (url==undefined){
                return;
            }
            if (colselogin==undefined&&colseregister==undefined){
                var searchModel=$('#searchModel').val();
                location.href=url+searchModel;
            }
        }
    })
    $('#searchModel').keyup(function () {
        if ($(this).val()!=''){
            $('.sosodelbtn').show();
        }else{
            $('.sosodelbtn').hide();
        }
    });
    $('.sosodelbtn').click(function () {
        $('#searchModel').val('');
        var url=$(this).attr('url');
        location.href=url;
        $(this).hide();
    });

    layload();
});
function getCookie(name){
    var strcookie = document.cookie;//获取cookie字符串
    var arrcookie = strcookie.split("; ");//分割
//遍历匹配
    for ( var i = 0; i < arrcookie.length; i++) {
        var arr = arrcookie[i].split("=");
        if (arr[0] == name){
            return arr[1];
        }
    }
    return "";
}
/**
 * 设置懒加载相关dom操作
 */
function layload(){
    $('#ALLapp_in').scroll(function () {
        var topp = $(this).scrollTop();
        var height=$(".subBox").outerHeight();

        if (topp>0){
            $('.sosoBox').hide();
            $('.layui-inline').hide(300);
            $(this).css('height',height-30+'px');
        }else{
            $('.layui-inline').show(300);
            $('.sosoBox').show(300);

        }
    });
    $(window).resize(function(){
        $('#ALLapp_in').css('height',$(".subBox").outerHeight()-30+'px');
        // alert($(".subBox").outerHeight());
    });
    $('#ALLapp_in').css('height',$(".subBox").outerHeight()-150+'px');


}
//团队共享跳转
function editonline(aid) {
    $.post('/api/index/getediturl.html', {aid:aid,token:''}, function (res) {
        if (res.code==1){
            window.open(res.msg);
        }else{
            layer.msg(res.msg);
        }
    }, 'json');
}
function getQueryVariable(variable)
{
       var query = window.location.search.substring(1);
       var vars = query.split("&");
       for (var i=0;i<vars.length;i++) {
               var pair = vars[i].split("=");
               if(pair[0] == variable){return pair[1];}
       }
       return(false);
}