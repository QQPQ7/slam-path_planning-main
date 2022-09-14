<?php
$db_host = "localhost"; 
$db_user = "capstone5"; 
$db_passwd = "scoutmini5!";
$db_name = "capstone5"; 

// MySQL - DB 접속.
$conn = mysqli_connect($db_host,$db_user,$db_passwd,$db_name);

mysqli_set_charset($conn,"utf8"); 

$ar_x = [];
$ar_y = [];
$ar_id = [];

// 테이블 쿼리 후 내용 출력.
$sql = "SELECT * FROM test";
$result = mysqli_query($conn,$sql);

while($row = mysqli_fetch_array($result)){
	array_push($ar_x, $row['x']);
	array_push($ar_y, $row['y']);
	array_push($ar_id, $row['id']);
}

$ar = array_merge($ar_x,$ar_y,$ar_id);

$output =  json_encode($ar);

echo urldecode($output);

mysqli_close($conn);
?>