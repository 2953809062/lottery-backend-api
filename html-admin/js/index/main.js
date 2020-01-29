$(function() {
	// api地址
	var HostApi = "http://127.0.0.1:8801/v1/"; // 默认的api地址
	var PageCurrent = 1, PageSize = 20; // 当前页, 每页记录数
	var FormEdit = $("#form-content");
	var CurrentUrl = "";
	var RouterDefaults = { // 部分路由的默认行为
		"index": function(url) {
			//if (url === CurrentUrl) {
			//	return;
			//}
			CurrentUrl = url;
			var apiUrl = HostApi + url;
			var callback = arguments.length > 1 ? arguments[1] : null;
			$.get(apiUrl + "?limit=" + PageSize + "&page=" + PageCurrent, function(response) {
				var result = response.result;
				if (callback !== null) {
					showRows(result.headers, result.list, result.options, callback);
				} else {
					showRows(result.headers, result.list, result.options);
				}
				$("#action-pager").html(getPager(result.total, PageSize, PageCurrent));
				$("#action-create").attr("link", url + "/edit");
				var options = result.options;
				if (options.create) {
					$("#action-create").show();
				}
				if (options.delete) {
					$("#action-delete").show();
				}
				$("#form-content").attr("controller", url.split("/")[0]);
			}, "json");
		}
	};
	caches.apiUrl = HostApi; //设置apiurl

	// 路由
	var routers = {
		"index/right":			[null, indexRight], //首页/右侧
		"index/top":			[null], //首页/顶部
		"platforms":			["index"], //平台
		"platforms/edit":		[null],
		"sites":				["index", caches.get],
		"sites/edit":			[null, function() {
			caches.fill("platforms");
		}], //站点/编辑
		"site_configs":			["index", caches.get],
		"site_configs/edit":	[null, function() { //站点配置/编辑
			caches.fill("platforms");
			caches.fill("sites");
		}],  
		"admins":				["index", caches.get],
		"admins/edit":			[null],
		"admin_roles":			["index"],
		"admin_roles/edit":		[null],
		"admin_logs":			["index", caches.get],
		"menus":				["index"],
		"menus/edit":			[null],
		"users":				["index", caches.get],
		"users/edit":			[null],
		"user_roles":			["index"],
		"user_roles/edit":		[null],
		"user_levels":			["index"],
		"user_levels/edit":		[null],
		"user_accounts":		["index", function(key, value) {
			switch (key) {
				case "id":
				case "user_id":
				case "user_name":
				case "updated":
					return value;
				case "is_locked":
					return value === 1 ? '<span class="green">Yes</span>' : '<span class="red">No</span>';
				default:
					return (Math.round(value * 1000) / 1000).toFixed(3);
			}
		}],
		"notices":				["index"],
		"notices/edit":			[null],
		"activities":			["index"],
		"activities/dedit":		[null],
		"user_charges":			["index"],
		"game_categories":		["index"],
		"game_categories/edit": [null],
		"games":				["index"],
		"games/edit":			[null],
		"user_withdraws":		["index"],
		"banks":				["index"],
		"provinces":			["index"],
		"cities":				["index"],
		"user_cards":			["index"],
		"configs":				["index"],
	};

    // 加载默认的页面
    loadPage("index/top");

	/**
	 * 加载页面
	 *
	 * @param {string} link
	 */
	var loadUrl = function(link) {
		console.log("请求地址: " +  HostApi + link);
		var values = routers[link];
		var url = values[0];
		if (url === null) {  //表示取link的值
			url = link;
		}
		var callback = null;
		var rowCallback = null;
		if (values.length > 1) {
			rowCallback = values[1];
		}
		var contentId = null;
		if (url === "index") {  //如果没有指定函数
			if (rowCallback === null) {
				callback = function() {
					RouterDefaults["index"](link);
				}
			} else { 
				callback = function() {
					RouterDefaults["index"](link, rowCallback);
				}
			}
			contentId = "index-right";
		} else if (url === "edit") {
			if (rowCallback !== null) {
				callback = rowCallback
			}
			contentId = "form-content";
		}
		loadPage(url, callback, contentId)
	};

    // 左侧菜单按钮
    $("#left-links a").click(function() {
        var link = $(this).attr("link");
        if (link === "") {
            return;
        }
		loadUrl(link);
    });
    // 添加记录
	$(document).on('click', ".action-links", function() {
		var link = $(this).attr("link");
		console.log("link = " + link);
		if (!link || link === "" || link === undefined) {
			return;
		}
		FormEdit = $("#form-content");
		var values = routers[link];
		var callback = null;
		if (values.length > 1) {
			callback = values[1];
		}
		var showDialog = function() {
			$("#action-submit").attr("controller", link.split("/")[0]);
			$("#action-edit-show").trigger("click");
		};
		if (FormEdit.html().length > 10) {
			if (callback !== null) {
				callback();
			}
			showDialog();
			return;
		}
		loadPage(link, function() {
			if (callback !== null) {
				callback();
			}
			showDialog();
		}, "form-content");
	});
	// 修改记录
	$(document).on('click', '.action-update', function() {
		FormEdit = $("#form-content");
		var controller = FormEdit.attr('controller'); //控制器名称
		var id = $("td:eq(1)", $(this).parent().parent()).text();
		var apiUrl = HostApi + controller + "/detail?id=" + id;
		var editUrl = controller + "/edit";
		loadPage(editUrl, function() {
			var values = routers[editUrl];
			if (values.length > 1) {
				values[1]();
			}
			FormEdit.append("<input type='hidden' value='' name='id' />"); //追加显示id
			$.get(apiUrl, function(result) {
				if (result.code === 200) {  //如果成功
					var keys = Object.keys(result.result);
					for (var i = 0; i < keys.length; i++) {
						var key = keys[i];
						$("input", FormEdit).each(function() {
							var that = $(this);
							if (that.attr("name") === key) {
								that.val(result.result[key]);
							}
						});
						$("select", FormEdit).each(function() {
							var that = $(this);
							if (that.attr("name") === key) {
								that.val(result.result[key]);
							}
						});
					}
					$("#action-submit").attr("controller", controller);
					$("#action-edit-show").trigger("click");
				}
			}, "json");
		}, "form-content");
		console.log("获取记录详情: " + apiUrl);
	});
	// 提交按钮
	$(document).on('click', '#action-submit', function() {
		var id = $("input[name=id]:first").val();
		var apiUrl = HostApi + $(this).attr("controller");
		if (id) {
			apiUrl += "/update";
		} else {
			apiUrl += "/create";
		}

		var data = {};
		var inputs = FormEdit.serializeArray(); //转换为array数据
		for (var i = 0; i < inputs.length; i++) {
			var input = inputs[i];
			if (!data[input.name]) {
				data[input.name] = input.value;
			}
		}
		if (inputs.length >= 1) {
			$.ajax({
				url: apiUrl,
				type: "post",
				dataType: "json",
				data: JSON.stringify(data),
				headers: {
					'Content-Type': 'application/json'
				},
				success: function (res) {
					if (res.code !== 200) {
						alertErr(res.message);
					} else {
						alertSuccess('操作成功', function() {
							loadUrl(CurrentUrl);
						});
					}
				}
			});
		}
	});
	// 全选
	$(document).on('click', '#check-all', function() {
		var status = $(this).prop("checked");
		$("input[type=checkbox]", $("#index-rows")).each(function() {
			$(this).prop("checked", status);
		});
	});
	// 删除
	$(document).on('click', '.action-delete', function() {
		var id = $("td:first", $(this).parent().parent()).text();
		if (id === "") {
			alertErr("没有选中任何记录!");
			return;
		}
		var controller = $("#form-content").attr("controller");
		var apiUrl = HostApi + controller + "/delete";
		$.get(apiUrl, function(result) { //删除数据
			if (result.code === 200) {  // 如果成功

			}
		}, "json");
	});
});
