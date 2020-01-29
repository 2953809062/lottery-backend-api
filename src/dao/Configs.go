package dao

import "common"

/// 配置
var Configs = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "configs",
	},
}
