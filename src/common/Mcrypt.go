package common

import (
	"crypto/md5"
	"fmt"
	"math/rand"
	"time"
)

/// 服务器端的key
const ServerKey = "a!k@9#d%9*&aDQK-=bv<M+3456*8c0}@"

/// 用于生成随机字符串的值
var McryptLetters = []rune("abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789")

/// 生成密码
func GetPassword(password, secret string) string {
	return MD5(password + "-" + ServerKey + "-" + secret)
}

/// 生成md5的值
func MD5(str string) string {
	return fmt.Sprintf("%x", md5.Sum([]byte(str)))
}

/// 随机生成密钥
func GetSecret() string {
	return GetRandString(32)
}

/// 生成随机字符串
func GetRandString(n uint) string {
	rand.Seed(time.Now().UnixNano())
	b := make([]rune, n)
	for i := range b {
		b[i] = McryptLetters[rand.Intn(len(McryptLetters))]
	}
	return string(b)
}
