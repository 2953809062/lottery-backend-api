package db

import (
	"common/log"
	"config"
	"fmt"
	"strings"

	"github.com/spf13/viper"

	_ "github.com/go-sql-driver/mysql"
	"github.com/go-xorm/xorm"
	//_ "github.com/lib/pq"
)

/// 所有数据库服务器
var Servers map[string]*xorm.EngineGroup

/// 数据库: 平台名称 - 表名称 - 字段
var TableFields map[string]map[string][]string

/// 加载配置信息
func LoadConfigs() {
	if Servers != nil {
		return
	}

	// 读取配置文件
	viper.SetConfigName("settings")
	viper.AddConfigPath("./config/")
	viper.SetConfigType("json")
	if err := viper.ReadInConfig(); err != nil {
		log.Err("获取配置文件出错: %v \n", err)
		return
	}

	nodeName := "database"                                   //database
	platform := viper.GetString(nodeName + ".platform")      //平台标识号
	dbType := viper.GetString(nodeName + ".type")            //数据库类型
	connString := viper.GetString(nodeName + ".conn_string") //连接字符串

	// 数据源
	dataSources := []string{
		connString,
	}

	Servers = map[string]*xorm.EngineGroup{}     //初始化
	config.PlatformUrls = map[string]string{}    //平台域名
	InitDbServers(platform, dbType, dataSources) //初始化默认的系统平台数据库
	db := Servers[platform]
	// 因为默认只有一个平台级的数据库, 所有在此只取1个
	// 注意:
	// 1. 以下数据库连接信息是从系统平台的数据库当中读取
	// 2. setting.json当中的设置项是无效的
	// 3. 在系统平台库的 site_configs 表
	confs := GetPlatformConfigs(db)
	for _, conf := range confs {
		if platform, exists := conf["platform"]; exists {
			if connString, exists := conf["conn_strings"]; exists {
				dbType := "mysql"
				if engineType, exists := conf["db_type"]; exists {
					dbType = engineType
				}
				InitDbServers(platform, dbType, []string{connString})
			}
		}
	}

	if TableFields == nil {
		LoadDbTableFields()
	}
}

/// 初始化数据库服务器
func InitDbServers(platform string, dbType string, dataSources []string) {
	if _, exists := Servers[platform]; exists { //如果已经存在则不处理
		return
	}
	if engineGroup, err := xorm.NewEngineGroup(dbType, dataSources); err != nil {
		log.Err("连接数据库错误: %v\n", err)
		return
	} else {
		engineGroup.ShowSQL(true) //显示sql语句
		Servers[platform] = engineGroup
	}
}

/// 得到平台-站点-配置相关信息
func GetPlatformConfigs(db *xorm.EngineGroup) []map[string]string {
	data := []map[string]string{}
	session := db.NewSession()
	if platforms, err := session.QueryString("SELECT id FROM platforms WHERE status = 1"); err == nil && len(platforms) >= 1 {
		for _, p := range platforms {
			if sites, err := session.QueryString("SELECT id, urls FROM sites WHERE platform_id = ? AND status = 1", p["id"]); err == nil && len(sites) >= 1 {
				for _, s := range sites {
					sql := "SELECT name, value FROM site_configs WHERE platform_id = ? AND site_id = ? AND status = 1"
					conf := map[string]string{}
					if confs, err := session.QueryString(sql, p["id"], s["id"]); err == nil && len(confs) >= 1 {
						for _, c := range confs {
							name := c["name"]
							value := c["value"]
							conf[name] = value
							if name == "platform" {
								urls := strings.Split(s["urls"], ",")
								for _, url := range urls {
									config.PlatformUrls[url] = value
								}
							}
						}
						data = append(data, conf)
					} else {
						log.Err("获取所有配置信息时出错: %v\n", err)
					}
				}
			} else {
				log.Err("获取所有盘口信息时出错: %v\n", err)
			}
		}
	} else {
		log.Err("获取所有平台时出错: %v\n", err)
	}
	return data
}

/// 默认的db
func DefaultDb(platform string) *xorm.EngineGroup {
	if Servers == nil {
		fmt.Println("数据库连接不存在, 需要重新建立 ...")
		LoadConfigs()
	}
	if db, exists := Servers[platform]; exists { //拿到默认的值
		return db
	}
	return Servers["sys_platform"]
}

/// 加载所有数据库/表/字段信息
func LoadDbTableFields() {
	TableFields = map[string]map[string][]string{}
	for platform, db := range Servers {
		TableFields[platform] = GetTableFieldsFromDb(platform, db)
	}
}

/// 得到此数据库的所有表/字段
func GetTableFieldsFromDb(platform string, db *xorm.EngineGroup) map[string][]string {
	// 先得到所有表
	sql := "SHOW TABLES"
	tableNames := []string{}
	if rows, err := db.QueryString(sql); err != nil {
		log.Err("获取所有表信息出错: %v\n", err)
		return nil
	} else {
		field := "Tables_in_" + platform
		for _, r := range rows {
			tableNames = append(tableNames, r[field])
		}

		// 初始化数库/表/字段信息
		tableFields := map[string][]string{}
		for _, table := range tableNames {
			fields := []string{}
			sql := "DESC " + table
			if rows, err := db.QueryString(sql); err != nil {
				log.Err("获取表信息出错: %v\nSQL: %s\n", err, sql)
				continue
			} else {
				for _, r := range rows {
					fields = append(fields, r["Field"])
				}
			}
			tableFields[table] = fields
		}

		return tableFields
	}
}

/// 得到此平台的所有数据表/字段信息
func GetDbTableFields(platform string) map[string][]string {
	if tableFields, exists := TableFields[platform]; exists {
		return tableFields
	}
	return nil
}

/// 获取表/字段信息
func GetTableFields(platform string, table string) []string {
	if tableFields := GetDbTableFields(platform); tableFields != nil {
		if fields, exists := tableFields[table]; exists {
			return fields
		}
	}
	return nil
}
