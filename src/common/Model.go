package common

import (
	"common/log"
	"db"
	"errors"
	"fmt"
	"strconv"
	"strings"

	"github.com/go-xorm/xorm"
	"xorm.io/builder"
)

/// 模型接口
type IModel interface {
	FindAll(string, interface{}, ...interface{}) (uint64, error) //参数: 平台/出参/builder.Cond/limit/offset/orderBy
	Find(string, interface{}, ...interface{}) error              //参数: 平台/出参/builder.Cond/orderBy
	Create(string, map[string]interface{}) (uint64, error)       //参数: 平台/数据
	Update(string, map[string]interface{}) error                 //参数: 平台/编号/数据
	Delete(string, string) error                                 //参数: 平台/编号
	GetEngine(string) *xorm.EngineGroup                          //获取数据库连接
	GetTableName() string                                        //获取表名称
}

/// 模型基类
type Model struct {
	TableName string                   //表名称
	Db        *xorm.EngineGroup        //db
	GetDb     func() *xorm.EngineGroup //获取db
}

/// 获取表名称
func (ths *Model) GetTableName() string {
	return ths.TableName
}

/// 获取所有记录
func (ths *Model) FindAll(platform string, rows interface{}, args ...interface{}) (uint64, error) {
	session := getModelDb(platform, ths).NewSession().Table(ths.TableName)
	argLength := len(args)
	limit := 15
	offset := 0
	if argLength >= 1 { //条件
		if args[0] != nil {
			session = session.Where(args[0].(builder.Cond))
		}
		if argLength >= 2 {
			limit = args[1].(int)
			if argLength >= 3 {
				offset = args[2].(int)
				if argLength >= 4 {
					session = session.OrderBy(args[3].(string))
				}
			}
		}
	}

	if total, err := session.Limit(limit, offset).FindAndCount(rows); err == nil {
		return uint64(total), nil
	} else {
		return 0, err
	}
}

/// 获取单条记录
func (ths *Model) Find(platform string, row interface{}, args ...interface{}) error {
	session := getModelDb(platform, ths).NewSession().Table(ths.TableName)
	argLength := len(args)
	if argLength >= 1 {
		if args[0] != nil {
			session = session.Where(args[0].(builder.Cond))
		}
	}
	if _, err := session.Get(row); err != nil {
		return err
	}
	return nil
}

/// 添加记录
func (ths *Model) Create(platform string, postedData map[string]interface{}) (uint64, error) {
	if _, fields, values := getPostedFieldValues(platform, ths.TableName, true, postedData); fields == nil {
		return 0, errors.New("添加失败")
	} else {
		inserts := []interface{}{""}
		inserts = append(inserts, values...)
		inserts[0] = fmt.Sprintf("INSERT INTO %s (%s) VALUES (?%s)", ths.TableName, strings.Join(fields, ","), strings.Repeat(",?", len(fields)-1))
		session := getModelDb(platform, ths).NewSession()
		if result, err := session.Exec(inserts...); err != nil {
			sql, _ := session.LastSQL()
			log.Err("执行Model-Create时失败: %v\nSQL: %s\n%v\n", err, sql, inserts)
			return 0, errors.New("添加失败")
		} else {
			if lastInsertId, err := result.LastInsertId(); err != nil {
				log.Err("获取添加记录时失败: %v\n", err)
				return 0, errors.New("添加失败")
			} else {
				return uint64(lastInsertId), nil
			}
		}
	}
}

/// 修改记录
func (ths *Model) Update(platform string, postedData map[string]interface{}) error {
	if data, fields, values := getPostedFieldValues(platform, ths.TableName, false, postedData); fields == nil {
		return errors.New("修改失败")
	} else {
		if idUn, exists := data["id"]; !exists {
			log.Err("修改记录时找不到ID\n")
			return errors.New("修改失败")
		} else {
			updates := []interface{}{""}
			updateFields := ""
			for k, v := range fields {
				updates = append(updates, values[k])
				updateFields += fmt.Sprintf("%s = ? ", v) + ","
			}
			id, _ := strconv.Atoi(fmt.Sprintf("%v", idUn))
			updates[0] = fmt.Sprintf("UPDATE %s SET %s WHERE id = %v LIMIT 1", ths.TableName, strings.Trim(updateFields, ","), strconv.Itoa(id))
			if _, err := getModelDb(platform, ths).NewSession().Exec(updates...); err != nil {
				log.Err("执行Model-Update时失败: %v\nSQL: %s\n", err, updates)
				return errors.New("修改失败")
			}
		}
		return nil
	}
}

/// 删除记录
func (ths *Model) Delete(platform string, idStr string) error {
	ids := []string{}
	idStrArr := strings.Split(idStr, ",")
	for _, v := range idStrArr {
		if _, err := strconv.Atoi(v); err != nil {
			log.Err("错误的号: %s/%v\n", idStr, err)
			return errors.New("删除失败")
		} else {
			ids = append(ids, v)
		}
	}
	if len(ids) == 0 {
		log.Err("无效的ID: %s\n", idStr)
		return errors.New("删除失败")
	}
	sql := "DELETE FROM " + ths.TableName + " WHERE id IN (" + strings.Join(ids, ",") + ")"
	if _, err := getModelDb(platform, ths).NewSession().Exec(sql); err != nil {
		log.Err("删除失败: %v\n", err)
		return errors.New("删除失败")
	} else {
		return nil
	}
}

/// 得到数据库对象
func (ths *Model) GetEngine(platform string) *xorm.EngineGroup {
	if db, exists := db.Servers[platform]; exists {
		return db
	}
	return nil
}

/// 获取提交上来的post数组
func getPostedFieldValues(platform string, tableName string, isCreate bool, postedData map[string]interface{}) (map[string]interface{}, []string, []interface{}) {
	realFields := db.GetTableFields(platform, tableName) //获取对应的表信息
	currentTime := Now()                                 //当前时间
	fields := []string{}                                 //字段
	values := []interface{}{}                            //写入的值
	for _, fv := range realFields {
		if fv == "id" {
			continue
		}
		if fv == "updated" || (fv == "created" && isCreate) {
			fields = append(fields, fv)
			values = append(values, currentTime)
			continue
		}
		if val, exists := postedData[fv]; exists && fmt.Sprintf("%v", val) != "" { //如果确实有提交字段信息
			fields = append(fields, fv)
			values = append(values, val)
		}
	}
	if len(fields) > 0 {
		return postedData, fields, values
	}
	log.Err("没有提交任何可以与数据库匹配的字段: %v\n%v\n", postedData, realFields)
	return nil, nil, nil
}

/// 获取数据库连接
func getModelDb(platform string, model *Model) *xorm.EngineGroup {
	if model.Db == nil {
		if model.GetDb == nil {
			return db.DefaultDb(platform)
		}
		return model.GetDb()
	}
	return model.Db
}
