package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 彩种标签
var LotteryTags = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.LotteryTags,
		Headers: []map[string]string{
			{"id": "编号"},
			{"name": "分类名称"},
			{"remark": "备注"},
		},
		Rows: func() interface{} {
			return &[]models.LotteryTags{}
		},
		OptionAll:    true,
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Row: func() interface{} {
			return &models.LotteryTags{}
		},
		Validator: validations.LotteryTags,
	},
}
