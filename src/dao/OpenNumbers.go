package dao

import "common"

var OpenNumbers = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "open_numbers",
	},
}
