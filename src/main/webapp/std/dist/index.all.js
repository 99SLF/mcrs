layui.define(['laytpl', 'layer', 'element', 'util'], function(exports) {
  exports('setter', {
    container: 'LAY_app' //容器ID
    ,base: layui.cache.base //记录静态资源所在路径
    ,views: layui.cache.base + "std/dist/tpl/" //动态模板所在目录
    ,entry: 'index' //默认视图文件名
    ,engine: '.html' //视图文件后缀名
    ,pageTabs: true //是否开启页面选项卡功能。iframe版推荐开启
    
    ,name: '应用基础框架'
    ,tableName: 'layuiAdmin' //本地存储表名
    ,MOD_NAME: 'admin' //模块事件名
    
    ,debug: true //是否开启调试模式。如开启，接口异常时会抛出异常 URL 等信息

    //自定义请求字段
    ,request: {
      tokenName: false //自动携带 token 的字段名（如：access_token）。可设置 false 不携带。
    }
    
    //自定义响应字段
    ,response: {
      statusName: 'code' //数据状态的字段名称
      ,statusCode: {
        ok: 0 //数据状态一切正常的状态码
        ,logout: 1001 //登录状态失效的状态码
      }
      ,msgName: 'msg' //状态信息的字段名称
      ,dataName: 'data' //数据详情的字段名称
    }
    
    //扩展的第三方模块
    ,extend: [
      'echarts', //echarts 核心包
      'echartsTheme' //echarts 主题
    ]
    
    //主题配置
    ,theme: {
      //内置主题配色方案
      color: [{
        main: '#20222A' //主题色
        ,selected: '#009688' //选中色
        ,alias: 'default' //默认别名
      },{
        main: '#03152A'
        ,selected: '#3B91FF'
        ,alias: 'dark-blue' //藏蓝
      },{
        main: '#2E241B'
        ,selected: '#A48566'
        ,alias: 'coffee' //咖啡
      },{
        main: '#50314F'
        ,selected: '#7A4D7B'
        ,alias: 'purple-red' //紫红
      },{
        main: '#344058'
        ,logo: '#1E9FFF'
        ,selected: '#1E9FFF'
        ,alias: 'ocean' //海洋
      },{
        main: '#3A3D49'
        ,logo: '#2F9688'
        ,selected: '#5FB878'
        ,alias: 'green' //墨绿
      },{
        main: '#20222A'
        ,logo: '#F78400'
        ,selected: '#F78400'
        ,alias: 'red' //橙色
      },{
        main: '#28333E'
        ,logo: '#AA3130'
        ,selected: '#AA3130'
        ,alias: 'fashion-red' //时尚红
      },{
        main: '#24262F'
        ,logo: '#3A3D49'
        ,selected: '#009688'
        ,alias: 'classic-black' //经典黑
      },{
        logo: '#226A62'
        ,header: '#2F9688'
        ,alias: 'green-header' //墨绿头
      },{
        main: '#344058'
        ,logo: '#0085E8'
        ,selected: '#1E9FFF'
        ,header: '#1E9FFF'
        ,alias: 'ocean-header' //海洋头
      },{
        header: '#393D49'
        ,alias: 'classic-black-header' //经典黑头
      },{
        main: '#50314F'
        ,logo: '#50314F'
        ,selected: '#7A4D7B'
        ,header: '#50314F'
        ,alias: 'purple-red-header' //紫红头
      },{
        main: '#28333E'
        ,logo: '#28333E'
        ,selected: '#AA3130'
        ,header: '#AA3130'
        ,alias: 'fashion-red-header' //时尚红头
      },{
        main: '#28333E'
        ,logo: '#009688'
        ,selected: '#009688'
        ,header: '#009688'
        ,alias: 'green-header' //墨绿头
      }]
      
      //初始的颜色索引，对应上面的配色方案数组索引
      //如果本地已经有主题色记录，则以本地记录为优先，除非请求本地数据（localStorage）
      ,initColorIndex: 0
    }
  });
});

