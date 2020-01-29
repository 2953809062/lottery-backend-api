package dao

import "common"

var Activities = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "activities",
	},
}
