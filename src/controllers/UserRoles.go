package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 用户角色
var UserRoles = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.UserRoles,
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
			return &[]models.UserRolesRow{}
		},
		Row: func() interface{} {
			return &models.UserRoles{}
		},
		Validator: validations.UserRoles,
	},
}
