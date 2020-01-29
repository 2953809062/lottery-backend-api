package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 平台标识
var Sites = struct {
	*common.Backend
}{
	Backend: &common.Backend{
		Model: dao.Sites,
		Headers: []map[string]string{
			{"id": "编号"},
			{"platform_id": "平台名称"},
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
			return &[]models.SitesRow{}
		},
		Row: func() interface{} {
			return &models.Sites{}
		},
		Validator: validations.Sites,
		QueryCond: map[string]interface{}{
			"platform_id": "=",
			"name":        "%",
			"remark":      "%",
			"status":      "=",
			"created":     "[]",
		},
	},
}
