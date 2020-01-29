package dao

import (
	"common"
)

var AdminLoginLogs = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "admin_login_logs",
	},
}
