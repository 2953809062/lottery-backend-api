#!/bin/bash

host='localhost'            # 主机地址
name='sys_platform'         # 数据库名
user='platform_sys'         # 用户名称
password='platform-x-147'   # 用户密码
mysql_bin='/usr/bin/mysql'  # mysql
import_file="${HOME}/web/backend/scripts/init.sql"    # 导入文件名称
import_game="${HOME}/web/backend/scripts/init-game.sql" # game库文件

## 导入本地数据库
function import_local() { 
    if [ ! -f $import_file ]; then
        echo "错误: 导入文件不存在 $import_file"
        exit
    fi

    name='sys_platform'
    user='platform_sys'
    password='platform-x-147'
    echo "开始导入数据 ..."
    $mysql_bin -h"$host" -u"$user" -p"$password" $name < $import_file
}

## 导入游戏数据库
function import_game() {
    if [ ! -f $import_game ]; then
        echo "错误: 导入文件不存在 $import_game"
        exit
    fi

    name='game001'
    user='game001'
    password='game001-x-lsl'
    echo "开始导入数据(game) ..."
    $mysql_bin -h"$host" -u"$user" -p"$password" $name < $import_game
}

## 主程序
case "$1" in 
    "import")
        import_local;;
    "import-game")
      import_game;;
    *)
        echo "参数错误: $1"
        echo "可用参数: import|import-game";;
esac
