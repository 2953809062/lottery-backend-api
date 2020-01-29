package dao

import (
	"common"
)

/// 站点配置
var SiteConfigs = struct {
	*common.Model
}{
	Model: &common.Model{
		TableName: "site_configs",
	},
}
