package dao

import "common"

/// 银行
var Banks = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "banks",
	},
}
