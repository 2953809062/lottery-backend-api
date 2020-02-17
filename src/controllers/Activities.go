package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

// Activities - 活动
var Activities = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.Activities,
		Headers: []map[string]string{
			{"id": "编号"},
			{"title": "公告标题"},
			{"sort": "排序"},
			{"status": "状态"},
			{"period_start": "开始时间"},
			{"period_end": "结束时间"},
			{"created": "添加时间"},
			{"updated": "最后修改"},
		},
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Rows: func() interface{} {
			return &[]models.ActivitiesRow{}
		},
		Row: func() interface{} {
			return &models.Activities{}
		},
		Validator: validations.Activities,
	},
}
