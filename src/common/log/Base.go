package log

import (
	"fmt"
	"runtime"
	"runtime/debug"
)

/// 输入调试信息
func Debug(info string, args ...interface{}) {
	fmt.Printf(info, args...)
}

/// 输入错误信息
func Err(info string, args ...interface{}) {
	fmt.Printf(info, args...)
	if funcName, file, line, ok := runtime.Caller(1); ok {
		fmt.Printf("|-- 函数: %s\n", runtime.FuncForPC(funcName).Name())
		fmt.Printf("|-- 文件: %s\n|-- 行数: %d\n", file, line)
	}
	debug.PrintStack()
}
