package validation

import (
	"common/log"
	"errors"
	"fmt"
	"strconv"
	"strings"
)

/// 校验器
type Validator struct {
	Data      map[string]interface{} //要校验的字段
	Errors    []string               //错误信息
	FieldName string                 //当前字段
	Required  bool                   //当前字段是否允许为空
}

/// 生成校验器
func New(postedData map[string]interface{}) *Validator {
	return &Validator{
		Data: postedData,
	}
}

/// 当前字段是否允许为空值
func (ths *Validator) Null(args ...bool) *Validator {
	argCount := len(args)
	if argCount >= 1 {
		ths.Required = args[0]
	} else {
		ths.Required = false //默认不允许为空值
	}
	return ths
}

/// 设置当前的字段名称
func (ths *Validator) Field(name string) *Validator {
	ths.FieldName = name
	return ths
}

/// 追加错误信息
func (ths *Validator) AppendError(message string) *Validator {
	ths.Errors = append(ths.Errors, message)
	return ths
}

/// 检测各个字段
func (ths *Validator) Check(message string, callback func(interface{}) error) *Validator {
	val, exists := ths.Data[ths.FieldName]
	if !exists {
		if !ths.Required {
			return ths
		} else {
			return ths.AppendError(message)
		}
	} else {
		if err := callback(val); err != nil {
			log.Err("格式化时出错: %v, Field: %v, Data: %v\n", err, ths.FieldName, ths.Data)
			ths.AppendError(message)
		}
	}
	return ths
}

/// 字段长度必须介于二者之间
func (ths *Validator) Length(min int, max int, message string) *Validator {
	return ths.Check(message, func(val interface{}) error {
		length := len([]rune(val.(string)))
		if !ths.Required && length == 0 { //如果不是必须,并且长度为0
			return nil
		}
		if length < min || length > max {
			return errors.New("字符串长度不在区间范围之内")
		}
		return nil
	})
}

/// 是数字, 可以为整数, 负数, 小数
func (ths *Validator) Numeric(message string) *Validator {
	return ths.Check(message, func(val interface{}) error {
		_, err := strconv.ParseFloat(fmt.Sprintf("%v", val), 10)
		return err
	})
}

/// 是整数
func (ths *Validator) Int(message string) *Validator {
	return ths.Check(message, func(val interface{}) error {
		_, err := strconv.Atoi(fmt.Sprintf("%v", val))
		return err
	})
}

/// 是正整数-包括零
func (ths *Validator) Uint0(message string) *Validator {
	return ths.Check(message, func(val interface{}) error {
		_, err := strconv.ParseUint(fmt.Sprintf("%v", val), 10, 64)
		return err
	})
}

/// 正整数非零
func (ths *Validator) Uint(message string) *Validator {
	return ths.Check(message, func(val interface{}) error {
		if num, err := strconv.ParseUint(fmt.Sprintf("%v", val), 10, 64); err == nil && num > 0 {
			return nil
		}
		return errors.New("不是非零的正整数")
	})
}

/// 必须是状态值
func (ths *Validator) State(message string) *Validator {
	return ths.Check(message, func(val interface{}) error {
		sta := fmt.Sprintf("%v", val)
		if sta == "1" || sta == "0" {
			return nil
		}
		return errors.New("状态值无效")
	})
}

/// 生成校验结果
func (ths *Validator) Validate() error {
	if len(ths.Errors) == 0 {
		return nil
	}
	return errors.New(strings.Join(ths.Errors, ","))
}
