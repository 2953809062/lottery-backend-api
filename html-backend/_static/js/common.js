/**
 * 得到日期格式化结果
 * @param {int} stamp
 * @returns {string}
 */
var getDateYmdHi = function(stamp) {
	var time = new Date(stamp * 1000);
	var Y = time.getFullYear() + '-';
	var M = (time.getMonth() + 1 < 10 ? '0' + (time.getMonth() + 1) : time.getMonth() + 1) + '-';
	var D = time.getDate();
	var h = time.getHours();
	var m = time.getMinutes();
	return Y + M + (D > 9 ? D : '0' + D) + ' ' + (h > 9 ? h : '0' + h) + ':' + (m > 9 ? m : '0' + m);
};

/**
 * 得到location.search中当中的query-string
 */
var getQuery = function() { 
	var key = "url";
	if (arguments.length >= 1) { 
		key = arguments[0];
	}
	var search = location.search.substring(1);
	var sArr = search.split('&');
	for (var i = 0; i < sArr.length; i++) { 
		var qArr = sArr[i].split('=');
		if (qArr[0] === key) { 
			return decodeURIComponent(qArr[1]);
		}
	}
	return "";
};

/**
 * 将url当中设置一些get参数
 */
var setQuery = function(url, key, value) { 
	var sArr = url.split('?');
	if (sArr.length < 2) { 
		return url + '?' + key + '=' + value;
	}
	var uStr = '';
	var qArr = sArr[1].split('&');
	var added = false;
	var nUrl = '';
	for (var i = 0; i < qArr.length; i++) { 
		if (qArr[i] === '') { 
			continue;
		}
		var tArr = qArr[i].split('=');
		if (tArr[0] === key) { 
			if (!added) {
				uStr += '&' + key + '=' + value;
				added = true;
			}
			continue;
		}
		uStr += '&' + qArr[i];
	}
	if (!added) { 
		uStr += '&' + key + '=' + value;
	}
	return sArr[0] + '?' + (uStr.length > 1 ? uStr.substring(1) : '');
};

/**
 * 得到rows中的每个值(经过过滤处理)
 */
var getValue = function(key, value) { 
	if (key === "created" || key === "updated" || key === "last_login" || key === "period_start" || key === "period_end" || key === "open_time") { 
		if (value === 0) { 
			return "";
		} 
		return getDateYmdHi(value);
	} else if (key === "status") {
	    var cla = (value === 1 ? '#5FB878' : '#FF5722');
		return'<span style="color:' + cla +'">' + (value === 1 ? '已启用' : '已停用') + '</span>';
	} else if (key.substring(0, 3) == "is_") { 
		var cla = (value === 1 ? '#5FB878' : '#FF5722');
		return'<span style="color:' + cla +'">' + (value === 1 ? '是' : '否') + '</span>';
	} else if (caches[key]) { 
		return caches[key](value);
	} 
	return value;
};

/**
 * 得到缓存信息
 *
 * @param {string} key
 * @param {function} callback 回调函数
 * @returns {object}
 */
var setHtml = function (key, elementId, callback) {
	var value = window.localStorage.getItem(key);
	if (value) {
		elementId.html(value);
		callback();
	}
	layui.use(['jquery'], function() { 
		var $ = layui.jquery;
		$.get("/" + key + ".html", function(res) { 
			if (res !== "") { 
				window.localStorage.setItem(key, res);
				elementId.html(res);
				var btn = '<div class="layui-inline layui-show-xs-block">' + 
					'<button class="layui-btn"  lay-submit="" lay-filter="search"><i class="layui-icon">&#xe615;</i></button>' +
					'</div>';
				elementId.append(btn);
				callback();
			}
		});
	});
};

/**
 * 得到缓存信息
 *
 * @param {string} key
 * @param {function} callback 回调函数
 * @returns {object}
 */
