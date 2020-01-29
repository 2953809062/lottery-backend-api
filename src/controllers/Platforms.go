package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 平台标识
var Platforms = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.Platforms,
		Headers: []map[string]string{
			{"id": "编号"},
			{"name": "名称"},
			{"remark": "备注"},
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
			return &[]models.PlatformsRow{}
		},
		Row: func() interface{} {
			return &models.Platforms{}
		},
		Validator: validations.Platforms,
		QueryCond: map[string]interface{}{
			"name":    "%",
			"remark":  "%",
			"status":  "=",
			"created": "[]",
		},
	},
}