layui.define(["laytpl", "layer"], function(exports) {
	var t=layui.jquery,a=layui.laytpl,n=layui.layer,r=layui.setter,o=(layui.device(),layui.hint()),
	i=function(e){return new d(e)},
	s="LAY_app_body",d=function(e){this.id=e,this.container=t("#"+(e||s))};
	i.loading=function(e){e.append(this.elemLoad=t('<i class="layui-anim layui-anim-rotate layui-anim-loop layui-icon layui-icon-loading layadmin-loading"></i>'))},
	i.removeLoad=function(){this.elemLoad&&this.elemLoad.remove()},
	i.exit=function(e){layui.data(r.tableName,{key:r.request.tokenName,remove:!0}),e&&e()},
	i.req = function(e) {
		var a = e.success;
		var n = e.error;
		var o = r.request;
		var s = r.response;
		var d = function() {
			return r.debug ? "<br><cite>URL：</cite>" + e.url:"";
		};
		if (e.data = e.data || {}, e.headers = e.headers || {}, o.tokenName) {
			var l = "string" == typeof e.data ? JSON.parse(e.data) : e.data;
			e.data[o.tokenName] = o.tokenName in l ? e.data[o.tokenName] : layui.data(r.tableName)[o.tokenName] || "",
			e.headers[o.tokenName] = o.tokenName in e.headers ? e.headers[o.tokenName] : layui.data(r.tableName)[o.tokenName] || "";
		}
		delete e.success;
		delete e.error;
		return t.ajax(t.extend({
			type: "get",
			dataType: "json",
			success: function(t) {
				var n = s.statusCode;
				if (t[s.statusName] == n.ok)
					"function" == typeof e.done && e.done(t);
				else if (t[s.statusName] == n.logout)
					i.exit();
				else {
					var r = ["<cite>Error：</cite> " + (t[s.msgName] || "返回状态码异常"), d()].join("");
					i.error(r);
				}
				"function" == typeof a && a(t);
			},
			error: function(e, t) {
				var a = ["请求异常，请重试<br><cite>错误信息：</cite>" + t, d()].join("");
				i.error(a);
				"function" == typeof n && n(res);
			}
		}, e));
	},
	i.popup=function(e){var a=e.success,r=e.skin;return delete e.success,delete e.skin,n.open(t.extend({type:1,title:"提示",content:"",id:"LAY-system-view-popup",skin:"layui-layer-admin"+(r?" "+r:""),shadeClose:!0,closeBtn:!1,success:function(e,r){var o=t('<i class="layui-icon" close>&#x1006;</i>');e.append(o),o.on("click",function(){n.close(r)}),"function"==typeof a&&a.apply(this,arguments)}},e))},
	i.error=function(e,a){return i.popup(t.extend({content:e,maxWidth:300,offset:"t",anim:6,id:"LAY_adminError"},a))},
	d.prototype.render=function(e,a){var n=this;layui.router();return e=r.views+e+r.engine,t("#"+s).children(".layadmin-loading").remove(),i.loading(n.container),t.ajax({url:e,type:"get",dataType:"html",data:{v:layui.cache.version},success:function(e){e="<div>"+e+"</div>";var r=t(e).find("title"),o=r.text()||(e.match(/\<title\>([\s\S]*)\<\/title>/)||[])[1],s={title:o,body:e};r.remove(),n.params=a||{},n.then&&(n.then(s),delete n.then),n.parse(e),i.removeLoad(),n.done&&(n.done(s),delete n.done)},error:function(e){return i.removeLoad(),n.render.isError?i.error("请求视图文件异常，状态："+e.status):(404===e.status?n.render("template/tips/404"):n.render("template/tips/error"),void(n.render.isError=!0))}}),n},
	d.prototype.parse=function(e,n,r){var s=this,d="object"==typeof e,l=d?e:t(e),u=d?e:l.find("*[template]"),c=function(e){var n=a(e.dataElem.html()),o=t.extend({params:p.params},e.res);e.dataElem.after(n.render(o)),"function"==typeof r&&r();try{e.done&&new Function("d",e.done)(o)}catch(i){console.error(e.dataElem[0],"\n存在错误回调脚本\n\n",i)}},p=layui.router();l.find("title").remove(),s.container[n?"after":"html"](l.children()),p.params=s.params||{};for(var y=u.length;y>0;y--)!function(){var e=u.eq(y-1),t=e.attr("lay-done")||e.attr("lay-then"),n=a(e.attr("lay-url")||"").render(p),r=a(e.attr("lay-data")||"").render(p),s=a(e.attr("lay-headers")||"").render(p);try{r=new Function("return "+r+";")()}catch(d){o.error("lay-data: "+d.message),r={}}try{s=new Function("return "+s+";")()}catch(d){o.error("lay-headers: "+d.message),s=s||{}}n?i.req({type:e.attr("lay-type")||"get",url:n,data:r,dataType:"json",headers:s,success:function(a){c({dataElem:e,res:a,done:t})}}):c({dataElem:e,done:t})}();return s},
	d.prototype.autoRender = function(e, a) {
		var n = this;
		t(e || "body").find("*[template]").each(function(e, a) {
			var r = t(this);
			n.container = r;
			n.parse(r, "refresh");
		});
	},
	d.prototype.send=function(e,t){var n=a(e||this.container.html()).render(t||{});return this.container.html(n),this},
	d.prototype.refresh=function(e){var t=this,a=t.container.next(),n=a.attr("lay-templateid");return t.id!=n?t:(t.parse(t.container,"refresh",function(){t.container.siblings('[lay-templateid="'+t.id+'"]:last').remove(),"function"==typeof e&&e()}),t)},
	d.prototype.then=function(e){return this.then=e,this},
	d.prototype.done=function(e){return this.done=e,this},
	exports("view", i);
});

