package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 游戏
var Games = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.Games,
		Headers: []map[string]string{
			{"id": "编号"},
			{"game_category_id": "游戏分类"},
			{"name": "游戏名称"},
			{"status": "状态"},
			{"remark": "备注"},
			{"created": "添加时间"},
			{"updated": "修改时间"},
		},
		OptionAll:    true,
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Rows: func() interface{} {
			return &[]models.Games{}
		},
		Row: func() interface{} {
			return &models.Games{}
		},
		Validator: validations.Games,
		QueryCond: map[string]interface{}{
			"category_id": "=",
			"name":        "%",
			"remark":      "%",
			"status":      "=",
			"created":     "[]",
		},
	},
}
