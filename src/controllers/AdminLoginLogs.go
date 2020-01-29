package controllers

import (
	"common"
	"dao"
	"models"
)

/// 管理员登录日志
var AdminLoginLogs = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.AdminLoginLogs,
		Headers: []map[string]string{
			{"id": "编号"},
			{"admin_name": "后台用户"},
			{"ip": "登录IP"},
			{"region": "登录地区"},
			{"url": "地址"},
			{"remark": "备注"},
			{"created": "添加时间"},
		},
		Rows: func() interface{} {
			return &[]models.AdminLoginLogs{}
		},
	},
}
