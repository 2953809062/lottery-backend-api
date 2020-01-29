package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 玩法子类
var PlayTypes = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.PlayTypes,
		Headers: []map[string]string{
			{"id": "编号"},
			{"lottery_category_id": "彩种分类"},
			{"play_group_id": "玩法总类"},
			{"name": "名称"},
			{"remark": "备注"},
		},
		OptionAll:    true,
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Rows: func() interface{} {
			return &[]models.PlayTypes{}
		},
		Row: func() interface{} {
			return &models.PlayTypes{}
		},
		Validator: validations.PlayTypes,
		QueryCond: map[string]interface{}{
			"name":    "%",
			"remark":  "%",
			"status":  "=",
			"created": "[]",
		},
	},
}
