package dao

import "common"

/// 用户绑卡
var UserCards = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "user_cards",
	},
}
