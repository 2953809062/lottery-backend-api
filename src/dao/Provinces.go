package dao

import "common"

/// 省份
var Provinces = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "provinces",
	},
}
