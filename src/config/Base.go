package config

// PlatformUrls 所有可被允许的访问的域名
var PlatformUrls map[string]string

// GameTypes 游戏类型
var GameTypes = map[uint8]string{
	1: "彩票",
	2: "棋牌",
}

// LogTypes 日志类型: 0:普通操作 1:登录退出 2:权限相关 3:财务相关 4:内容相关 9:其他类型
var LogTypes = map[uint8]string{
	0: "普通操作",
	1: "退出登录",
	2: "权限相关",
	3: "财务相关",
	4: "内容相关",
	9: "其他类型",
}

// LogLevels 日志级别: 0:普通 1:重要 2:警告, 3:致命 4:错误 5:特殊 9:其他
var LogLevels = map[uint8]string{
	0: "普通",
	1: "重要",
	2: "警告",
	3: "致命",
	4: "错误",
	5: "特殊",
	9: "其他",
}
