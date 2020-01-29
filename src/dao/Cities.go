package dao

import "common"

/// 城市
var Cities = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "cities",
	},
}
