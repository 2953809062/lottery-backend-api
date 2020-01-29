#!/usr/bin/php -f
<?php

if (count($argv) < 3) { 
	echo "参数错误: '", implode(',', $argv), "'\n";
	echo "需要参数: {$argv[0]} 彩种编号 间隔秒数 \n";
	echo "运行示例: {$argv[0]} 1 30 \n";
	exit;
}

$lottery_id = trim($argv[1]);
$timeout = trim($argv[2]);
if (!is_numeric($lottery_id) || !is_numeric($timeout)) { 
	echo "参数错误: '", implode(',', $argv), "'\n";
	echo "彩种编号及间隔秒数必须为数字 \n";
	exit;
}

$dir = './open-times/';
$file = $dir. 'lottery-'. $lottery_id. '.sql';
if (is_file($file)) {  //如果存在则删除
	unlink($file);
}

$close_timeout = 30; //提前封盘秒数
if (count($argv) >= 4) { 
	$s = intval($argv[3]);
	if ($s >= 10) { 
		$close_timeout = $s;
	}
}
$first = '00:00:30'; //封盘: 00:00:15 //提前15秒封盘
$end = '23:59:30';

$date = date('Y-m-d');
$start_time = strtotime($date. ' '. $first);
$end_time = strtotime($date. ' '. $end);
$count = 0;
$current_time = $start_time;

$sql = "INSERT INTO open_times (lottery_id, period_number, time_close, time_open, day_offset, is_begin, is_end) VALUES \n";

while (TRUE) { 
	$is_begin = 0;
	$is_end = 0;
	
	if ($count == 0) { 
		$is_begin = 1;
	}
	if ($current_time > $end_time) { 
		break;
	}
	
	$current_close_time = $current_time - $close_timeout;
	$current_close = date('H:i:s', $current_close_time);
	$current_stime = date('H:i:s', $current_time);
	echo "[{$count}] 封盘时间: $current_close, 开奖时间: $current_stime, \n";

	$period_number = sprintf("%04s", $count);
	$day_offset = 0;
	
	$sql .= sprintf("('%d', '%s', '%s', '%s', '%d', '%d', '%d'),\n", 
		$lottery_id, $period_number, $current_close, $current_stime, $day_offset, $is_begin, $is_end);

	$current_time += $timeout;
	$count += 1;
}

$sql = trim(trim($sql), ','). ';';

$sql .= "\n"
	."SELECT MAX(id) INTO @max_id FROM open_times WHERE lottery_id = $lottery_id; \n"
	."UPDATE open_times SET is_end = '1' WHERE id = @max_id; \n";

file_put_contents($file, $sql);