layui.define("view", function(exports) {
	var a = layui.jquery;
	var t = layui.laytpl;
	var i = layui.element;
	var n = layui.setter;
	var l = layui.view;
	var s = layui.device();
	var r = a(window);
	var o = a("body");
	var u = a("#" + n.container);
	var d = "layui-show";
	var c = "layui-hide";
	var y = "layui-this";
	var f = "layui-disabled";
	var m = "#LAY_app_body";
	var h = "LAY_app_flexible";
	var p = "layadmin-layout-tabs";
	var v = "layadmin-side-spread-sm";
	var b = "layadmin-tabsbody-item";
	var g = "layui-icon-shrink-right";
	var x = "layui-icon-spread-left";
	var C = "layadmin-side-shrink";
	var k = "LAY-system-side-menu";
	var Admin = {
		v:"1.4.0 std",
		req:l.req,
		exit:l.exit,
		escape:function(e){return String(e||"").replace(/&(?!#?[a-zA-Z0-9]+;)/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/'/g,"&#39;").replace(/"/g,"&quot;")},
		on:function(e,a){return layui.onevent.call(this,n.MOD_NAME,e,a)},
		sendAuthCode: function(e) {
			e = a.extend({seconds:60,elemPhone:"#LAY_phone",elemVercode:"#LAY_vercode"},e);
			var t,i=e.seconds,n=a(e.elem),l=function(a){i--,i<0?(n.removeClass(f).html("获取验证码"),i=e.seconds,clearInterval(t)):n.addClass(f).html(i+"秒后重获"),a||(t=setInterval(function(){l(!0)},1e3))};
			e.elemPhone=a(e.elemPhone),e.elemVercode=a(e.elemVercode),
			n.on("click", function() {
				var t=e.elemPhone,n=t.val();
				if(i===e.seconds&&!a(this).hasClass(f)){
					if(!/^1\d{10}$/.test(n))return t.focus(),layer.msg("请输入正确的手机号");
					if("object"==typeof e.ajax){
						var s=e.ajax.success;delete e.ajax.success
					}
					Admin.req(a.extend(!0,{url:"/auth/code",type:"get",data:{phone:n},success:function(a){layer.msg("验证码已发送至你的手机，请注意查收",{icon:1,shade:0}),e.elemVercode.focus(),l(),s&&s(a)}},e.ajax))
				}
			});
		},
		screen:function(){var e=r.width();return e>1200?3:e>992?2:e>768?1:0},
		sideFlexible:function(e){var t=u,i=a("#"+h),l=Admin.screen();"spread"===e?(i.removeClass(x).addClass(g),l<2?t.addClass(v):t.removeClass(v),t.removeClass(C)):(i.removeClass(g).addClass(x),l<2?t.removeClass(C):t.addClass(C),t.removeClass(v)),layui.event.call(this,n.MOD_NAME,"side({*})",{status:e})},
		popup:l.popup,
		popupRight:function(e){return Admin.popup.index=layer.open(a.extend({type:1,id:"LAY_adminPopupR",anim:-1,title:!1,closeBtn:!1,offset:"r",shade:.1,shadeClose:!0,skin:"layui-anim layui-anim-rl layui-layer-adminRight",area:"300px"},e))},
		theme:function(e){var i=(n.theme,layui.data(n.tableName)),l="LAY_layadmin_theme",s=document.createElement("style"),r=t([".layui-side-menu,",".layadmin-pagetabs .layui-tab-title li:after,",".layadmin-pagetabs .layui-tab-title li.layui-this:after,",".layui-layer-admin .layui-layer-title,",".layadmin-side-shrink .layui-side-menu .layui-nav>.layui-nav-item>.layui-nav-child","{background-color:{{d.color.main}} !important;}",".layui-nav-tree .layui-this,",".layui-nav-tree .layui-this>a,",".layui-nav-tree .layui-nav-child dd.layui-this,",".layui-nav-tree .layui-nav-child dd.layui-this a","{background-color:{{d.color.selected}} !important;}",".layui-layout-admin .layui-logo{background-color:{{d.color.logo || d.color.main}} !important;}","{{# if(d.color.header){ }}",".layui-layout-admin .layui-header{background-color:{{ d.color.header }};}",".layui-layout-admin .layui-header a,",".layui-layout-admin .layui-header a cite{color: #f8f8f8;}",".layui-layout-admin .layui-header a:hover{color: #fff;}",".layui-layout-admin .layui-header .layui-nav .layui-nav-more{border-top-color: #fbfbfb;}",".layui-layout-admin .layui-header .layui-nav .layui-nav-mored{border-color: transparent; border-bottom-color: #fbfbfb;}",".layui-layout-admin .layui-header .layui-nav .layui-this:after, .layui-layout-admin .layui-header .layui-nav-bar{background-color: #fff; background-color: rgba(255,255,255,.5);}",".layadmin-pagetabs .layui-tab-title li:after{display: none;}","{{# } }}"].join("")).render(e=a.extend({},i.theme,e)),u=document.getElementById(l);"styleSheet"in s?(s.setAttribute("type","text/css"),s.styleSheet.cssText=r):s.innerHTML=r,s.id=l,u&&o[0].removeChild(u),o[0].appendChild(s),o.attr("layadmin-themealias",e.color.alias),i.theme=i.theme||{},layui.each(e,function(e,a){i.theme[e]=a}),layui.data(n.tableName,{key:"theme",value:i.theme})},
		initTheme:function(e){var a=n.theme;e=e||0,a.color[e]&&(a.color[e].index=e,Admin.theme({color:a.color[e]}))},
		tabsPage:{},
		tabsBody:function(e){return a(m).find("."+b).eq(e||0)},
		tabsBodyChange:function(e,a){a=a||{},Admin.tabsBody(e).addClass(d).siblings().removeClass(d),F.rollPage("auto",e),layui.event.call(this,n.MOD_NAME,"tabsPage({*})",{url:a.url,text:a.text})},
		resize:function(e){var a=layui.router(),t=a.path.join("-");Admin.resizeFn[t]&&(r.off("resize",Admin.resizeFn[t]),delete Admin.resizeFn[t]),"off"!==e&&(e(),Admin.resizeFn[t]=e,r.on("resize",Admin.resizeFn[t]))},
		resizeFn:{},
		runResize:function(){var e=layui.router(),a=e.path.join("-");Admin.resizeFn[a]&&Admin.resizeFn[a]()},
		delResize:function(){this.resize("off")},
		closeThisTabs:function(){Admin.tabsPage.index&&a(_).eq(Admin.tabsPage.index).find(".layui-tab-close").trigger("click")},
		fullScreen:function(){var e=document.documentElement,a=e.requestFullScreen||e.webkitRequestFullScreen||e.mozRequestFullScreen||e.msRequestFullscreen;"undefined"!=typeof a&&a&&a.call(e)},
		exitScreen:function(){document.documentElement;document.exitFullscreen?document.exitFullscreen():document.mozCancelFullScreen?document.mozCancelFullScreen():document.webkitCancelFullScreen?document.webkitCancelFullScreen():document.msExitFullscreen&&document.msExitFullscreen()}
	};
	var dict = {
		map: {},
		contains: function(d, e) {
			return ("," + d + ",").indexOf("," + e + ",") != -1;
		},
		removeEmpty: function(e) {
			for (var d = 0, c = e.length; d < c; d++) {
				if (e[d] && e[d].__NullItem) {
					e.splice(d, 1);
				}
			}
		},
		getDictName: function(dictList, dictId) {
			var dictNames = [];
			for (var i = 0, c = dictList.length; i < c; i++) {
				var dictEntry = dictList[i];
				if (dict.contains(dictId, dictEntry.dictId)) {
					dictNames.push(dictEntry.dictName);
				}
			}
			return dictNames.join(",");
		},
		getDictText: function(dictTypeId, dictId) {
			var d = dict.map[dictTypeId];
			if (d) {
				return dict.getDictName(d, dictId);
			}
			var dictName = "";
			Admin.req({
				url: n.base + "dictLoader/find/" + dictTypeId,
				async: false,
				success: function(res) {
					if (res[n.response.dataName]) {
						var dictList = res[n.response.dataName];
						dict.map[c] = dictList;
						dictName = dict.getDictName(dictList, dictId);
					}
				}
			});
			return dictName;
		},
		loadDict: function(e) {
			if (!e) {
				return;
			}
			if (!e.dictTypeId) {
				return;
			}
			var dictTypeId = e.dictTypeId;
			var d = dict.map[dictTypeId];
			if (!d) {
				Admin.req({
					url: n.base + "dictLoader/find/" + dictTypeId,
					async: false,
					success: function(res) {
						if (res[n.response.dataName]) {
							var e = res[n.response.dataName];
							dict.map[dictTypeId] = e;
						}
					}
				});
				d = dict.map[dictTypeId];
			}
			dict.removeEmpty(d);
			"function" == typeof e.done && e.done(d);
		},
		renderDictSelect: function(options) {
			a(options.elem).empty();
			a(options.elem).append(new Option("", ""));
			this.loadDict(options);
			var datas = dict.map[options.dictTypeId];
			for (var i = 0; i < datas.length; i++) {
				a(options.elem).append(new Option(datas[i].dictName, datas[i].dictId));
			}
		}
	};
	Admin.getDictText = dict.getDictText;
	Admin.loadDict = dict.loadDict;
	Admin.renderDictSelect = dict.renderDictSelect;
	var F = Admin.events = {
		flexible: function(e) {
			var a=e.find("#"+h),t=a.hasClass(x);Admin.sideFlexible(t?"spread":null)
		},
		refresh: function() {
			var e=".layadmin-iframe",t=a("."+b).length;Admin.tabsPage.index>=t&&(Admin.tabsPage.index=t-1);var i=Admin.tabsBody(Admin.tabsPage.index).find(e);i[0].contentWindow.location.reload(!0)
		},
		serach: function(e) {
			e.off("keypress").on("keypress",function(a){if(this.value.replace(/\s/g,"")&&13===a.keyCode){var t=e.attr("lay-action"),i=e.attr("lay-text")||"搜索";t+=this.value,i=i+' <span style="color: #FF5722;">'+Admin.escape(this.value)+"</span>",layui.index.openTabsPage(t,i),F.serach.keys||(F.serach.keys={}),F.serach.keys[Admin.tabsPage.index]=this.value,this.value===F.serach.keys[Admin.tabsPage.index]&&F.refresh(e),this.value=""}})
		},
		message: function(e) {
			e.find(".layui-badge-dot").remove()
		},
		theme: function() {
			Admin.popupRight({id:"LAY_adminPopupTheme",success:function(){l(this.id).render("system/theme")}})
		},
		note: function(e) {
			var a=Admin.screen()<2,t=layui.data(n.tableName).note;F.note.index=Admin.popup({title:"便签",shade:0,offset:["41px",a?null:e.offset().left-250+"px"],anim:-1,id:"LAY_adminNote",skin:"layadmin-note layui-anim layui-anim-upbit",content:'<textarea placeholder="内容"></textarea>',resize:!1,success:function(e,a){var i=e.find("textarea"),l=void 0===t?"便签中的内容会存储在本地，这样即便你关掉了浏览器，在下次打开时，依然会读取到上一次的记录。是个非常小巧实用的本地备忘录":t;i.val(l).focus().on("keyup",function(){layui.data(n.tableName,{key:"note",value:this.value})})}})
		},
		fullscreen: function(e) {
			var a="layui-icon-screen-full",t="layui-icon-screen-restore",i=e.children("i");i.hasClass(a)?(Admin.fullScreen(),i.addClass(t).removeClass(a)):(Admin.exitScreen(),i.addClass(a).removeClass(t))
		},
		about: function() {
			Admin.popupRight({id:"LAY_adminPopupAbout",success:function(){l(this.id).render("system/about")}})
		},
		more: function() {
			Admin.popupRight({id:"LAY_adminPopupMore",success:function(){l(this.id).render("system/more")}})
		},
		back: function() {
			history.back()
		},
		setTheme: function(e) {
			var a=e.data("index");e.siblings(".layui-this").data("index");e.hasClass(y)||(e.addClass(y).siblings(".layui-this").removeClass(y),Admin.initTheme(a))
		},
		rollPage: function(e, t) {
			var i=a("#LAY_app_tabsheader"),n=i.children("li"),l=(i.prop("scrollWidth"),i.outerWidth()),s=parseFloat(i.css("left"));if("left"===e){if(!s&&s<=0)return;var r=-s-l;n.each(function(e,t){var n=a(t),l=n.position().left;if(l>=r)return i.css("left",-l),!1})}else"auto"===e?!function(){var e,r=n.eq(t);if(r[0]){if(e=r.position().left,e<-s)return i.css("left",-e);if(e+r.outerWidth()>=l-s){var o=e+r.outerWidth()-(l-s);n.each(function(e,t){var n=a(t),l=n.position().left;if(l+s>0&&l-s>o)return i.css("left",-l),!1})}}}():n.each(function(e,t){var n=a(t),r=n.position().left;if(r+n.outerWidth()>=l-s)return i.css("left",-r),!1})
		},
		leftPage: function() {
			F.rollPage("left")
		},
		rightPage: function() {
			F.rollPage()
		},
		closeThisTabs: function() {
			var e=parent===self?Admin:parent.layui.admin;e.closeThisTabs()
		},
		closeOtherTabs: function(e) {
			var t="LAY-system-pagetabs-remove";"all"===e?(a(_+":gt(0)").remove(),a(m).find("."+b+":gt(0)").remove(),a(_).eq(0).trigger("click")):(a(_).each(function(e,i){e&&e!=Admin.tabsPage.index&&(a(i).addClass(t),Admin.tabsBody(e).addClass(t))}),a("."+t).remove())
		},
		closeAllTabs: function() {
			F.closeOtherTabs("all")
		},
		shade: function() {
			Admin.sideFlexible()
		},
		update: function() {
			a.ajax({type:"get",dataType:"jsonp",data:{name:"layuiAdmin",version:Admin.v},url:"https://fly.layui.com/api/product_update/",success:function(e){0===e.status?e.version===Admin.v.replace(/\s|pro|std/g,"")?layer.alert("当前版本已经是最新版本"):layer.alert("检查到更新，是否前往下载？",{btn:["更新","暂不"]},function(e){layer.close(e),layer.open({type:2,content:"https://fly.layui.com/user/product/",area:["100%","100%"],title:"检查更新"})}):1==e.status?layer.alert(e.msg,{btn:["登入","暂不"]},function(e){layer.close(e),layer.open({type:2,content:"https://fly.layui.com/user/login/",area:["100%","100%"],title:"检查更新"})}):layer.msg(e.msg||e.code,{shift:6})},error:function(e){layer.msg("请求异常，请重试",{shift:6})}})
		},
		im: function() {
			Admin.popup({id:"LAY-popup-layim-demo",shade:0,area:["800px","300px"],title:"面板外的操作示例",offset:"lb",success:function(){layui.view(this.id).render("layim/demo").then(function(){layui.use("im")})}})
		}
	};
	!function() {
		var e=layui.data(n.tableName);e.theme?Admin.theme(e.theme):n.theme&&Admin.initTheme(n.theme.initColorIndex),"pageTabs"in layui.setter||(layui.setter.pageTabs=!0),n.pageTabs||(a("#LAY_app_tabs").addClass(c),u.addClass("layadmin-tabspage-none")),s.ie&&s.ie<10&&l.error("IE"+s.ie+"下访问可能不佳，推荐使用：Chrome / Firefox / Edge 等高级浏览器",{offset:"auto",id:"LAY_errorIE"})
	}();
	i.on("tab("+p+")",function(e){Admin.tabsPage.index=e.index});
	Admin.on("tabsPage(setMenustatus)", function(e) {
		var t = e.url;
		var i = function(e) {
			return{list:e.children(".layui-nav-child"),a:e.children("*[lay-href]")}
		};
		var n = a("#" + k);
		var l = "layui-nav-itemed";
		var s = function(e) {
			e.each(function(e, n) {
				var s = a(n);
				var r = i(s);
				var o = r.list.children("dd");
				var u = t === r.a.attr("lay-href");
				o.each(function(e, n) {
					var s=a(n),r=i(s),o=r.list.children("dd"),u=t===r.a.attr("lay-href");if(o.each(function(e,n){var s=a(n),r=i(s),o=t===r.a.attr("lay-href");if(o){var u=r.list[0]?l:y;return s.addClass(u).siblings().removeClass(u),!1}}),u){var d=r.list[0]?l:y;return s.addClass(d).siblings().removeClass(d),!1}
				});
				if (u) {
					var d = r.list[0] ? l : y;
					s.addClass(d).siblings().removeClass(d);
					return !1;
				}
			});
		};
		n.find("." + y).removeClass(y);
		Admin.screen() < 2 && Admin.sideFlexible();
		s(n.children("li"));
	});
	i.on("nav(layadmin-system-side-menu)", function(e) {
		e.siblings(".layui-nav-child")[0] && u.hasClass(C) && (Admin.sideFlexible("spread"), layer.close(e.data("index")));
		Admin.tabsPage.type = "nav";
	});
	i.on("nav(layadmin-pagetabs-nav)", function(e) {
		var a = e.parent();
		a.removeClass(y);
		a.parent().removeClass(d);
	});
	var A = function(e) {
		var a = (e.attr("lay-id"), e.attr("lay-attr"));
		var t = e.index();
		Admin.tabsBodyChange(t, {
			url: a
		});
	};
	var _ = "#LAY_app_tabsheader>li";
	o.on("click", _, function() {
		var e = a(this);
		var t = e.index();
		Admin.tabsPage.type = "tab";
		Admin.tabsPage.index = t;
		A(e);
	});
	i.on("tabDelete(" + p + ")", function(e) {
		var t = a(_ + ".layui-this");
		e.index && Admin.tabsBody(e.index).remove();
		A(t);
		Admin.delResize();
	});
	o.on("click", "*[lay-href]", function() {
		var e = a(this);
		var url = e.attr("lay-href");
		var text = e.attr("lay-text");
		layui.router();
		Admin.tabsPage.elem = e;
		var n = parent === self ? layui : top.layui;
		n.index.openTabsPage(url, text || e.text());
		url === Admin.tabsBody(Admin.tabsPage.index).find("iframe").attr("src") && Admin.events.refresh();
	});
	o.on("click", "*[layadmin-event]", function() {
		var e = a(this);
		var t = e.attr("layadmin-event");
		F[t] && F[t].call(this, e);
	});
	o.on("mouseenter", "*[lay-tips]", function() {
		var e = a(this);
		if (!e.parent().hasClass("layui-nav-item") || u.hasClass(C)) {
			var t = e.attr("lay-tips");
			var i = e.attr("lay-offset");
			var n = e.attr("lay-direction");
			var l = layer.tips(t, this, {
				tips: n || 1,
				time: -1,
				success: function(e, a) {
					i && e.css("margin-left", i + "px");
				}
			});
			e.data("index", l);
		}
	}).on("mouseleave", "*[lay-tips]", function() {
		layer.close(a(this).data("index"));
	});
	var z = layui.data.resizeSystem = function() {
		layer.closeAll("tips");
		z.lock || setTimeout(function() {
			Admin.sideFlexible(Admin.screen() < 2 ? "" : "spread");
			delete z.lock;
		}, 100);
		z.lock = !0;
	};
	r.on("resize", layui.data.resizeSystem);
	exports("admin", Admin);
});

layui.define(["setter", "admin"], function(exports) {
	var setter = layui.setter;
	var element = layui.element;
	var admin = layui.admin;
	var tabsPage = admin.tabsPage;
	var view = layui.view;
	var s = "#LAY_app_body";
	var o = "layadmin-layout-tabs";
	var $ = layui.$;
	var openTabsPage = function(url, text) {
		var l = !1;
		var u = $("#LAY_app_tabsheader>li");
		var b = url.replace(/(^http(s*):)|(\?[\s\S]*$)/g, "");
		u.each(function(e) {
			var i = $(this);
			var n = i.attr("lay-id");
			n === url && (l = !0, tabsPage.index = e);
		});
		text = text || "新标签页";
		var y = function() {
			element.tabChange(o, url);
			admin.tabsBodyChange(tabsPage.index, {
				url: url,
				text: text
			});
		};
		if (setter.pageTabs)
			l || (setTimeout(function() {
				$(s).append(['<div class="layadmin-tabsbody-item layui-show">', '<iframe src="' + url +
				        '" frameborder="0" class="layadmin-iframe"></iframe>', "</div>"].join(""));
				y();
			}, 10),
			tabsPage.index = u.length,
			element.tabAdd(o, {
				title: "<span>" + text + "</span>",
				id: url,
				attr: b
			}));
		else {
			var m = admin.tabsBody(admin.tabsPage.index).find(".layadmin-iframe");
			m[0].contentWindow.location.href = url;
		}
		y();
	};
	$(window);
	admin.screen() < 2 && admin.sideFlexible();
	layui.config({
		base: setter.base + "std/dist/modules/"
	});
	layui.each(setter.extend, function(a, i) {
		var n = {};
		n[i] = "{/}" + setter.base + "lib/extend/" + i;
		layui.extend(n);
	});
	view().autoRender();
	layui.use("common");
	var tables = {};
	exports("index", {
		openTabsPage: openTabsPage,
		data: function(table, settings) {
			if (arguments.length == 1) {
				return tables[table];
			} else if (arguments.length == 2) {
				if (settings == null) {
					delete tables[table];
					return tables[table];
				}
				tables[table] = tables[table] || {};
				tables[table][settings.key] = settings.value;
				return tables[table];
			}
		}
	});
});