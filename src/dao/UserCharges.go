package dao

import "common"

var UserCharges = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "user_charges",
	},
}
