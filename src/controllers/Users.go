package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 后台用户
var Users = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.Users,
		Headers: []map[string]string{
			{"id": "编号"},
			{"name": "用户名称"},
			{"nickname": "用户昵称"},
			{"user_role_id": "角色"},
			{"user_level_id": "层级"},
			{"last_login": "最后登录时间"},
			{"last_ip": "最后登录IP"},
			{"last_region": "最后登录地区"},
			{"login_count": "登录次数"},
			{"status": "状态"},
			{"sort": "排序"},
			{"created": "注册时间"},
			{"updated": "最后修改"},
		},
		OptionCreate: true,
		OptionUpdate: true,
		Rows: func() interface{} {
			return &[]models.UsersRow{}
		},
		Row: func() interface{} {
			return &models.Users{}
		},
		Validator: validations.Users,
		QueryCond: map[string]interface{}{
			"name":        "%",
			"nickname":    "%",
			"role_id":     "=",
			"level_id":    "=",
			"status":      "=",
			"last_region": "%",
			"last_ip":     "%",
			"last_login":  "[]",
		},
	},
}
