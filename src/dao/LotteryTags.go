package dao

import "common"

/// 彩种标签
var LotteryTags = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "lottery_tags",
	},
}
