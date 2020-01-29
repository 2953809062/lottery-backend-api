package models

/// 后台用户登录日志
type AdminLoginLogs struct {
	Id        uint64 `json:"id"`         //编号
	AdminId   uint64 `json:"admin_id"`   //后台用户编号
	Created   uint32 `json:"created"`    //添加时间
	Ip        string `json:"ip"`         //ip
	Url       string `json:"url"`        //url
	Region    string `json:"region"`     //地区
	AdminName string `json:"admin_name"` //后台用户名称
	Remark    string `json:"remark"`     //操作备注
}
