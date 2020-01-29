package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 银行
var Banks = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.Banks,
		Headers: []map[string]string{
			{"id": "编号"},
			{"name": "名称"},
			{"sort": "排序"},
			{"status": "状态"},
			{"remark": "备注"},
		},
		OptionAll:    true,
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Rows: func() interface{} {
			return &[]models.Banks{}
		},
		Row: func() interface{} {
			return &models.Banks{}
		},
		Validator: validations.Banks,
		QueryCond: map[string]interface{}{
			"status": "=",
			"name":   "%",
			"remark": "%",
		},
	},
}
