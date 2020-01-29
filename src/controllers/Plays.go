package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 玩法
var Plays = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.Plays,
		Headers: []map[string]string{
			{"id": "编号"},
			{"lottery_category_id": "彩种分类"},
			{"play_group_id": "玩法总类"},
			{"play_type_id": "玩法子类"},
			{"name": "玩法名称"},
			{"odds": "赔率"},
			{"remark": "备注"},
		},
		OptionAll:    true,
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Rows: func() interface{} {
			return &[]models.Plays{}
		},
		Row: func() interface{} {
			return &models.Plays{}
		},
		Validator: validations.Plays,
		QueryCond: map[string]interface{}{
			"name":    "%",
			"remark":  "%",
			"status":  "=",
			"created": "[]",
		},
	},
}
