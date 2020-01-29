/**
 * 得到日期格式化结果
 * @param {int} stamp
 * @returns {string}
 */
var getDateYmdHi = function(stamp) {
	var time = new Date(stamp * 1000);
	var Y = time.getFullYear() + '-';
	var M = (time.getMonth() + 1 < 10 ? '0' + (time.getMonth() + 1) : time.getMonth() + 1) + '-';
	var D = time.getDate() + ' ';
	var h = time.getHours() + ':';
	var m = time.getMinutes();
	return Y + M + D + h + m;
};

/**
 * 得到缓存信息
 *
 * @param {string} key
 * @param {function} callback 回调函数
 * @returns {object}
 */
var getCache = function (key, callback) {
	var value = window.localStorage.getItem(key);
	if (value) {
		return value;
	}
	value = callback();
	window.localStorage.setItem(key, value);
	return value;
};

// 缓存控制
var caches = {
	apiUrl: "",
	platforms: null,
	sites: null,
	userRoles: null,
	userLevels: null,
	adminRoles: null,
	logTypes: null,
	logLevels: null
};

/**
 * 通用url调用
 */
caches.apiUrls = {
	"platforms": "platforms/all",
	"sites": "sites/all",
	"adminRoles": "admin_roles/all",
	"userRoles": "user_roles/all",
	"userLevels": "user_levels/all",
	"logLevels": "conf/log_levels",
	"logTypes": "conf/log_types"
};

/**
 * 一些通用的api回调处理
 */
caches.apiCallbacks = { 
	idNames: function(rows) { 
		var objects = {};
		for (var i = 0; i < rows.length; i++) {
			objects[rows[i].id] = rows[i].name;
		}
		return objects;
	}
};

/**
 * 加载本地配置的缓存项
 */
caches.loadCaches = function(key, callback) { 
	if (!caches[key]) {
		caches[key] = JSON.parse(getCache(key, function() {
			var objects = {};
			$.ajax({
				"url": caches.apiUrl + caches.apiUrls[key],
				"dataType": "json",
				"type": "get",
				"async": false,
				"success": function(result) {
					objects = callback(result.result);
				}
			});
			return JSON.stringify(objects);
		}));
	}
};

/**
 * 依据platform_id得到对应的值
 * @param id
 * @returns {*}
 */
caches.platform_id = function(id) {
	caches.loadCaches("platforms", caches.apiCallbacks.idNames);
	return caches.platforms[id];
};
/**
 * 得到站点信息
 * @param id
 * @returns {*}
 */
caches.site_id = function(id) {
	caches.loadCaches("sites", caches.apiCallbacks.idNames);
	return caches.sites[id];
};
caches.admin_role_id = function(id) {
	caches.loadCaches("adminRoles", caches.apiCallbacks.idNames);
	return caches.adminRoles[id];
};
caches.user_role_id = function(id) {
	caches.loadCaches("userRoles", caches.apiCallbacks.idNames);
	return caches.userRoles[id];
};
caches.user_level_id = function(id) {
	caches.loadCaches("userLevels", caches.apiCallbacks.idNames);
	return caches.userLevels[id];
};
caches.log_type = function(id) {
	caches.loadCaches("logTypes", caches.apiCallbacks.idNames);
	return caches.logTypes[id];
};
caches.log_level = function(id) {
	caches.loadCaches("logLevels", caches.apiCallbacks.idNames);
	return caches.logLevels[id];
};
/**
 * 依据key得到value
 * @param key
 * @param value
 * @returns {*}
 */
caches.get = function(key, value) {
	var process = caches[key];
	if (process) {
		return process(value);
	}
	return value;
};
/**
 * 得到此key的所有信息
 * @param key
 * @returns {*}
 */
caches.getAll = function(key) {
	caches.loadCaches(key, caches.apiCallbacks.idNames);
	return caches[key];
};
/**
 * 将信息填充到表单
 * @param key
 */
caches.fill = function(key) {
	var obj = caches.getAll(key);
	var element = $("#" + key);
	var keys  = Object.keys(obj);
	for (var i = 0; i < keys.length; i++) {
		element.append(new Option(obj[keys[i]], keys[i]));
	}
};

/**
 * 加载页面
 * @param {string} url 加载的key/url
 */
var loadPage = function(url) {
	if (url === "") {
		return
	}
	var content = window.localStorage.getItem(url);
	var callback = null;
	if (arguments.length >= 2 && arguments[1]) {
		callback = arguments[1];
	}
	var elementId = url.replace("/", "-");
	if (arguments.length >= 3 && arguments[2]) {
		elementId = arguments[2];
	}
	if (!content) {
		var elementsUrl = "elements/" + url + ".html";
		$.get(elementsUrl, function(data) {
			window.localStorage.setItem(url, data);
			$("#" + elementId).html(data);
			if (callback !== null) {
				callback();
			}
		});
	} else {
		$("#"+ elementId).html(content);
		if (callback !== null) {
			callback();
		}
	}
};

/**
 * 得到分页信息
 *
 * @param {int} total 记录总数
 * @param {int} limit 每页记录数
 * @param {int} currentPage 当前页数
 * @returns {string}
 */
