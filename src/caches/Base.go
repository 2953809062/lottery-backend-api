package caches

import "sync"

/// 所有的缓存保存
var cacheAll = map[string]interface{}{}

/// 共享数据锁
var cacheMutex = sync.Mutex{}

/// 获取
func Get(platform string, key string, callback func() interface{}) interface{} {
	cacheKey := platform + "-" + key
	if val, exists := cacheAll[cacheKey]; exists {
		return val
	}

	cacheMutex.Lock()
	defer cacheMutex.Unlock()
	val := callback()
	cacheAll[cacheKey] = val
	return val
}
