package validations

import "common/validation"

/// 平台
var Admins = func(data map[string]interface{}) error {
	return validation.New(data).
		Field("name").Length(2, 20, "必须输入平台名称").
		Field("sort").Numeric("排序必须是有效的数字").
		Field("status").State("状态无效").
		Validate()
}
