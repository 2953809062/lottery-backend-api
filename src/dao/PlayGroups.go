package dao

import "common"

/// 玩法总类
var PlayGroups = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "play_groups",
	},
}
