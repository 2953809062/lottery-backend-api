package controllers

import (
	"common"
	"dao"
	"models"
	"validations"
)

/// 彩种
var Lotteries = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.Lotteries,
		Headers: []map[string]string{
			{"id": "编号"},
			{"lottery_category_id": "彩种分类"},
			{"tag_id": "标签"},
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
			return &[]struct {
				Id         uint32 `json:"id"`
				CategoryId uint32 `json:"lottery_category_id"`
				TagId      uint32 `json:"tag_id"`
				Sort       int32  `json:"sort"`
				Name       string `json:"name"`
				Remark     string `json:"remark"`
				Status     uint8  `json:"status"`
			}{}
		},
		Row: func() interface{} {
			return &models.Lotteries{}
		},
		Validator: validations.Lotteries,
		QueryCond: map[string]interface{}{
			"name":    "%",
			"remark":  "%",
			"status":  "=",
			"created": "[]",
		},
	},
}
