package dao

import "common"

/// 用户提现
var UserWithdraws = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "user_withdraws",
	},
}
