package dao

import "common"

var Menus = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "menus",
	},
}
