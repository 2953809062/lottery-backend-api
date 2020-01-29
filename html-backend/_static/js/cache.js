// 缓存控制
var caches = {
	apiUrl: "http://127.0.0.1:8801/v1/",
	platforms: null,
	sites: null,
	userRoles: null,
	userLevels: null,
	adminRoles: null,
	logTypes: null,
	logLevels: null,
	provinces: null,
	gameCategories: null,
	helpCategories: null,
	lotteryTags: null,
	lotteryCategories: null,
	playGroups: null,
	playTypes: null,
	lotteries: null,
	plays: null
};

/**
 * 通用url调用
 */
caches.apiUrls = {
	"platforms":	"platforms/all",
	"sites":		"sites/all",
	"adminRoles":	"admin_roles/all",
	"userRoles":	"user_roles/all",
	"userLevels":	"user_levels/all",
	"logLevels":	"conf/log_levels",
	"logTypes":		"conf/log_types",
	"provinces":	"provinces/all",
	"gameCategories": "game_categories/all",
	"helpCategories": "help_categories/all",
	"lotteryTags":  "lottery_tags/all",
	"lotteryCategories": "lottery_categories/all",
	"lotteries":	"lotteries/all",
	"playGroups":	"play_groups/all",
	"playTypes":	"play_types/all",
	"plays":		"plays/all"
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

caches.getFromStorage = function(key, callback) { 
	var val = window.localStorage.getItem(key);
	if (!val || val === "") { 
		val = callback();
		window.localStorage.setItem(key, val);
	}
	return val;
};

/**
 * 加载本地配置的缓存项
 */
caches.loadCaches = function(key, callback) { 
	if (!caches[key]) {
		caches[key] = JSON.parse(caches.getFromStorage(key, function() {
			var objects = {};
			layui.jquery.ajax({
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
caches.game_category_id = function(id) { 
	caches.loadCaches("gameCategories", caches.apiCallbacks.idNames);
	return caches.gameCategories[id];
};
caches.lottery_category_id = function(id) { 
	caches.loadCaches("lotteryCategories", caches.apiCallbacks.idNames);
	return caches.lotteryCategories[id];
};
caches.help_category_id = function(id) { 
	caches.loadCaches("helpCategories", caches.apiCallbacks.idNames);
	return caches.helpCategories[id];
};
caches.lottery_id = function(id) { 
	caches.loadCaches("lotteries", caches.apiCallbacks.idNames);
	return caches.lotteries[id];
};
caches.play_group_id = function(id) { 
	caches.loadCaches("playGroups", caches.apiCallbacks.idNames);
	return caches.playGroups[id];
};
caches.play_type_id = function(id) { 
	caches.loadCaches("playTypes", caches.apiCallbacks.idNames);
	return caches.playTypes[id];
};
caches.play_id = function(id) { 
	caches.loadCaches("plays", caches.apiCallbacks.idNames);
	return caches.plays[id];
};
caches.tag_id = function(id) { 
	caches.loadCaches("lotteryTags", caches.apiCallbacks.idNames);
	return caches.lotteryTags[id];
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
	var element = layui.jquery("#" + key);
	var keys  = Object.keys(obj);
	for (var i = 0; i < keys.length; i++) {
		element.append(new Option(obj[keys[i]], keys[i]));
	}
};

