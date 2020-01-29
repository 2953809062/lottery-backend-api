package dao

import "common"

var UserRoles = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "user_roles",
	},
}
