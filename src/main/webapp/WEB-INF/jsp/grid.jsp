<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>列表</title>
    <!-- zui -->
    <link href="zui/css/zui.min.css" rel="stylesheet">
    <link href="zui/lib/datagrid/zui.datagrid.css" rel="stylesheet">
    <link href="css/public.css" type="text/css" rel="stylesheet">
</head>
<body>

<div class="container">
    <shiro:user>
        欢迎[<shiro:principal property="nickName"/>]登录，<a href="${pageContext.request.contextPath}/logout">退出</a>
    </shiro:user>
</div>

<script src="jquery/jquery-3.2.1.min.js"></script>
<!-- ZUI Javascript组件 -->
<script src="zui/js/zui.min.js"></script>
</body>
</html>