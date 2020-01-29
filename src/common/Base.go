package common

import (
	"log"
	"reflect"
	"strings"
	"time"
)

/// 当前时间
func Now() int64 {
	return time.Now().Unix()
}

/// 获取结构体中字段的名称
func GetFieldName(structName interface{}) []string {
	t := reflect.TypeOf(structName)
	if t.Kind() == reflect.Ptr {
		t = t.Elem()
	}
	if t.Kind() != reflect.Struct {
		log.Println("Check type error not Struct")
		return nil
	}
	fieldNum := t.NumField()
	result := make([]string, 0, fieldNum)
	for i := 0; i < fieldNum; i++ {
		result = append(result, t.Field(i).Name)
	}
	return result
}

/// 获取结构体中Tag的值，如果没有tag则返回字段值
func GetTagName(structName interface{}) []string {
	t := reflect.TypeOf(structName)
	if t.Kind() == reflect.Ptr {
		t = t.Elem()
	}
	if t.Kind() != reflect.Struct {
		log.Println("Check type error not Struct")
		return nil
	}
	fieldNum := t.NumField()
	result := make([]string, 0, fieldNum)
	for i := 0; i < fieldNum; i++ {
		tagName := t.Field(i).Name
		tags := strings.Split(string(t.Field(i).Tag), "\"")
		if len(tags) > 1 {
			tagName = tags[1]
		}
		result = append(result, tagName)
	}
	return result
}

/// 将结构体转换为map
func Struct2Map(obj interface{}) map[string]interface{} {
	t := reflect.TypeOf(obj) // 获取 obj 的类型信息
	v := reflect.ValueOf(obj)
	if t.Kind() == reflect.Ptr { // 如果是指针，则获取其所指向的元素
		t = t.Elem()
		v = v.Elem()
	}

	var data = make(map[string]interface{})
	if t.Kind() == reflect.Struct { // 只有结构体可以获取其字段信息
		for i := 0; i < t.NumField(); i++ {
			data[t.Field(i).Name] = v.Field(i).Interface()
		}

	}
	return data
}
