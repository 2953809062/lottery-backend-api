package dao

import (
	"common"
)

/// 网站站点
var Sites = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "sites",
	},
}
