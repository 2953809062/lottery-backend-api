package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 彩种分类
var LotteryCategories = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.LotteryCategories,
		Headers: []map[string]string{
			{"id": "编号"},
			{"name": "分类名称"},
			{"remark": "备注"},
		},
		Rows: func() interface{} {
			return &[]models.LotteryCategories{}
		},
		OptionAll:    true,
		OptionCreate: true,
		OptionUpdate: true,
		OptionDelete: true,
		Row: func() interface{} {
			return &models.LotteryCategories{}
		},
		Validator: validations.LotteryCategories,
	},
}
