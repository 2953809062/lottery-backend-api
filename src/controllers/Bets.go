package controllers

import (
	"common"
	"dao"
	"models"
)

/// 注单
var Bets = struct {
	*common.Backend //基类
}{
	Backend: &common.Backend{
		Model: dao.Bets,
		Headers: []map[string]string{
			{"id": "编号"},
			{"order_num": "订单编号"},
			{"user_name": "用户名称"},
			{"lottery_id": "排序"},
			{"play_group_id": "玩法分类"},
			{"play_type_id": "玩法子类"},
			{"play_id": "玩法"},
			{"bet_numbers": "投注号码"},
			{"bet_amount": "投注金额"},
			{"bet_count": "注单数量"},
			{"bet_time": "投注时间"},
			{"prize": "可中金额"},
			{"status": "状态"},
			{"open_number": "开奖号码"},
			{"prized": "已中金额"},
			{"prized_count": "已中注数"},
		},
		Rows: func() interface{} {
			return &[]struct {
				Id          uint32  `json:"id"`
				LotteryId   uint32  `json:"lottery_id"`
				OrderNum    string  `json:"order_num"`
				UserName    string  `json:"user_name"`
				PlayGroupId uint32  `json:"play_group_id"`
				PlayTypeId  uint32  `json:"play_type_id"`
				BetNumbers  string  `json:"bet_numbers"`
				PlayId      uint32  `json:"play_id"`
				BetAmount   float32 `json:"bet_amount"`
				BetCount    uint32  `json:"bet_count"`
				BetTime     uint32  `json:"bet_time"`
				Status      uint8   `json:"status"`
				OpenNumber  string  `json:"open_number"`
				Prize       float32 `json:"prize"`
				Prized      float32 `json:"prized"`
				PrizedCount uint32  `json:"prized_count"`
			}{}
		},
		Row: func() interface{} {
			return &models.Bets{}
		},
		QueryCond: map[string]interface{}{
			"status":    "=",
			"user_name": "%",
		},
	},
}
