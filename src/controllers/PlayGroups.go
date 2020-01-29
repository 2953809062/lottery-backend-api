package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 玩法总类
var PlayGroups = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.PlayGroups,
		Headers: []map[string]string{
			{"id": "编号"},
			{"lottery_category_id": "彩种分类"},
			{"name": "名称"},
			{"remark": "备注"},
		},
		OptionAll:    true,
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Rows: func() interface{} {
			return &[]models.PlayGroups{}
		},
		Row: func() interface{} {
			return &models.PlayGroups{}
		},
		Validator: validations.PlayGrops,
		QueryCond: map[string]interface{}{
			"name":    "%",
			"remark":  "%",
			"status":  "=",
			"created": "[]",
		},
	},
}
