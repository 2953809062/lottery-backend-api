package dao

import (
	"common"
)

var AdminLogs = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "admin_logs",
	},
}
