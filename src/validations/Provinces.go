package validations

import "common/validation"

/// 省份
var Provinces = func(data map[string]interface{}) error {
	return validation.New(data).
		Field("name").Length(2, 20, "必须输入名称").
		Field("remark").Null().Length(2, 40, "备注必须在有效的区间范围内").
		Validate()
}
