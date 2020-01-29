package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 帮助分类
var HelpCategories = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.HelpCategories,
		Headers: []map[string]string{
			{"id": "编号"},
			{"name": "分类名称"},
			{"remark": "备注"},
		},
		Rows: func() interface{} {
			return &[]models.HelpCategories{}
		},
		OptionAll:    true,
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Row: func() interface{} {
			return &models.HelpCategories{}
		},
		Validator: validations.HelpCategories,
	},
}
