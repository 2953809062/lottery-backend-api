package controllers

import (
	"common"
	"dao"
	"models"
)

/// 订单
var Orders = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.Orders,
		Headers: []map[string]string{
			{"id": "编号"},
			{"user_id": "用户编号"},
			{"user_name": "用户名称"},
			{"order_num": "订单号码"},
			{"quantity": "注单数量"},
			{"amount": "订单金额"},
			{"status": "状态"},
			{"created": "下单时间"},
		},
		Rows: func() interface{} {
			return &[]struct {
				Id       uint32  `json:"id"`
				UserId   uint32  `json:"user_id"`
				UserName string  `json:"user_name"`
				Quantity uint32  `json:"quantity"`
				Amount   float32 `json:"amount"`
				OrderNum string  `json:"order_num"`
				Created  uint32  `json:"created"`
				Status   uint8   `json:"status"`
			}{}
		},
		Row: func() interface{} {
			return &models.Banks{}
		},
		QueryCond: map[string]interface{}{
			"status": "=",
			"name":   "%",
			"remark": "%",
		},
	},
}
