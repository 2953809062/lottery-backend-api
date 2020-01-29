package models

/// 用户表
type Users struct {
	Id         uint64 `json:"id"`
	RoleId     uint16 `json:"role_id"`
	LevelId    uint16 `json:"level_id"`
	LastLogin  uint32 `json:"last_login"`
	Status     uint16 `json:"status"`
	Sort       int32  `json:"sort"`
	Created    uint32 `json:"created"`
	Updated    uint32 `json:"updated"`
	LoginCount uint32 `json:"login_count"`
	LastIp     string `json:"last_ip"`
	LastRegion string `json:"last_region"`
	Name       string `json:"name"`
	Password   string `json:"password"`
	Nickname   string `json:"nickname"`
}

/// for controller rows
type UsersRow struct {
	Id         uint64 `json:"id"`
	RoleId     uint16 `json:"user_role_id"`
	LevelId    uint16 `json:"user_level_id"`
	Status     uint16 `json:"status"`
	LastLogin  uint64 `json:"last_login"`
	LoginCount uint64 `json:"login_count"`
	Sort       int64  `json:"sort"`
	Created    uint32 `json:"created"`
	Updated    uint32 `json:"updated"`
	LastIp     string `json:"last_ip"`
	Name       string `json:"name"`
	Nickname   string `json:"nickname"`
	LastRegion string `json:"last_region"`
}
