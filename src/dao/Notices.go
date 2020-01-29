package dao

import "common"

var Notices = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "notices",
	},
}
