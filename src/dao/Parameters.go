package dao

import "common"

/// 配置
var Parameters = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "configs",
	},
}
