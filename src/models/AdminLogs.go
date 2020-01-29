package models

/// 后台用户日志
type AdminLogs struct {
	Id        uint64 `json:"id"`         //编号
	AdminId   uint64 `json:"admin_id"`   //后台用户编号
	Level     uint16 `json:"level"`      //日志级别
	Type      uint16 `json:"type"`       //日志类型
	Created   uint32 `json:"created"`    //添加时间
	AdminName string `json:"admin_name"` //后台用户名称
	Url       string `json:"url"`        //操作url
	Remark    string `json:"remark"`     //操作备注
}

/// rows
type AdminLogsRow struct {
	Id        uint64 `json:"id"`
	AdminName string `json:"admin_name"`
	Level     uint16 `json:"log_level"`
	Type      uint16 `json:"log_type"`
	Created   uint32 `json:"created"`
	Url       string `json:"url"`
	Remark    string `json:"remark"`
}
