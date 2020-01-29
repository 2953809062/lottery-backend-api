package dao

import "common"

/// 彩种分类
var LotteryCategories = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "lottery_categories",
	},
}
