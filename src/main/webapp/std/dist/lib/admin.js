/**
 * 管理模块
 */
layui.define("view", function(exports) {
	var $ = layui.jquery;
	var laytpl = layui.laytpl;
	var element = layui.element;
	var setter = layui.setter;
	var view = layui.view;
	var device = layui.device();
	
	var winElem = $(window);
	var bodyElem = $("body");
	var containerElem = $("#" + setter.container);
	var showClass = "layui-show";
	var hideClass = "layui-hide";
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
	
	/**
	 * 管理模块对象
	 */
	var admin = {
		/**
		 * 版本号
		 */
		v: "1.4.0 std",
		
		/**
		 * 请求
		 */
		req: view.req,
		
		/**
		 * 退出
		 */
		exit: view.exit,
		
		/**
		 * 
		 */
		escape: function(e) {
			return String(e || "").replace(/&(?!#?[a-zA-Z0-9]+;)/g,"&amp;").replace(/</g,"&lt;").replace(/>/g,"&gt;").replace(/'/g,"&#39;").replace(/"/g,"&quot;");
		},
		
		/**
		 * 增加自定义模块事件
		 * 
		 * @param events 事件名称
		 * @param callback 回调函数
		 */
		on: function(events, callback) {
			return layui.onevent.call(this, setter.MOD_NAME, events, callback);
		},
		
		/**
		 * 
		 */
		sendAuthCode: function(e) {
			e = $.extend({
				seconds: 60,
				elemPhone: "#LAY_phone",
				elemVercode: "#LAY_vercode"
			}, e);
			var t, i = e.seconds;
			var n = $(e.elem);
			var l = function(a) {
				i--,
				i < 0 ? (
					n.removeClass(f).html("获取验证码"),i=e.seconds,clearInterval(t)
				) : n.addClass(f).html(i+"秒后重获"),
				a || (
					t = setInterval(function() {
						l(!0)
					}, 1e3)
				)
			};
			e.elemPhone = $(e.elemPhone),
			e.elemVercode = $(e.elemVercode),
			n.on("click", function() {
				var t = e.elemPhone;
				var n = t.val();
				if (i === e.seconds && !$(this).hasClass(f)) {
					if (!/^1\d{10}$/.test(n)) {
						t.focus();
						return layer.msg("请输入正确的手机号");
					}
					if ("object" == typeof e.ajax) {
						var s = e.ajax.success;
						delete e.ajax.success;
					}
					admin.req($.extend(true, {
						url: "/auth/code",
						type: "get",
						data: {
							phone: n
						},
						success: function(a) {
							layer.msg("验证码已发送至你的手机，请注意查收", {
								icon: 1,
								shade: 0
							});
							e.elemVercode.focus();
							l();
							s && s(a);
						}
					}, e.ajax));
				}
			});
		},
		
		/**
		 * 
		 */
		screen: function() {
			var e = winElem.width();
			return e > 1200 ? 3 : e > 992 ? 2 : e > 768 ? 1 : 0;
		},
		
		/**
		 * 
		 */
		sideFlexible: function(e) {
			var t = containerElem;
			var i = $("#" + h);
			var l = admin.screen();
			"spread" === e ? (
				i.removeClass(x).addClass(g),
				l<2?t.addClass(v):t.removeClass(v),
				t.removeClass(C)
			) : (
				i.removeClass(g).addClass(x),
				l<2?t.removeClass(C):t.addClass(C),
				t.removeClass(v)
			);
			layui.event.call(this, setter.MOD_NAME, "side({*})", {
				status: e
			});
		},
		
		/**
		 * 弹出窗口
		 */
		popup: view.popup,
		
		/**
		 * 弹出右侧窗口
		 */
		popupRight: function(e) {
			return admin.popup.index = layer.open($.extend({
				type: 1,
				id: "LAY_adminPopupR",
				anim: -1,
				title: false,
				closeBtn: false,
				offset: "r",
				shade: .1,
				shadeClose: true,
				skin: "layui-anim layui-anim-rl layui-layer-adminRight",
				area: "300px"
			}, e));
		},
		
		/**
		 * 主题
		 */
		theme: function(e) {
			var i = (
				setter.theme,layui.data(setter.tableName)
			);
			var l = "LAY_layadmin_theme";
			var s = document.createElement("style");
			var r = laytpl([".layui-side-menu,", ".layadmin-pagetabs .layui-tab-title li:after,",
			                ".layadmin-pagetabs .layui-tab-title li.layui-this:after,", ".layui-layer-admin .layui-layer-title,",
			                ".layadmin-side-shrink .layui-side-menu .layui-nav>.layui-nav-item>.layui-nav-child",
			                "{background-color:{{d.color.main}} !important;}", ".layui-nav-tree .layui-this,",
			                ".layui-nav-tree .layui-this>a,", ".layui-nav-tree .layui-nav-child dd.layui-this,",
			                ".layui-nav-tree .layui-nav-child dd.layui-this a", "{background-color:{{d.color.selected}} !important;}",
			                ".layui-layout-admin .layui-logo{background-color:{{d.color.logo || d.color.main}} !important;}",
			                "{{# if(d.color.header){ }}", ".layui-layout-admin .layui-header{background-color:{{ d.color.header }};}",
			                ".layui-layout-admin .layui-header a,", ".layui-layout-admin .layui-header a cite{color: #f8f8f8;}",
			                ".layui-layout-admin .layui-header a:hover{color: #fff;}",
			                ".layui-layout-admin .layui-header .layui-nav .layui-nav-more{border-top-color: #fbfbfb;}",
			                ".layui-layout-admin .layui-header .layui-nav .layui-nav-mored{border-color: transparent; border-bottom-color: #fbfbfb;}",
			                ".layui-layout-admin .layui-header .layui-nav .layui-this:after, .layui-layout-admin .layui-header .layui-nav-bar{background-color: #fff; background-color: rgba(255,255,255,.5);}",
			                ".layadmin-pagetabs .layui-tab-title li:after{display: none;}","{{# } }}"].join("")).render(e = $.extend({}, i.theme, e));
			var u = document.getElementById(l);
			"styleSheet" in s ? (
				s.setAttribute("type", "text/css"),
				s.styleSheet.cssText = r
			) : s.innerHTML = r;
			s.id = l;
			u && bodyElem[0].removeChild(u);
			bodyElem[0].appendChild(s);
			bodyElem.attr("layadmin-themealias", e.color.alias);
			i.theme = i.theme || {};
			layui.each(e, function(e, a) {
				i.theme[e] = a;
			});
			layui.data(setter.tableName, {
				key: "theme",
				value: i.theme
			});
		},
		
		/**
		 * 初始化主题
		 */
		initTheme: function(e) {
			var a = setter.theme;
			e = e || 0;
			a.color[e] && (
				a.color[e].index = e,
				admin.theme({
					color: a.color[e]
				})
			);
		},
		
		tabsPage: {},
		
		tabsBody: function(e) {
			return $(m).find("." + b).eq(e || 0);
		},
		
		tabsBodyChange: function(e, a) {
			a = a || {};
			admin.tabsBody(e).addClass(showClass).siblings().removeClass(showClass);
			events.rollPage("auto", e);
			layui.event.call(this, setter.MOD_NAME, "tabsPage({*})", {
				url: a.url,
				text: a.text
			});
		},
		
		resize: function(e) {
			var a = layui.router(),
			t = a.path.join("-");
			admin.resizeFn[t] && (
				winElem.off("resize",admin.resizeFn[t]),delete admin.resizeFn[t]
			),
			"off" !== e && (
				e(),
				admin.resizeFn[t] = e,
				winElem.on("resize", admin.resizeFn[t])
			)
		},
		
		resizeFn: {},
		
		runResize: function() {
			var e = layui.router();
			var a = e.path.join("-");
			admin.resizeFn[a] && admin.resizeFn[a]();
		},
		
		delResize: function() {
			this.resize("off");
		},
		
		closeThisTabs: function() {
			admin.tabsPage.index && $(_).eq(admin.tabsPage.index).find(".layui-tab-close").trigger("click");
		},
		
		fullScreen: function() {
			var e = document.documentElement,
			a = e.requestFullScreen || e.webkitRequestFullScreen || e.mozRequestFullScreen || e.msRequestFullscreen;
			"undefined" != typeof a && a && a.call(e);
		},
		
		exitScreen: function() {
			document.documentElement;
			document.exitFullscreen ? document.exitFullscreen() : document.mozCancelFullScreen ? document.mozCancelFullScreen() : document.webkitCancelFullScreen ? document.webkitCancelFullScreen() : document.msExitFullscreen && document.msExitFullscreen();
		}
	};
	
	/**
	 * 业务字典
	 */
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
				if (dict.contains(dictId, dictEntry.dictID)) {
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
			admin.req({
				url: "com.zimax.components.coframe.DictLoader.getDictData.biz.ext",
				data: {
					dictTypeId : dictTypeId
				},
				async: false,
				success: function(res) {
					if (res[setter.response.dataName]) {
						var dictList = res[setter.response.dataName].dictList;
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
				admin.req({
					url: "com.zimax.components.coframe.DictLoader.getDictData.biz.ext",
					data: {
						dictTypeId: dictTypeId
					},
					async: false,
					success: function(res) {
						if (res[setter.response.dataName]) {
							var e = res[setter.response.dataName].dictList;
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
			$(options.elem).empty();
			$(options.elem).append(new Option("", ""));
			this.loadDict(options);
			var datas = dict.map[options.dictTypeId];
			for (var i = 0; i < datas.length; i++) {
				$(options.elem).append(new Option(datas[i].dictName, datas[i].dictID));
			}
		}
	};
	admin.getDictText = dict.getDictText;
	admin.loadDict = dict.loadDict;
	admin.renderDictSelect = dict.renderDictSelect;
	
	/**
	 * 事件集合
	 */
	var events = admin.events = {
		
		flexible: function(e) {
			var a = e.find("#" + h);
			var t = a.hasClass(x);
			admin.sideFlexible(t ? "spread" :null);
		},
		
		refresh: function() {
			var e = ".layadmin-iframe",
			t = $("." + b).length;
			admin.tabsPage.index >= t && (
				admin.tabsPage.index = t - 1
			);
			var i = admin.tabsBody(admin.tabsPage.index).find(e);
			i[0].contentWindow.location.reload(!0);
		},
		
		serach: function(e) {
			e.off("keypress").on("keypress", function(a) {
				if (this.value.replace(/\s/g, "") && 13 === a.keyCode) {
					var t = e.attr("lay-action");
					var i = e.attr("lay-text") || "搜索";
					t += this.value;
					i = i + ' <span style="color: #FF5722;">' + admin.escape(this.value) + "</span>";
					layui.index.openTabsPage(t, i);
					events.serach.keys || (
						events.serach.keys = {}
					);
					events.serach.keys[admin.tabsPage.index] = this.value;
					this.value === events.serach.keys[admin.tabsPage.index] && events.refresh(e);
					this.value = "";
				}
			});
		},
		
		message: function(e) {
			e.find(".layui-badge-dot").remove();
		},
		
		theme: function() {
			admin.popupRight({
				id: "LAY_adminPopupTheme",
				success: function() {
					view(this.id).render("system/theme");
				}
			});
		},
		
		note: function(e) {
			var a = admin.screen() < 2;
			var t = layui.data(setter.tableName).note;
			events.note.index = admin.popup({
				title: "便签",
				shade: 0,
				offset: ["41px",a?null:e.offset().left-250+"px"],
				anim: -1,
				id: "LAY_adminNote",
				skin: "layadmin-note layui-anim layui-anim-upbit",
				content: '<textarea placeholder="内容"></textarea>',
				resize: !1,
				success: function(e, a) {
					var i = e.find("textarea");
					var l = void 0 === t ? "便签中的内容会存储在本地，这样即便你关掉了浏览器，在下次打开时，依然会读取到上一次的记录。是个非常小巧实用的本地备忘录" : t;
					i.val(l).focus().on("keyup", function() {
						layui.data(setter.tableName, {
							key: "note",
							value: this.value
						});
					});
				}
			});
		},
		
		fullscreen: function(e) {
			var a = "layui-icon-screen-full",
			t = "layui-icon-screen-restore",
			i = e.children("i");
			i.hasClass(a) ? (
				admin.fullScreen(),i.addClass(t).removeClass(a)
			) : (
				admin.exitScreen(),i.addClass(a).removeClass(t)
			);
		},
		
		about: function() {
			admin.popupRight({
				id: "LAY_adminPopupAbout",
				success: function() {
					view(this.id).render("system/about");
				}
			});
		},
		
		more: function() {
			admin.popupRight({
				id: "LAY_adminPopupMore",
				success: function() {
					view(this.id).render("system/more");
				}
			});
		},
		
		back: function() {
			history.back();
		},
		
		setTheme: function(e) {
			var a = e.data("index");
			e.siblings(".layui-this").data("index");
			e.hasClass(y) || (
				e.addClass(y).siblings(".layui-this").removeClass(y),
				admin.initTheme(a)
			);
		},
		
		rollPage: function(e, t) {
			var i = $("#LAY_app_tabsheader");
			var n = i.children("li");
			var l = (
				i.prop("scrollWidth"),i.outerWidth()
			);
			var s = parseFloat(i.css("left"));
			if ("left" === e) {
				if (!s && s <= 0)
					return;
				var r = -s - l;
				n.each(function(e, t) {
					var n = $(t);
					var l = n.position().left;
					if (l >= r)
						return i.css("left", -l), !1;
				});
			} else "auto" === e ? !function() {
				var e,r=n.eq(t);
				if (r[0]) {
					if (e=r.position().left,e<-s)
						return i.css("left",-e);
					if (e+r.outerWidth()>=l-s) {
						var o = e + r.outerWidth() - (l - s);
						n.each(function(e, t) {
							var n = $(t),
							l = n.position().left;
							if (l + s > 0 && l - s > o)
								return i.css("left",-l), !1;
						});
					}
				}
			}() : n.each(function(e, t) {
				var n = $(t),
				r = n.position().left;
				if (r + n.outerWidth() >= l - s)
					return i.css("left", -r), !1;
			});
		},
		
		leftPage: function() {
			events.rollPage("left");
		},
		
		rightPage: function() {
			events.rollPage();
		},
		
		closeThisTabs: function() {
			var e = parent === self ? admin : parent.layui.admin;
			e.closeThisTabs();
		},
		
		closeOtherTabs: function(e) {
			var t = "LAY-system-pagetabs-remove";
			"all" === e ? (
				$(_ + ":gt(0)").remove(),
				$(m).find("." + b + ":gt(0)").remove(),
				$(_).eq(0).trigger("click")
			) : (
				$(_).each(function(e, i) {
					e && e != admin.tabsPage.index && (
						$(i).addClass(t),
						admin.tabsBody(e).addClass(t)
					);
				}),
				$("."+t).remove()
			);
		},
		
		closeAllTabs: function() {
			events.closeOtherTabs("all");
		},
		
		shade: function() {
			admin.sideFlexible();
		},
		
		update: function() {
			$.ajax({
				type: "get",
				dataType: "jsonp",
				data: {
					name: "layuiAdmin",
					version: admin.v
				},
				url: "https://fly.layui.com/api/product_update/",
				success: function(e) {
					if (0 === e.status) {
						if (e.version === admin.v.replace(/\s|pro|std/g, "")) {
							layer.alert("当前版本已经是最新版本");
						} else {
							layer.alert("检查到更新，是否前往下载？", {
								btn :["更新", "暂不"]
							}, function(e) {
								layer.close(e);
								layer.open({
									type: 2,
									content: "https://fly.layui.com/user/product/",
									area: ["100%", "100%"],
									title: "检查更新"
								});
							});
						}
					} else if (1 == e.status) {
						layer.alert(e.msg, {
							btn: ["登入", "暂不"]
						}, function(e) {
							layer.close(e);
							layer.open({
								type: 2,
								content: "https://fly.layui.com/user/login/",
								area: ["100%", "100%"],
								title: "检查更新"
							});
						});
					} else {
						layer.msg(e.msg || e.code, {
							shift: 6
						});
					}
				},
				error: function(e) {
					layer.msg("请求异常，请重试", {
						shift: 6
					});
				}
			});
		},
		
		im: function() {
			admin.popup({
				id: "LAY-popup-layim-demo",
				shade: 0,
				area: ["800px", "300px"],
				title: "面板外的操作示例",
				offset: "lb",
				success: function() {
					view(this.id).render("layim/demo").then(function() {
						layui.use("im");
					});
				}
			});
		}
	};
	
	!function() {
		var data = layui.data(setter.tableName);
		data.theme ? admin.theme(data.theme) : setter.theme && admin.initTheme(setter.theme.initColorIndex);
		"pageTabs" in layui.setter || (
			layui.setter.pageTabs = true
		);
		setter.pageTabs || (
			$("#LAY_app_tabs").addClass(hideClass),
			containerElem.addClass("layadmin-tabspage-none")
		);
		if (device.ie && device.ie < 10) {
			view.error("IE" + device.ie + "下访问可能不佳，推荐使用：Chrome / Firefox / Edge 等高级浏览器", {
				offset: "auto",
				id: "LAY_errorIE"
			});
		}
	}();
	
	element.on("tab(" + p + ")", function(e) {
		admin.tabsPage.index = e.index;
	});
	
	admin.on("tabsPage(setMenustatus)", function(e) {
		var t = e.url;
		var i = function(e) {
			return {
				list: e.children(".layui-nav-child"),
				a: e.children("*[lay-href]")
			};
		};
		var n = $("#" + k);
		var l = "layui-nav-itemed";
		var s = function(e) {
			e.each(function(e, n) {
				var s = $(n);
				var r = i(s);
				var o = r.list.children("dd");
				var u = t === r.a.attr("lay-href");
				o.each(function(e, n) {
					var s=$(n),
					r=i(s),
					o=r.list.children("dd"),
					u=t===r.a.attr("lay-href");
					o.each(function(e, n) {
						var s = $(n),
						r = i(s),
						o = t === r.a.attr("lay-href");
						if (o) {
							var u = r.list[0] ? l : y;
							return s.addClass(u).siblings().removeClass(u),!1;
						}
					});
					if (u) {
						var d=r.list[0]?l:y;
						return s.addClass(d).siblings().removeClass(d),!1;
					}
				});
				if (u) {
					var d = r.list[0] ? l : y;
					s.addClass(d).siblings().removeClass(d);
					return !1;
				}
			});
		};
		n.find("." + y).removeClass(y);
		admin.screen() < 2 && admin.sideFlexible();
		s(n.children("li"));
	});
	
	element.on("nav(layadmin-system-side-menu)", function(e) {
		e.siblings(".layui-nav-child")[0] && containerElem.hasClass(C) && (
			admin.sideFlexible("spread"),
			layer.close(e.data("index"))
		);
		admin.tabsPage.type = "nav";
	});
	
	element.on("nav(layadmin-pagetabs-nav)", function(e) {
		var a = e.parent();
		a.removeClass(y);
		a.parent().removeClass(showClass);
	});
	
	var A = function(e) {
		var a = (e.attr("lay-id"), e.attr("lay-attr"));
		var t = e.index();
		admin.tabsBodyChange(t, {
			url: a
		});
	};
	
	var _ = "#LAY_app_tabsheader>li";
	
	bodyElem.on("click", _, function() {
		var e = $(this);
		var t = e.index();
		admin.tabsPage.type = "tab";
		admin.tabsPage.index = t;
		A(e);
	});
	
	element.on("tabDelete(" + p + ")", function(e) {
		var t = $(_ + ".layui-this");
		e.index && admin.tabsBody(e.index).remove();
		A(t);
		admin.delResize();
	});
	
	bodyElem.on("click", "*[lay-href]", function() {
		var e = $(this);
		var url = e.attr("lay-href");
		var text = e.attr("lay-text");
		layui.router();
		admin.tabsPage.elem = e;
		var n = parent === self ? layui : top.layui;
		n.index.openTabsPage(url, text || e.text());
		url === admin.tabsBody(admin.tabsPage.index).find("iframe").attr("src") && admin.events.refresh();
	});
	
	bodyElem.on("click", "*[layadmin-event]", function() {
		var e = $(this);
		var t = e.attr("layadmin-event");
		events[t] && events[t].call(this, e);
	});
	
	bodyElem.on("mouseenter", "*[lay-tips]", function() {
		var e = $(this);
		if (!e.parent().hasClass("layui-nav-item") || containerElem.hasClass(C)) {
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
		layer.close($(this).data("index"));
	});
	
	var z = layui.data.resizeSystem = function() {
		layer.closeAll("tips");
		z.lock || setTimeout(function() {
			admin.sideFlexible(admin.screen() < 2 ? "" : "spread");
			delete z.lock;
		}, 100);
		z.lock = true;
	};
	
	winElem.on("resize", layui.data.resizeSystem);
	
	// 扩展管理模块
	exports("admin", admin);
});