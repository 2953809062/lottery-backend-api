package models

/// 配置
type Configs struct {
	Id      uint64 `json:"id"`      //编号
	Name    string `json:"name"`    //配置名称
	Value   string `json:"value"`   //配置项值
	Remark  string `json:"remark"`  //备注
	Status  uint16 `json:"status"`  //状态
	Sort    int64  `json:"sort"`    //排序
	Created uint32 `json:"created"` //添加时间
	Updated uint32 `json:"updated"` //修改时间
}
