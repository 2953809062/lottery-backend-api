package models

/// 配置
type SiteConfigs struct {
	Id         uint64 `json:"id"`          //8/编号
	PlatformId uint64 `json:"platform_id"` //8/平台编号
	SiteId     uint64 `json:"site_id"`     //8/站点编号
	Status     uint16 `json:"status"`      //4/状态
	Sort       int32  `json:"sort"`        //排序
	Created    uint32 `json:"created"`     //4/添加时间
	Updated    uint32 `json:"updated"`     //4/更新时间
	Name       string `json:"name"`        //配置项名
	Value      string `json:"value"`       //配置项值
	Remark     string `json:"remark"`      //备注
}

/// rows
type SiteConfigsRow struct {
	Id         uint64 `json:"id"`
	PlatformId uint64 `json:"platform_id"`
	SiteId     uint64 `json:"site_id"`
	Status     uint32 `json:"status"`
	Name       string `json:"name"`
	Value      string `json:"value"`
	Sort       int64  `json:"sort"`
	Created    uint32 `json:"created"`
	Updated    uint32 `json:"updated"`
}
