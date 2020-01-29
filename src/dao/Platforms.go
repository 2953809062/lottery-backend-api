package dao

import (
	"common"
)

/// 平台标识
var Platforms = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "platforms",
	},
}
