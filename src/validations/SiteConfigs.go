package validations

import (
	"common/validation"
)

/// 平台
var SiteConfigs = func(data map[string]interface{}) error {
	return validation.New(data).
		Field("platform_id").Uint("平台编号无效").
		Field("site_id").Uint("网站编号无效").
		Field("name").Length(2, 20, "必须输入平台名称").
		Field("sort").Numeric("排序必须是有效的数字").
		Field("status").State("状态无效").
		Field("remark").Null().Length(2, 40, "备注必须在有效的区间范围内").
		Validate()
}
