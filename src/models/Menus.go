package models

/// 菜单
type Menus struct {
	Id      uint64 `json:"id"`      //编号
	Type    uint16 `json:"type"`    //类型
	Level   uint16 `json:"level"`   //层级
	Status  uint16 `json:"status"`  //状态
	Created uint32 `json:"created"` //添加时间
	Sort    int64  `json:"sort"`    //排序
	Name    string `json:"name"`    //名称
	Url     string `json:"url"`     //url
}

/// rows
type MenusRow struct {
	Id      uint64 `json:"id"`
	Name    string `json:"name"`
	Type    uint16 `json:"type"`
	Level   uint16 `json:"level"`
	Status  uint16 `json:"status"`
	Url     string `json:"url"`
	Sort    int64  `json:"sort"`
	Created uint32 `json:"created"`
	Updated uint32 `json:"updated"`
}
