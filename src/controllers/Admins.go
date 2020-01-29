package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 后台用户
var Admins = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.Admins,
		Headers: []map[string]string{
			{"id": "编号"},
			{"name": "用户名称"},
			{"admin_role_id": "角色"},
			{"login_count": "登录次数"},
			{"last_login": "最后登录时间"},
			{"last_ip": "最后登录IP"},
			{"last_region": "最后登录地区"},
			{"status": "状态"},
			{"sort": "排序"},
			{"created": "添加时间"},
			{"updated": "修改时间"},
		},
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Rows: func() interface{} {
			return &[]models.AdminsRow{}
		},
		Row: func() interface{} {
			return &models.Admins{}
		},
		Validator: validations.Admins,
	},
}
