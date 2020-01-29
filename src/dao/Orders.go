package dao

import "common"

/// 订单
var Orders = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "orders",
	},
}
