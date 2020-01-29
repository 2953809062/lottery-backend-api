package dao

import "common"

/// 玩法说明
var PlayNotes = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "play_notes",
	},
}
