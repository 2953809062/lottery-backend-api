package dao

import "common"

/// 投注记录
var Bets = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "bets",
	},
}
