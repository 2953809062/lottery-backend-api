package models

/// 后台用户
type Admins struct {
	Id         uint64 `json:"id"`          //编号
	RoleId     uint64 `json:"role_id"`     //角色编号
	Sort       int32  `json:"sort"`        //排序
	Status     uint16 `json:"status"`      //状态
	LoginCount uint32 `json:"login_count"` //登录次数
	LastLogin  uint32 `json:"last_login"`  //上次登录时间
	Created    uint32 `json:"created"`     //添加时间
	Updated    uint32 `json:"updated"`     //修改时间
	Name       string `json:"name"`        //管理员名称
	Ips        string `json:"ips"`         //允许登录ip
	Password   string `json:"password"`    //密码
	Secret     string `json:"secret"`      //密串
	LastIp     string `json:"last_ip"`     //最后登录ip
	LastRegion string `json:"last_region"` //最后登录地区
	Remark     string `json:"remark"`      //备注
}

/// rows
type AdminsRow struct {
	Id         uint64 `json:"id"`
	Name       string `json:"name"`
	RoleId     uint64 `json:"admin_role_id"`
	LoginCount uint32 `json:"login_count"`
	LastLogin  uint32 `json:"last_login"`
	Status     uint32 `json:"status"`
	Created    uint32 `json:"created"`
	Updated    uint32 `json:"updated"`
	Sort       int64  `json:"sort"`
	LastIp     string `json:"last_ip"`
	LastRegion string `json:"last_region"`
}
