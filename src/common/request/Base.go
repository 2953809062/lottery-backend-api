package request

import (
	"common/log"
	"encoding/json"
	"strconv"

	"github.com/gin-gonic/gin"
	"xorm.io/builder"
)

/// 获取提交的post来的数组
func GetPostedData(c *gin.Context) map[string]interface{} {
	if bytes, err := c.GetRawData(); err != nil {
		log.Err("获取POST原始数据有误: %v\n", err)
		return nil
	} else {
		var data = map[string]interface{}{}
		if err := json.Unmarshal(bytes, &data); err != nil {
			log.Err("获取POST并转换时失败: %v\n", err)
		}
		return data
	}
}

/// 获取页码
func GetPage(c *gin.Context) int {
	if page, err := strconv.Atoi(c.DefaultQuery("page", "1")); err != nil {
		log.Err("格式化获取页码出错: %v\n", err)
		return 1
	} else {
		if page == 0 {
			return 1
		}
		return page
	}
}

/// 获取limit信息
func GetLimit(c *gin.Context) int {
	if limit, err := strconv.Atoi(c.DefaultQuery("limit", "20")); err != nil {
		log.Err("格式化获取 limit 出错: %v\n", err)
		return 15
	} else {
		if limit == 0 || limit > 10000 {
			return 15
		}
		return limit
	}
}

/// 获取 (limit, offset)
func GetOffsets(c *gin.Context) (int, int) {
	page := GetPage(c)
	size := GetLimit(c)
	return size, (page - 1) * size
}

/// 得到查询条件
func GetQueryCond(c *gin.Context, data map[string]interface{}) builder.Cond {
	cond := builder.NewCond()
	for k, s := range data {
		if val, exists := c.GetQuery(k); exists {
			switch sign := s.(type) {
			case string:
				switch sign {
				case "=":
					cond = cond.And(builder.Eq{k: val})
				case ">":
					cond = cond.And(builder.Gt{k: val})
				case ">=":
					cond = cond.And(builder.Gte{k: val})
				case "<":
					cond = cond.And(builder.Lt{k: val})
				case "<=":
					cond = cond.And(builder.Lte{k: val})
				case "%":
					cond = cond.And(builder.Like{k, val})
				default:
					continue
				}
			}
		} else {
			switch s.(string) {
			case "between, []":
				setQueryCondBetween(c, k, func(val interface{}) {
					cond = cond.And(builder.Gte{k: val})
				}, func(val interface{}) {
					cond = cond.And(builder.Lte{k: val})
				})
			case "()":
				setQueryCondBetween(c, k, func(val interface{}) {
					cond = cond.And(builder.Gt{k: val})
				}, func(val interface{}) {
					cond = cond.And(builder.Lt{k: val})
				})
			case "[)":
				setQueryCondBetween(c, k, func(val interface{}) {
					cond = cond.And(builder.Gte{k: val})
				}, func(val interface{}) {
					cond = cond.And(builder.Lt{k: val})
				})
			case "(]":
				setQueryCondBetween(c, k, func(val interface{}) {
					cond = cond.And(builder.Gt{k: val})
				}, func(val interface{}) {
					cond = cond.And(builder.Lte{k: val})
				})
			default:
				continue
			}
		}
	}
	return cond
}

/// 设置以区间为条件的查询字段
func setQueryCondBetween(c *gin.Context, field string, callStart func(interface{}), callEnd func(interface{})) {
	start := field + "_start"
	end := field + "_end"
	if startVal, exists := c.GetQuery(start); exists {
		callStart(startVal)
	}
	if endVal, exists := c.GetQuery(end); exists {
		callEnd(endVal)
	}
}
