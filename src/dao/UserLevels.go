package dao

import "common"

var UserLevels = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "user_levels",
	},
}