var setForm = function (key, elementId, callback) {
	var value = window.localStorage.getItem(key);
		if (value) {
		elementId.html(value);
		callback();
		return;
	}

	var btn = '<div class="layui-form-item">' +
			'<label for="L_repass" class="layui-form-label"> </label>' +
			'<button  class="layui-btn" lay-filter="save" lay-submit=""> 保存数据 </button>' +
			'</div>';
	layui.use(['jquery'], function() { 
		var $ = layui.jquery;
		$.get("/" + key + ".html", function(res) { 
			if (res !== "") { 
				window.localStorage.setItem(key, res + btn);
				elementId.html(res + btn);
				callback();
			}
		});
	});
};

/**
 * 显示编辑对话框
 */
var showEditDialog = function(url) { 
	var urlEdit = "/edit.html?url=" + url + "/edit";
	var controller = url.split("/")[0];
	var conf = routers[controller];
	if (conf) { 
		var win = conf[0];
		xadmin.open('添加记录', urlEdit, win[0], win[1]);
		return;
	}
	xadmin.open('添加记录', urlEdit, 600, 800);
};

/**
 * 加载所有的数据记录
 */
var widths = {
	id: 40,
	status: 40,
	sort: 40,
	updated: 100,
	created: 100,
	finished: 100,
	last_login: 100,
	period_start: 100,
	period_end: 100
};
var loadRows = function(realUrl) { 
	var $ = layui.jquery, form = layui.form;
	var table = $(".layui-table:first");
	var thead = $("thead:first", table);
	var tbody = $("tbody:first", table);
	
	$.ajax({
		url: "http://127.0.0.1:8801/v1/" + realUrl,
		dataType: "json",
		type: "get",
		success: function(res) { 
			if (res.code !== 200) { 
				return;
			}
			var headers = res.result.headers;
			var keys = [];
			var option = res.result.options;
			var tr = '<tr><th width="20"> <input type="checkbox" name="row_ids" lay-skin="primary" /> </th>';
			for (var i = 0; i < headers.length; i++) { 
				var key = Object.keys(headers[i])[0];
				var width = widths[key];
				if (width) { 
					width = 'width="' + width + '"';
				}
				keys.push(key);
				var value = headers[i][key];
				tr += '<th ' + width + '>' + value + '</th>';
			}
			if (option.update || option.delete) {
				tr += '<th width="100">操作</th>';
			}
			tr += '</tr>';
			thead.html(tr);

			var records = res.result.list;
			tbody.empty();
			for (var i = 0; i < records.length; i++) { 
				tr = '<tr>' +
					'<td> <input type="checkbox" name="row_id[]"  lay-skin="primary"> </td>';
				for (var j = 0; j < keys.length; j++) { 
					var key = keys[j];
					var value = records[i][key];
					tr += '<td>' + getValue(key, value) + '</td>';
				}
				if (option.update || option.delete) {
					tr += '<td>';
					if (option.update) {
						tr += '<span style="color: #1E9FFF" onclick="xadmin.open(\'编辑\',\'admin-edit.html\')"><i class="layui-icon"></i>编辑</span>';
						if (option.delete) {
							tr += '&nbsp;&nbsp;';
						}
					}
					if (option.delete) {
						tr += '<span style="color: #FF5722" onclick="member_del(this,\'要删除的id\')" href="javascript:;"><i class="layui-icon"></i>删除</span>';
					}
					tr += '</td>';
				}
				tr += '</tr>';
				tbody.append(tr);
			}

			if (option.delete || option.create) { 
				$("#action-option").removeClass("layui-hide");
				if (option.delete) { 
					$("#action-delete").removeClass("layui-hide");
				}
				if (option.create) { 
					$("#action-create").removeClass("layui-hide");
				}
			}
			loadPager(realUrl, res.result.total);
			form.render();
		}
	});
};

// 加载分页信息
var currentPage = 1;
var loadPager = function(url, total) { 
	//执行一个laypage实例
	layui.use(['laypage'], function() { 
		layui.laypage.render({
			elem: 'pager',
			count: total,
			limit: 20,
			curr: currentPage,
			jump: function(obj, first) { 
				if (first || currentPage === obj.curr) { 
					//console.log('是首次加载或者是当前页, 不再进行处理');
					return;
				}
				currentPage = obj.curr;
				var pageUrl = setQuery(url, 'page', currentPage);
				loadRows(pageUrl);
			}
		});
	});
};

