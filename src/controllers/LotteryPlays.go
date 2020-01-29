package controllers

import (
	"common"
	"dao"
	"models"
)

/// 彩种玩法
var LotteryPlays = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.LotteryPlays,
		Headers: []map[string]string{
			{"id": "编号"},
			{"category_id": "彩种分类"},
			{"play_group_id": "玩法总类"},
			{"play_type_id": "玩法子类"},
			{"play_id": "玩法"},
			{"lottery_id": "彩种"},
			{"odds": "赔率"},
			{"remark": "备注"},
		},
		Rows: func() interface{} {
			return &[]models.LotteryPlays{}
		},
		OptionAll:    true,
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Row: func() interface{} {
			return &models.LotteryPlays{}
		},
		//Validator: validations.LotteryPlays,
	},
}
