package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 帮助列表
var Helps = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.Helps,
		Headers: []map[string]string{
			{"id": "编号"},
			{"help_category_id": "帮助分类"},
			{"title": "公告标题"},
			{"sort": "排序"},
			{"status": "状态"},
			{"created": "添加时间"},
			{"updated": "最后修改"},
		},
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Rows: func() interface{} {
			return &[]models.HelpsRow{}
		},
		Row: func() interface{} {
			return &models.Helps{}
		},
		Validator: validations.Helps,
	},
}
