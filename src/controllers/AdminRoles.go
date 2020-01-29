package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 后台用户
var AdminRoles = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.AdminRoles,
		Headers: []map[string]string{
			{"id": "编号"},
			{"name": "用户名称"},
			{"remark": "备注"},
		},
		OptionAll:    true,
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Rows: func() interface{} {
			return &[]models.AdminRolesRow{}
		},
		Row: func() interface{} {
			return &models.AdminRoles{}
		},
		Validator: validations.AdminRoles,
	},
}
