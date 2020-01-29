package log

/// 日志类型
const (
	TypeNormal     = 0
	TypeLogin      = 1
	TypePermission = 2
	TypeFinance    = 3
	TypeContent    = 4
	TypeOther      = 9
)

/// 日志级别
const (
	LevelNormal    = 0
	LevelImportant = 1
	LevelWarn      = 2
	LevelFault     = 3
	LevelError     = 4
	LevelSpecial   = 5
	LevelOther     = 9
)
