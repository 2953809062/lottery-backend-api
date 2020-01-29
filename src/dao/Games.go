package dao

import "common"

/// 游戏
var Games = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "games",
	},
}
