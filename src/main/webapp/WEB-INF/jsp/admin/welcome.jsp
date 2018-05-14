<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
	<meta charset="utf-8">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1">
	<title>欢迎页面</title>
	<!-- zui -->
	<link href="../zui/css/zui.min.css" rel="stylesheet">

</head>
<style>
	*{margin: 0; padding: 0; box-sizing: border-box;}

	#bg{
		background: url(../pictures/darksky.jpg) no-repeat;
		background-size: cover;
		background-position: center center;
	}

	#canvas{
		position: absolute;
		top: 0;
		left: 0;
	}
</style>
<body id="bg">
<canvas id="canvas"></canvas>

<script src="../jquery/jquery-3.2.1.min.js"></script>
<!-- ZUI Javascript组件 -->
<script src="../zui/js/zui.min.js"></script>

<script src="../js/dots.js"></script>
<script src="../js/main.js"></script>
</body>
</html>