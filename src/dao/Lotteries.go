package dao

import "common"

/// 彩种标签
var Lotteries = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "lotteries",
	},
}
