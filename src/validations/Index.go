package validations

import "common/validation"

/// 登录
var Index = func(data map[string]interface{}) error {
	return validation.New(data).
		Field("name").Length(2, 20, "必须输入用户名称").
		Field("password").Length(6, 20, "必须输入用户密码").
		Validate()
}
