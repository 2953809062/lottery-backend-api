package models

/// 用户角色
type UserRoles struct {
	Id     uint64 `json:"id"`     //编号
	Name   string `json:"name"`   //名称
	Remark string `json:"remark"` //备注
}

/// for controller rows
type UserRolesRow struct {
	Id     uint64 `json:"id"`
	Name   string `json:"name"`
	Remark string `json:"remark"`
}
