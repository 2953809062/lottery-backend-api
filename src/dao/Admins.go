package dao

import "common"

var Admins = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "admins",
	},
}
