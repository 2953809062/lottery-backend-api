package dao

import "common"

var OpenPeriods = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "open_periods",
	},
}
