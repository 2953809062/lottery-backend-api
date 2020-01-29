package dao

import "common"

var OpenTimes = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "open_times",
	},
}
