package dao

import "common"

/// 帮助
var Helps = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "helps",
	},
}
