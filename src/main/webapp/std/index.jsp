<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" session="false" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
<link rel="shortcut icon" href="<%=request.getContextPath() %>/std/dist/images/favicon.ico?v=3" />
<title>应用基础框架</title>
<link rel="stylesheet" href="<%=request.getContextPath()%>/common/layui/css/layui.css">
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/admin.css" media="all">
<link rel="stylesheet" href="<%=request.getContextPath()%>/std/dist/style/custom.css?v2">
</head>
<body class="layui-layout-body">
<div id="LAY_app">
<div class="layui-layout layui-layout-admin">
<!-- 头部区域 -->
<div class="layui-header">
	<ul class="layui-nav layui-layout-left">
		<li class="layui-nav-item layadmin-flexible" lay-unselect>
			<a href="javascript:;" layadmin-event="flexible" title="侧边伸缩">
				<i class="layui-icon layui-icon-shrink-right" id="LAY_app_flexible"></i>
			</a>
		</li>
<%--		<li class="layui-nav-item layui-hide-xs" lay-unselect>
			<a href="http://www.layui.com/admin/" target="_blank" title="前台">
				<i class="layui-icon layui-icon-website"></i>
			</a>
		</li>--%>
		<li class="layui-nav-item" lay-unselect>
			<a href="javascript:;" layadmin-event="refresh" title="刷新">
				<i class="layui-icon layui-icon-refresh-3"></i>
			</a>
		</li>
<%--		<li class="layui-nav-item layui-hide-xs" lay-unselect>
			<input type="text" placeholder="搜索..." autocomplete="off" class="layui-input layui-input-search" layadmin-event="serach" lay-action="template/search.html?keywords="> 
		</li>--%>
	</ul>
	<ul class="layui-nav layui-layout-right" lay-filter="layadmin-layout-right" >
		<li class="layui-nav-item" lay-unselect id="message" >
			<a lay-href="/coframe/message/message_manage.jsp" layadmin-event="message" lay-text="消息中心">
				<i class="layui-icon layui-icon-notice"></i>
				<!-- 如果有新消息，则显示小圆点 -->
				<span id="layui-badge-dot" ></span>
			</a>
		</li>
		<li class="layui-nav-item layui-hide-xs" lay-unselect>
			<a href="javascript:;" layadmin-event="theme">
				<i class="layui-icon layui-icon-theme"></i>
			</a>
		</li>
		<li class="layui-nav-item layui-hide-xs" lay-unselect>
			<a href="javascript:;" layadmin-event="note">
				<i class="layui-icon layui-icon-note"></i>
			</a>
		</li>
		<li class="layui-nav-item layui-hide-xs" lay-unselect>
			<a href="javascript:;" layadmin-event="fullscreen">
				<i class="layui-icon layui-icon-screen-full"></i>
			</a>
		</li>
		<li class="layui-nav-item layui-hide-xs" lay-unselect  id="replyFill">
			<!-- 意见中心 -->
			<a lay-href="<%=request.getContextPath()%>/proposal/proposalFrom.jsp"  lay-text="意见中心" >
				<i class="layui-icon layui-icon-reply-fill" ></i>
			</a>
		</li>
		<li class="layui-nav-item" lay-unselect>
			<script type="text/html" template lay-url="./com.zimax.components.coframe.auth.LoginManager.getSession.biz.ext" 
						lay-done="layui.element.render('nav', 'layadmin-layout-right');">
				<a href="javascript:;">
					<cite>{{ d.data.username }}</cite>
				</a>
				<dl class="layui-nav-child">
					<%--<dd><a lay-href="set/user/info.html">基本资料</a></dd>--%>
					<dd><a lay-href="<%=request.getContextPath()%>/coframe/rights/user/update_password.jsp">修改密码</a></dd>
					<hr>
					<dd layadmin-event="logout" style="text-align: center;"><a>退出</a></dd>
				</dl>
			</script>
		</li>
		<li class="layui-nav-item layui-hide-xs" lay-unselect>
			<a href="javascript:;" layadmin-event="about">
				<i class="layui-icon layui-icon-more-vertical"></i>
			</a>
		</li>
		<li class="layui-nav-item layui-show-xs-inline-block layui-hide-sm" lay-unselect>
			<a href="javascript:;" layadmin-event="more">
				<i class="layui-icon layui-icon-more-vertical"></i>
			</a>
		</li>
	</ul>
</div>
<!-- 侧边菜单 -->
<div class="layui-side layui-side-menu">
	<div class="layui-side-scroll">
		<script type="text/html" template lay-url="./com.zimax.components.coframe.auth.LoginManager.getMenuData.biz.ext?appCode=coframe" 
				lay-done="layui.element.render('nav', 'layadmin-system-side-menu');" id="TPL_layout">
