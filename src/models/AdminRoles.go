package models

/// 后台用户角色
type AdminRoles struct {
	Id     uint64 `json:"id"`     //编号
	Name   string `json:"name"`   //名称
	Remark string `json:"remark"` //备注
	Menus  string `json:"menus"`  //菜单
}

/// rows
type AdminRolesRow struct {
	Id     uint64 `json:"id"`
	Name   string `json:"name"`
	Remark string `json:"remark"`
}
