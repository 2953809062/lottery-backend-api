package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 玩法说明
var PlayNotes = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.PlayNotes,
		Headers: []map[string]string{
			{"id": "编号"},
			{"lottery_id": "彩种"},
			{"title": "备注"},
			{"sort": "排序"},
			{"status": "状态"},
			{"created": "添加时间"},
			{"updated": "修改时间"},
		},
		OptionAll:    true,
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Rows: func() interface{} {
			return &[]models.PlayNotesRow{}
		},
		Row: func() interface{} {
			return &models.PlayNotes{}
		},
		Validator: validations.PlayNotes,
		QueryCond: map[string]interface{}{
			"name":    "%",
			"remark":  "%",
			"status":  "=",
			"created": "[]",
		},
	},
}
