package dao

import "common"

var Users = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "users",
	},
}
