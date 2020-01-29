package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 开奖号码
var OpenNumbers = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.OpenNumbers,
		Headers: []map[string]string{
			{"id": "编号"},
			{"lottery_id": "彩种"},
			{"period_number": "奖期"},
			{"numbers": "开奖号码"},
			{"open_time": "开奖时间"},
			{"is_finished": "是否完成"},
			{"sort": "排序"},
			{"created": "添加时间"},
			{"updated": "最后修改"},
		},
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Rows: func() interface{} {
			return &[]models.OpenNumbers{}
		},
		Row: func() interface{} {
			return &models.OpenNumbers{}
		},
		Validator: validations.OpenNumbers,
	},
}
