package validations

import "common/validation"

/// 帮助
var Helps = func(data map[string]interface{}) error {
	return validation.New(data).
		Field("name").Length(2, 20, "必须输入平台名称").
		Field("remark").Null().Length(2, 40, "备注必须在有效的区间范围内").
		Validate()
}
