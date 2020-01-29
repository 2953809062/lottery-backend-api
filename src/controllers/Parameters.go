package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 参数
var Parameters = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.Configs,
		Headers: []map[string]string{
			{"id": "编号"},
			{"name": "配置名称"},
			{"value": "配置项值"},
			{"remark": "备注"},
			{"status": "状态"},
			{"sort": "排序"},
			{"created": "添加时间"},
		},
		OptionAll:    true,
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Rows: func() interface{} {
			return &[]models.Configs{}
		},
		Row: func() interface{} {
			return &models.Configs{}
		},
		Validator: validations.Configs,
		QueryCond: map[string]interface{}{
			"name":    "%",
			"value":   "%",
			"remark":  "%",
			"status":  "=",
			"created": "[]",
		},
	},
}
