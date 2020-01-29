package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 平台标识
var SiteConfigs = struct {
	*common.Backend
}{
	Backend: &common.Backend{
		Model: dao.SiteConfigs,
		Headers: []map[string]string{
			{"id": "编号"},
			{"platform_id": "平台名称"},
			{"site_id": "网站名称"},
			{"name": "配置名称"},
			{"value": "配置项值"},
			{"remark": "备注"},
			{"sort": "排序"},
			{"status": "状态"},
			{"created": "添加时间"},
			{"updated": "修改时间"},
		},
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Rows: func() interface{} {
			return &[]models.SiteConfigsRow{}
		},
		Row: func() interface{} {
			return &models.SiteConfigs{}
		},
		Validator: validations.SiteConfigs,
		QueryCond: map[string]interface{}{
			"platform_id": "=",
			"site_id":     "=",
			"name":        "%",
			"status":      "=",
			"value":       "%",
			"remark":      "%",
			"created":     "[]",
		},
	},
}
