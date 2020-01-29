package validations

import "common/validation"

/// 玩法子类
var PlayTypes = func(data map[string]interface{}) error {
	return validation.New(data).
		Field("name").Length(2, 20, "必须输入角色名称").
		Field("remark").Null().Length(2, 40, "备注必须在有效的区间范围内").
		Validate()
}
