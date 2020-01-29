package dao

import "common"

var AdminRoles = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "admin_roles",
	},
}
