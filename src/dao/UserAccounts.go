package dao

import "common"

var UserAccounts = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "user_accounts",
	},
}