var getPager = function(total, limit, currentPage) {
	//<li class="disabled"><span>«</span></li>
	//<li class="active"><span>1</span></li>
	//<li><a href="#1">2</a></li>
	//<li class="disabled"><span>...</span></li>
	//<li><a href="#!">14453</a></li>
	//<li><a href="#!">»</a></li>
	var hasPage = total % limit; //是否正好是整数页数
	var pageCount = Math.floor(total / limit); //总页数
	if (hasPage !== 0 && pageCount >= 1) {
		pageCount += 1;
	}
	if (pageCount === 1) { //只有1页则不显示分页
		return ""
	}
	var pageStr = "";
	if (pageCount <= 10) {
		for (var i = 1; i <= pageCount; i++) {
			pageStr += '<li><a href="#1">' + i + '</a></li>';
		}
		return pageStr
	}
	pageStr += '<li><a href="#">1</a></li>'; //显示第1页
	if (currentPage <= 4) {
		for (var i = 2; i <= 6; i++) {
			pageStr += '<li><a href="#1">' + i + '</a></li>';
		}
		pageStr += '<li class="disabled"><span>...</span></li>';
	} else if (currentPage >= pageCount - 4) {
		pageStr += '<li class="disabled"><span>...</span></li>';
		for (var i = pageCount - 6; i < pageCount; i++) {
			pageStr += '<li><a href="#1">' + i + '</a></li>';
		}
	} else {
		pageStr += '<li class="disabled"><span>...</span></li>';
		for (var i = currentPage - 3; i < currentPage + 3; i++) {
			pageStr += '<li><a href="#1">' + i + '</a></li>';
		}
		pageStr += '<li class="disabled"><span>...</span></li>';
	}
	pageStr += '<li><a href="#">' + pageCount +'</a></li>'; //显示最后1页

	return pageStr;
};

/**
 * 加载所有记录
 *
 * @param {[]} headers 头部信息
 * @param {[]} rows 记录信息
 * @param {[]} options 可用的选项
 * @returns {[]}
 */
var showRows = function(headers, rows, options) {
	// 绑定头信息
	var hArr = [];
	var containerList = $("#index-headers");
	for (var i = 0; i < headers.length; i++) {
		var key = Object.keys(headers[i])[0];
		var tr = "<th>" + headers[i][key] + "</th>";
		containerList.append(tr);
		hArr.push(key);
	}
	if (options.delete || options.update) { 
		containerList.append("<th width='120'>操作</th>");
	}

	var rowCallback = null; //行调用函数
	if (arguments.length > 3) {  
		rowCallback = arguments[3];
	}
	var containerRows = $("#index-rows");
	//<tr>
	//    <td><label class="lyear-checkbox checkbox-primary"><input type="checkbox" name="ids[]" value="1"><span></span></label></td>
	//</tr>
	for (var i = 0; i < rows.length; i++) {
		var tr = "<tr>";
		for (var j = 0; j < hArr.length; j++) {
			var width = "";
			var key = hArr[j];
			var value = rows[i][key];
			if (j === 0) {
				width = " width='100'";
				tr += "<td><label class=\"lyear-checkbox checkbox-primary\"><input type=\"checkbox\" name=\"ids[]\" value=\"" + value + "\"><span></span></label></td>";
				tr += "<td" + width + ">" +  value + "</td>";
				continue;
			}
			if (key === "updated" || key === "created" || key === "last_login" || key === "period_start" || key === "period_end") {
				if (value === 0) { 
					value = "";
					width = " width='100'";
				} else { 
					value = getDateYmdHi(value);
					width = " width='160'";
				}
			}
			if (key === "sort") {
				width = " width='100'";
			}
			if (key === "status") {
				var cla = (value === 1 ? "text-success" : "text-danger");
				var text = (value === 1 ? '正常' : '禁用');
				value = "<span class='" + cla + "'>" + text + "</span>";
			}
			tr += "<td" + width + ">" + (rowCallback === null ? value : rowCallback(key, value)) + "</td>";
		}
		if (options.delete || options.update) { 
			tr += "<td>";
			if (options.update) { 
				tr += "<a href='#' class='action-update'>修改</a>";
				if (options.delete) {
						tr += " &nbsp; &nbsp";
				}
			}
			if (options.delete) {
				tr += "<a href='#' class='action-delete'>删除</a>";
			}
			tr += "</td>";
		}
		tr += "</tr>";
		containerRows.append(tr);
	}
	return hArr;
};

// 弹出消息框
var showMsg = function(message, type, title) {
	var callback = null;
	if (arguments.length > 3) {
		callback = arguments[3];
	}
	var closeDialog = function() {
		$("#form-content")[0].reset();
		$("#action-close").trigger("click");
		return true
	};
	$.alert({
		title: title,
		content: message,
		type: type,
		typeAnimated: false,
		buttons: {
			close: {
				text: '关 闭',
				btnClass: 'btn-' + type,
				action: function () {
					if (type === 'green' && closeDialog()) {
						if (callback !== null) {
							setTimeout(callback, 500);
						}
					}
				}
			}
		}
	});
};
// 操作成功
var alertSuccess = function(message) {
	if (arguments.length > 1) {
		showMsg(message, 'green', '成功', arguments[1]);
		return
	}
	showMsg(message, 'green', '成功');
};
// 操作失败
var alertErr = function(message) {
	showMsg(message, 'red', '错误');
};
