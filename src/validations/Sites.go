package validations

import (
	"common/validation"
)

/// 平台
var Sites = func(data map[string]interface{}) error {
	return validation.New(data).
		Field("name").Length(2, 20, "必须输入平台名称").
		Field("platform_id").Uint("平台编号无效").
		Field("sort").Numeric("排序必须是有效的数字").
		Field("status").State("状态无效").
		Field("remark").Null().Length(2, 40, "备注必须在有效的区间范围内").
		Field("urls").Null().Length(2, 300, "请输入网站域名").
		Field("api").Null().Length(2, 100, "无效的API地址").
		Field("admin_url").Null().Length(2, 100, "无效的后台管理地址").
		Field("admin_api").Null().Length(2, 100, "无效的后台API地址").
		Validate()
}
