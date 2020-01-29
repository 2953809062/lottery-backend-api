package dao

import "common"

/// 玩法
var PlayTypes = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "play_types",
	},
}
