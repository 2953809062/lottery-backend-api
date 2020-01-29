package controllers

import (
	"common"
	"dao"
	"models"
)

/// 平台标识
var AdminLogs = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.AdminLogs,
		Headers: []map[string]string{
			{"id": "编号"},
			{"admin_name": "后台用户"},
			{"log_level": "日志级别"},
			{"log_type": "日志类型"},
			{"url": "操作地址"},
			{"remark": "备注"},
			{"created": "添加时间"},
		},
		Rows: func() interface{} {
			return &[]models.AdminLogsRow{}
		},
		Row: func() interface{} {
			return &models.AdminLogs{}
		},
	},
}