<div class="layui-logo" lay-href="<%=request.getContextPath()%>/std/dist/views/index.jsp">
	<span>{{ layui.setter.name || 'layuiAdmin' }}</span>
</div>

<ul class="layui-nav layui-nav-tree" lay-shrink="all" id="LAY-system-side-menu" lay-filter="layadmin-system-side-menu">
{{# 
	var dataName = layui.setter.response.dataName;
	var datas = d[dataName] || [];
	layui.each(datas, function(index, item) {
		var hasChildren = typeof item.childrenMenuTreeNodeList === 'object' && item.childrenMenuTreeNodeList !== null && item.childrenMenuTreeNodeList.length > 0;
		var classSelected = function() {
			var match = item.spread;
			if (match) {
				return hasChildren ? 'layui-nav-itemed' : 'layui-this';
			}
			return '';
		};
		var linkAction = item.linkAction;
		if (linkAction && typeof linkAction === 'string') {
			var index = linkAction.indexOf("/");
			linkAction = index == 0 ? linkAction.substr(1) : linkAction;
		}
		var url = (linkAction && typeof linkAction === 'string') ? layui.setter.base + linkAction : item.menuCode;
}}
	<li data-name="{{ item.menuCode || '' }}" data-jump="{{ item.linkAction || '' }}" class="layui-nav-item {{ classSelected() }}">
		<a href="javascript:;" {{ hasChildren ? '' : 'lay-href="'+ url +'"' }} lay-tips="{{ item.menuName }}" lay-direction="2">
			<i class="layui-icon {{ item.imagePath }}"></i>
			<cite>{{ item.menuName }}</cite>
		</a>
	{{# if (hasChildren) { }}
		<dl class="layui-nav-child">
		{{#
			layui.each(item.childrenMenuTreeNodeList, function(index2, item2) {
				var hasChildren2 = typeof item2.childrenMenuTreeNodeList === 'object' && item2.childrenMenuTreeNodeList !== null && item2.childrenMenuTreeNodeList.length > 0;
				var classSelected2 = function() {
					var match = item2.spread;
					if (match) {
						return hasChildren2 ? 'layui-nav-itemed' : 'layui-this';
					}
					return '';
				};
				var linkAction = item2.linkAction;
				if (linkAction && typeof linkAction === 'string') {
					var index = linkAction.indexOf("/");
					linkAction = index == 0 ? linkAction.substr(1) : linkAction;
				}
				var url2 = (linkAction && typeof linkAction === 'string') ? layui.setter.base + linkAction : [item.menuCode, item2.menuCode, ''].join('/');
		}}
			<dd data-name="{{ item2.menuCode || '' }}"  data-jump="{{ item2.linkAction || '' }}"
					{{ classSelected2() ? ('class="'+ classSelected2() +'"') : '' }}>
			{{# if(item2.openMode == "0"){
			}}
				<a href="javascript:;" {{ hasChildren2 ? '' : "onclick=openNewModel('" + url2 + "')" }}>{{ item2.menuName }}</a>
			 {{# } else { }}
				<a href="javascript:;" {{ hasChildren2 ? '' : 'lay-href="'+ url2 +'"' }}>{{ item2.menuName }}</a>
			{{# } }}
			{{# if (hasChildren2) { }}
				<dl class="layui-nav-child">
				{{#
					layui.each(item2.childrenMenuTreeNodeList, function(index3, item3) {
						var match = false;
						var linkAction = item3.linkAction;
						if (linkAction && typeof linkAction === 'string') {
							var index = linkAction.indexOf("/");
							linkAction = index == 0 ? linkAction.substr(1) : linkAction;
						}
						var url3 = (linkAction && linkAction === 'string') ? layui.setter.base + linkAction : [item.menuCode, item2.menuCode, item3.menuCode].join('/');
				}}
					<dd data-name="{{ item3.menuCode || '' }}"  data-jump="{{ item3.linkAction || '' }}" 
							{{ match ? 'class="layui-this"' : '' }}>
						<a href="javascript:;" lay-href="{{ url3 }}" {{ item3.iframe ? 'lay-iframe="true"' : '' }}>{{ item3.menuName }}</a>
					</dd>
				{{# }); }}
				</dl>
			{{# } }}
			</dd>
		{{# }); }}
		</dl>
	{{# } }}
	</li>
{{# }); }}
</ul>
		</script>
	</div>
</div>
<!-- 页面标签 -->
<div class="layadmin-pagetabs" id="LAY_app_tabs">
	<div class="layui-icon layadmin-tabs-control layui-icon-prev" layadmin-event="leftPage"></div>
	<div class="layui-icon layadmin-tabs-control layui-icon-next" layadmin-event="rightPage"></div>
	<div class="layui-icon layadmin-tabs-control layui-icon-down">
		<ul class="layui-nav layadmin-tabs-select" lay-filter="layadmin-pagetabs-nav">
			<li class="layui-nav-item" lay-unselect>
				<a href="javascript:;"></a>
				<dl class="layui-nav-child layui-anim-fadein">
					<dd layadmin-event="closeThisTabs"><a href="javascript:;">关闭当前标签页</a></dd>
					<dd layadmin-event="closeOtherTabs"><a href="javascript:;">关闭其它标签页</a></dd>
					<dd layadmin-event="closeAllTabs"><a href="javascript:;">关闭全部标签页</a></dd>
				</dl>
			</li>
		</ul>
	</div>
	<div class="layui-tab" lay-unauto lay-allowClose="true" lay-filter="layadmin-layout-tabs">
		<ul class="layui-tab-title" id="LAY_app_tabsheader">
			<li lay-id="<%=request.getContextPath()%>/std/dist/views/index.jsp" lay-attr="<%=request.getContextPath()%>/std/dist/views/index.jsp" class="layui-this">
				<i class="layui-icon layui-icon-home"></i>
			</li>
		</ul>
	</div>
</div>
<!-- 主体内容 -->
<div class="layui-body" id="LAY_app_body">
	<div class="layadmin-tabsbody-item layui-show">
		<iframe src="<%=request.getContextPath()%>/std/dist/views/index.jsp" frameborder="0" class="layadmin-iframe"></iframe>
	</div>
</div>
<!-- 辅助元素，一般用于移动设备下遮罩 -->
<div class="layadmin-body-shade" layadmin-event="shade"></div>
</div>
</div>
<script src="<%=request.getContextPath()%>/common/layui/layui.all.js"></script>
<script>
	layui.config({
		base: "<%=request.getContextPath()%>/"
	});
</script>
<%-- <script src="<%=request.getContextPath()%>/std/dist/index.all.js?v1"></script> --%>
<script src="<%=request.getContextPath()%>/std/dist/config.js?v1"></script>
<script src="<%=request.getContextPath()%>/std/dist/lib/view.js?v1"></script>
<script src="<%=request.getContextPath()%>/std/dist/lib/admin.js?v1"></script>
<script src="<%=request.getContextPath()%>/std/dist/index.js?v1"></script>
<script type="text/javascript">
	var $ = layui.jquery;
	var element = layui.element;
	
	$(".layui-icon-reply-fill").hover(
		function() {
			layer.tips('意见反馈', this, {
            	tips: [3, "#4794ec"]
        });
    });
    $(".layui-icon-reply-fill").mouseout(
    	function () {
        	layer.tips('');
    });
    
    //打开新窗口
    function openNewModel(url){
    	window.open(url,url);
    }
    //通知角标
	function badge(){
		$.ajax({
			url: "com.zimax.components.coframe.message.MessageInform.queryMessages.biz.ext",
			type: "POST",
			cache: false,
			contentType: 'text/json',
			data: JSON.stringify({
				msgStatus: "0"
			}),
			success: function(result) {
				if (result.total >= 1 ) {
					$('#layui-badge-dot').attr("class","layui-badge-dot");
				} 
			}
		});
		
		$.ajax({
			url: "com.zimax.components.coframe.auth.LoginManager.getMenuData.biz.ext",
			type: "POST",
			cache: false,
			contentType: 'text/json',
			success: function(result) {
				var data = result.data;
				$("#replyFill").hide();
				$("#message").hide();
				for (var i = 0; i < data.length; i++) {
					var child = data[i].childrenMenuTreeNodeList;
					for (var n = 0; n < child.length; n++) {
						if (child[n].functionCode == "proposal")  $("#replyFill").show();
						if (child[n].functionCode == "message_manager") $("#message").show();
					}
				}
			}
		});
	}
	badge();

	// 监听 Tab 选项卡切换事件
	element.on("tab(layadmin-layout-tabs)", function(data) {
		top.layui.admin.tabsPage.index = data.index;
		// 获取到iframe的src属性
		var src = $(this).attr("lay-id");
		// 获取到对应的iframe中table对象集合，这里取第一个
		if (window.frames[data.index]) {
			var tableDom = window.frames[data.index].document.getElementsByTagName("table")[0];
			// 判断是否存在对应对象以及是否存在table的id属性
			if (tableDom !== undefined && tableDom.id !== undefined && tableDom.id !== "") {
				// 存在则获取iframe元素的Window对象
				var iframe = $('iframe[src="' + src + '"]')[0].contentWindow;
				var layIndex = top.layui.sessionData("LAY-index");
				if (layIndex && layIndex.resize && layIndex.resize == tableDom.id) {
					setTimeout(function() {
						// 调用resize
						iframe.layui.table.resize(tableDom.id);
						top.layui.sessionData("LAY-index", null); 
					}, 10);
				}
			}
		}
	});
</script>
</body>
</html>