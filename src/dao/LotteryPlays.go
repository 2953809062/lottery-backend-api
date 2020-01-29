package dao

import "common"

/// 彩种玩法
var LotteryPlays = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "lottery_plays",
	},
}
