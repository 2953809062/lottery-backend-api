#!/bin/bash

bin_dir='./bin'
bin_name='api-backend'
bin_file="$bin_dir/$bin_name"
conf_dir="$bin_dir/config"

# 如果中断则上一步
trap "cd ..;" SIGINT

echo "设置变量: GOPATH ..."
export GOPATH=$HOME/.go:$PWD
echo "GOPATH  : $GOPATH"

echo "检测目录: $bin_dir ..."
if [ ! -d $bin_dir ]; then
    echo "创建目录: $bin_dir"
    mkdir $bin_dir
fi

echo "检测文件: $bin_file ..."
if [ -f $bin_file ]; then
    echo "删除文件: $bin_file"
    rm -rf $bin_file
fi

echo "配置文件: $conf_dir ..."
if [ ! -d $conf_dir ]; then
    echo "获取失败: $conf_dir, 配置文件无效"
    exit
fi

echo "检测代码: go vet main.go"
go vet main.go
if [ "$?" != "0" ]; then
    echo "代码错误, 停止执行"
    exit
fi

echo "编译文件: ./main.go ..."
go build -o $bin_file main.go
if [ "$?" != "0" ]; then
    echo "编译错误: $?"
    exit
fi

echo "执行文件: $bin_file ..."
cd $bin_dir
./$bin_name
