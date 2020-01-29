package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 用户层级
var UserLevels = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.UserLevels,
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
			return &[]models.UserLevelsRow{}
		},
		Row: func() interface{} {
			return &models.UserLevels{}
		},
		Validator: validations.UserLevels,
	},
}
