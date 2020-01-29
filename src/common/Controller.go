package common

import (
	"caches"
	"common/log"
	"common/request"
	"common/response"
	"models"
	"strconv"

	"github.com/gin-gonic/gin"
	"xorm.io/builder"
)

/// 后台控制器基类
type Backend struct {
	Model        IModel                             //模型
	Headers      []map[string]string                //字段映射
	OptionAll    bool                               //是否有all方法
	OptionList   bool                               //列表
	OptionCreate bool                               //添加
	OptionUpdate bool                               //修改
	OptionDelete bool                               //删除
	OptionDetail bool                               //查看
	Rows         func() interface{}                 //多条记录
	RowsProcess  func(interface{})                  //对于多条记录的处理
	QueryCond    map[string]interface{}             //查询条件
	Validator    func(map[string]interface{}) error //校验器
	Row          func() interface{}                 //单条记录
}

/// 列表
func (ths *Backend) List(c *gin.Context) {
	//if !ths.OptionList {
	//	response.Err(c, "缺少权限")
	//	return
	//}
	rows := ths.Rows()
	limit, offset := request.GetOffsets(c)
	platform := request.GetPlatform(c)
	if total, err := ths.Model.FindAll(platform, rows, request.GetQueryCond(c, ths.QueryCond), limit, offset); err != nil {
		log.Err("获取列表信息出错: %v\n", err)
		response.Err(c, "获取列表错误")
	} else {
		if ths.RowsProcess != nil {
			ths.RowsProcess(&rows)
		}
		response.Result(c, struct {
			Headers []map[string]string `json:"headers"`
			Options map[string]bool     `json:"options"`
			List    interface{}         `json:"list"`
			Total   uint64              `json:"total"`
		}{
			Headers: ths.Headers,
			Options: map[string]bool{
				"create": ths.OptionCreate,
				"update": ths.OptionUpdate,
				"delete": ths.OptionDelete,
				"detail": ths.OptionDetail,
			},
			List:  rows,
			Total: total,
		})
	}
}

/// 详情
func (ths *Backend) Detail(c *gin.Context) {
	if !ths.OptionDetail {
		response.Err(c, "缺少权限")
		return
	}
	if idStr, exists := c.GetQuery("id"); exists && idStr != "" {
		if id, err := strconv.Atoi(idStr); err == nil && id > 0 {
			row := ths.Row()
			cond := builder.NewCond().And(builder.Eq{"id": id})
			if err := ths.Model.Find(request.GetPlatform(c), row, cond); err == nil {
				response.Result(c, row)
				return
			} else {
				log.Err("获取详情失败: %v\n", err)
			}
		} else {
			log.Err("ID转换失败: %v\n", err)
		}
	} else {
		log.Err("无法获取id信息!\n")
	}

	response.Err(c, "获取详情错误")
}

/// 添加
func (ths *Backend) Create(c *gin.Context) {
	if !ths.OptionCreate {
		response.Err(c, "缺少权限")
		return
	}
	postedData := request.GetPostedData(c)
	if ths.Validator != nil {
		if err := ths.Validator(postedData); err != nil {
			response.Err(c, err.Error())
			return
		}
	}
	if id, err := ths.Model.Create(request.GetPlatform(c), postedData); err != nil {
		response.Err(c, err.Error())
	} else {
		response.Result(c, struct {
			Id uint64 `json:"id"`
		}{
			Id: id,
		})
	}
}

/// 修改
func (ths *Backend) Update(c *gin.Context) {
	if !ths.OptionUpdate {
		response.Err(c, "缺少权限")
		return
	}
	postedData := request.GetPostedData(c)
	if ths.Validator != nil {
		if err := ths.Validator(postedData); err != nil {
			response.Err(c, err.Error())
			return
		}
	}
	if err := ths.Model.Update(request.GetPlatform(c), postedData); err != nil {
		response.Err(c, err.Error())
		return
	}
	response.Ok(c)
}

/// 删除
func (ths *Backend) Delete(c *gin.Context) {
	if !ths.OptionDelete {
		response.Err(c, "缺少权限")
		return
	}
	idStr := c.DefaultQuery("id", "0")
	if err := ths.Model.Delete(request.GetPlatform(c), idStr); err != nil {
		response.Err(c, err.Error())
		return
	}
	response.Ok(c)
}

/// 获取所有id-name样式
func (ths *Backend) All(c *gin.Context) {
	if !ths.OptionAll {
		response.Err(c, "缺少权限")
		return
	}
	platform := request.GetPlatform(c)
	if values := caches.Get(platform, ths.Model.GetTableName(), func() interface{} {
		rows := &[]models.IdName{}
		_, _ = ths.Model.FindAll(platform, rows, nil, 100)
		return rows
	}); values != nil {
		response.Result(c, values)
		return
	}
	response.Err(c, "获取失败")
}
