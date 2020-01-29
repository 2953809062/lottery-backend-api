package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 开奖奖期
var OpenPeriods = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.OpenPeriods,
		Headers: []map[string]string{
			{"id": "编号"},
			{"lottery_id": "彩种"},
			{"period_number": "奖期"},
			{"time_close": "封盘时间"},
			{"time_open": "开奖时间"},
			{"day_offset": "天数编移"},
			{"is_begin": "是否首期"},
			{"is_end": "是否末期"},
			{"is_opened": "是否开奖"},
			{"sort": "排序"},
		},
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Rows: func() interface{} {
			return &[]models.OpenPeriods{}
		},
		Row: func() interface{} {
			return &models.OpenPeriods{}
		},
		Validator: validations.OpenPeriods,
	},
}
