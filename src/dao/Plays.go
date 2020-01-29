package dao

import "common"

/// 玩法
var Plays = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "plays",
	},
}
