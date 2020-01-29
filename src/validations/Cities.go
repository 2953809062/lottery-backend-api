package validations

import "common/validation"

/// 城市
var Cities = func(data map[string]interface{}) error {
	return validation.New(data).
		Field("name").Length(2, 20, "必须输入名称").
		Field("province_id").Length(2, 20, "必须输入省份编码").
		Field("remark").Null().Length(2, 40, "备注必须在有效的区间范围内").
		Validate()
}
