/**
 * 视图模块
 */
layui.define(["laytpl", "layer"], function(exports) {
	var $ = layui.jquery;
	var laytpl = layui.laytpl;
	var layer = layui.layer;
	var setter = layui.setter;
	var hint = (layui.device(), layui.hint());
	
	/**
	 * 视图模块类
	 * 
	 * @param id 容器ID
	 * @returns {View} 视图
	 */
	var view = function(id) {
		return new View(id);
	};
	
	// 容器ID
	var containerId = "LAY_app_body";
	
	/**
	 * 视图类
	 * 
	 * @param id 容器ID
	 */
	var View = function(id) {
		this.id = id;
		// 容器元素
		this.container = $("#" + (id || containerId));
	};
	
	/**
	 * 加载中
	 * 
	 * @param container 容器元素
	 */
	view.loading = function(container) {
		this.elemLoad = $('<i class="layui-anim layui-anim-rotate layui-anim-loop layui-icon layui-icon-loading layadmin-loading"></i>');
		container.append(this.elemLoad);
	};
	
	/**
	 * 移除加载中
	 */
	view.removeLoad = function() {
		this.elemLoad && this.elemLoad.remove();
	};
	
	/**
	 * 退出
	 * 
	 * @param callback 回调函数
	 */
	view.exit = function(callback) {
		layui.data(setter.tableName, {
			key: setter.request.tokenName,
			remove: true
		});
		callback && callback();
	};
	
	/**
	 * 请求
	 * 
	 * @param options 选项
	 * @returns
	 */
	view.req = function(options) {
		var success = options.success;
		var error = options.error;
		var request = setter.request;
		var response = setter.response;
		var getDebugInfo = function() {
			return setter.debug ? "<br><cite>URL：</cite>" + options.url : "";
		};
		options.data = options.data || {};
		options.headers = options.headers || {};
		if (request.tokenName) {
			var data = "string" == typeof options.data ? JSON.parse(options.data) : options.data;
			options.data[request.tokenName] = request.tokenName in data ? options.data[request.tokenName] : layui.data(setter.tableName)[request.tokenName] || "";
			options.headers[request.tokenName] = request.tokenName in options.headers ? options.headers[request.tokenName] : layui.data(setter.tableName)[request.tokenName] || "";
		}
		delete options.success;
		delete options.error;
		return $.ajax($.extend({
			type: "get",
			dataType: "json",
			success: function(res) {
				var statusCode = response.statusCode;
				if (res[response.statusName] == statusCode.ok) {
					"function" == typeof options.done && options.done(res);
				} else if (res[response.statusName] == statusCode.logout) {
					view.exit();
				} else {
					var content = ["<cite>Error：</cite> " + (res[response.msgName] || "返回状态码异常"), getDebugInfo()].join("");
					view.error(content);
				}
				"function" == typeof success && success(res);
			},
			error: function(request, status) {
				var content = ["请求异常，请重试<br><cite>错误信息：</cite>" + status, getDebugInfo()].join("");
				view.error(content);
				"function" == typeof error && error(res);
			}
		}, options));
	};
	
	/**
	 * 弹出窗口
	 * 
	 * @param options 选项
	 */
	view.popup = function(options) {
		var success = options.success;
		var skin = options.skin;
		delete options.success;
		delete options.skin;
		return layer.open($.extend({
			type: 1,
			title: "提示",
			content: "",
			id: "LAY-system-view-popup",
			skin: "layui-layer-admin" + (skin ? " " + skin : ""),
			shadeClose: true,
			closeBtn: false,
			success: function(layero, index) {
				var icon = $('<i class="layui-icon" close>&#x1006;</i>');
				layero.append(icon);
				icon.on("click", function() {
					layer.close(index);
				});
				"function" == typeof success && success.apply(this, arguments);
			}
		}, options));
	};
	
	/**
	 * 弹出错误窗口
	 * 
	 * @param content 内容
	 * @param options 选项
	 */
	view.error = function(content, options) {
		return view.popup($.extend({
			content: content,
			maxWidth: 300,
			offset: "t",
			anim: 6,
			id: "LAY_adminError"
		}, options));
	};
	
	/**
	 * 渲染
	 * 
	 * @param url 地址
	 * @param params 参数
	 */
	View.prototype.render = function(url, params) {
		var self = this;
		layui.router();
		url = setter.views + url + setter.engine;
		$("#" + containerId).children(".layadmin-loading").remove();
		view.loading(self.container);
		$.ajax({
			url: url,
			type: "get",
			dataType: "html",
			data: {
				v: layui.cache.version
			},
			success: function(res) {
				res = "<div>" + res + "</div>";
				var titleElem = $(res).find("title");
				var title = titleElem.text() || (res.match(/\<title\>([\s\S]*)\<\/title>/) || [])[1];
				var data = {
					title: title,
					body: res
				};
				titleElem.remove();
				self.params = params || {};
				if (self.then) {
					self.then(data);
					delete self.then;
				}
				self.parse(res);
				view.removeLoad();
				if (self.done) {
					self.done(data);
					delete self.done;
				}
			},
			error: function(event) {
				view.removeLoad();
				if (self.render.isError) {
					return view.error("请求视图文件异常，状态：" + event.status);
				} else {
					if (404 === event.status) {
						self.render("template/tips/404");
					} else {
						self.render("template/tips/error");
					}
					return void(self.render.isError = true);
				}
			}
		});
		return self;
	};
	
	/**
	 * 解析
	 * 
	 * @param e
	 * @param n
	 * @param callback
	 * @returns {View}
	 */
	View.prototype.parse = function(e, n, callback) {
		var self = this;
		var isObject = "object" == typeof e;
		var l = isObject ? e : $(e);
		var templates = isObject ? e : l.find("*[template]");
		var c = function(e) {
			var n = laytpl(e.dataElem.html());
			var o = $.extend({
				params: router.params
			}, e.res);
			e.dataElem.after(n.render(o));
			"function" == typeof callback && callback();
			try {
				e.done && new Function("View", e.done)(o);
			} catch(err) {
				console.error(e.dataElem[0], "\n存在错误回调脚本\n\n", err);
			}
		};
		var router = layui.router();
		l.find("title").remove();
		self.container[n ? "after" : "html"](l.children());
		router.params = self.params || {};
		for (var i = templates.length; i > 0; i--) {
			!function() {
				var dataElem = templates.eq(i - 1);
				var done = dataElem.attr("lay-done") || dataElem.attr("lay-then");
				var url = laytpl(dataElem.attr("lay-url") || "").render(router);
				var data = laytpl(dataElem.attr("lay-data") || "").render(router);
				var headers = laytpl(dataElem.attr("lay-headers") || "").render(router);
				try {
					data = new Function("return " + data + ";")();
				} catch(err) {
					hint.error("lay-data: " + err.message);
					data = {};
				}
				try {
					headers = new Function("return " + headers + ";")();
				} catch(err) {
					hint.error("lay-headers: " + err.message);
					headers = headers || {};
				}
				if (url) {
					view.req({
						type: dataElem.attr("lay-type") || "get",
						url: url,
						data: data,
						dataType: "json",
						headers: headers,
						success: function(res) {
							c({
								dataElem: dataElem,
								res: res,
								done: done
							});
						}
					});
				} else {
					c({
						dataElem: dataElem,
						done: done
					});
				}
			}();
		}
		return self;
	};
	
	/**
	 * 自动渲染
	 * 
	 * @param e
	 * @param a
	 */
	View.prototype.autoRender = function(e, a) {
		var self = this;
		$(e || "body").find("*[template]").each(function(e, a) {
			var container = $(this);
			self.container = container;
			self.parse(container, "refresh");
		});
	};
	
	/**
	 * 
	 * 
	 * @param e
	 * @param t
	 * @returns {View}
	 */
	View.prototype.send = function(e, t) {
		var n = laytpl(e || this.container.html()).render(t || {});
		this.container.html(n);
		return this;
	};
	
	/**
	 * 刷新
	 * 
	 * @param e
	 * @returns {View} 视图
	 */
	View.prototype.refresh = function(e) {
		var self = this;
		var a = self.container.next();
		var templateId = a.attr("lay-templateid");
		if (self.id != templateId) {
			return self;
		} else {
			self.parse(self.container, "refresh", function() {
				self.container.siblings('[lay-templateid="' + self.id + '"]:last').remove();
				"function"==typeof e && e();
			});
			return self;
		}
	};
	
	/**
	 * 设置然后回调函数
	 * 
	 * @param then 然后回调函数
	 * @returns {View} 视图
	 */
	View.prototype.then = function(then) {
		this.then = then;
		return this;
	};
	
	/**
	 * 设置完成回调函数
	 * 
	 * @param done 完成回调函数
	 * @returns {View} 视图
	 */
	View.prototype.done = function(done) {
		this.done = done;
		return this;
	};
	
	// 扩展视图模块
	exports("view", view);
});