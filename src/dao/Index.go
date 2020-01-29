package dao

import (
	"common"
	"common/log"
	"common/request"
	"errors"
	"models"
	"validations"

	"github.com/gin-gonic/gin"
	"xorm.io/builder"
)

/// 首页默认的模型
var Index = struct {
	Index func()
	Login func(*gin.Context) error
}{
	//首页信息
	Index: func() {},
	Login: func(c *gin.Context) error { //登录
		// 检测提交内容是否合法
		data := request.GetPostedData(c)
		if err := validations.Index(data); err != nil {
			return err
		}

		// 检测用户是否存在
		admin := models.Admins{}
		platform := request.GetPlatform(c)
		userName := data["username"].(string)
		cond := builder.NewCond().And(builder.Eq{"username": userName})
		if err := Admins.Find(platform, &admin, cond); err != nil {
			return err
		}

		password := data["password"].(string)
		if admin.Password != common.GetPassword(password, admin.Secret) {
			return errors.New("用户名称或密码错误")
		}

		// 更新用户登录信息
		admin.LoginCount += 1
		admin.LastIp = c.Request.RemoteAddr
		admin.Updated = uint32(common.Now())
		admin.Secret = common.GetSecret()
		admin.Password = common.GetPassword(password, admin.Secret)
		if affected, err := Admins.GetEngine(platform).Update(&admin); err != nil || affected == 0 {
			return err
		} else {
			// 写后台用户日志
			log := models.AdminLogs{
				AdminId:   admin.Id,
				AdminName: admin.Name,
				Level:     log.LevelNormal,
				Type:      log.TypeLogin,
				Created:   uint32(common.Now()),
				Url:       c.Request.RequestURI,
			}
			if id, err := AdminLogs.GetEngine(platform).Insert(&log); err != nil || id <= 0 {
				return err
			}
		}
		return nil
	},
}
