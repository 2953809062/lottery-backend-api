package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 游戏分类
var GameCategories = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.GameCategories,
		Headers: []map[string]string{
			{"id": "编号"},
			{"name": "分类名称"},
			{"remark": "备注"},
		},
		Rows: func() interface{} {
			return &[]models.GameCategories{}
		},
		OptionAll:    true,
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Row: func() interface{} {
			return &models.GameCategories{}
		},
		Validator: validations.GameCategories,
	},
}
