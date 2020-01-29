package request

import (
	"config"
	"fmt"
	"strings"

	"github.com/gin-gonic/gin"
)

/// 获取平台标识号
func GetPlatform(c *gin.Context) string {
	url := strings.Split(fmt.Sprintf("%v", c.Request.URL), "?")[0]
	if strings.Index(url, "sites") > 0 ||
		strings.Index(url, "platforms") > 0 ||
		strings.Index(url, "site_configs") > 0 {
		return "sys_platform" //系统默认的平台识别号
	}

	host := c.Request.Host
	if platform, exists := config.PlatformUrls[host]; exists {
		return platform
	}
	return ""
}
