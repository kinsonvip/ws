<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>首页</title>
    <!-- zui -->
    <link href="zui/css/zui.css" rel="stylesheet">
    <link href="zui/css/zui-theme.css" rel="stylesheet">
    <link href="css/index.css" type="text/css" rel="stylesheet">
    <link rel="icon" href="icon/university.jpg">
</head>
<body>
<div class="total">
    <div class="head">
        <div class="head-tittle">
        </div>
        <nav class="navbar navbar-inverse" role="navigation">
            <div class="container-fluid">
                <!-- 导航项目 -->
                <div class="collapse navbar-collapse">
                    <!-- 一般导航项目 -->
                    <ul class="nav navbar-nav navbarTittleLeft">
                        <li><a href="index">首页</a></li>
                        <li><h4 style="color: white;margin-left: 20px;margin-right: 20px">|</h4></li>
                        <li><a href="your/nice/url">中心简介</a></li>
                        <li><h4 style="color: white;margin-left: 20px;margin-right: 20px">|</h4></li>
                        <li><a href="jobList">招聘信息</a></li>
                        <li><h4 style="color: white;margin-left: 20px;margin-right: 20px">|</h4></li>
                        <li><a href="noticeList">公告中心</a></li>
                        <li><h4 style="color: white;margin-left: 20px;margin-right: 20px">|</h4></li>
                        <li><a href="newsList">时事新闻</a></li>
                    </ul>
                    <!-- 右侧的导航项目 -->
                    <ul class="nav navbar-nav navbar-right navbarTittleRight">
                        <shiro:guest>
                            <li style="color: white;margin-top: 7%">欢迎游客访问,</li>
                            <li><a href="login"><i class="icon icon-user"></i>&nbsp&nbsp登录</a></li>
                        </shiro:guest>
                        <shiro:user>
                            <li class="dropdown">
                                <a href="your/nice/url" class="dropdown-toggle" data-toggle="dropdown">
                                    <i class="icon icon-user"></i>&nbsp&nbsp[<shiro:principal property="nickName"/>]
                                    <b class="caret"></b></a>
                                <ul class="dropdown-menu" role="menu">
                                    <li><a href="personalInfo"><i class="icon icon-info"></i>&nbsp&nbsp个人信息</a></li>
                                    <li><a href="myContract"><i class="icon icon-list-alt"></i>&nbsp&nbsp我的合同</a></li>
                                    <li><a href="updatePass"><i class="icon icon-key"></i>&nbsp&nbsp修改密码</a></li>
                                    <li><a href="login"><i class="icon icon-group"></i>&nbsp&nbsp切换用户</a></li>
                                    <li class="divider"></li>
                                    <li><a href="logout"><i class="icon icon-signout"></i>&nbsp&nbsp退出登录</a></li>
                                </ul>
                            </li>
                        </shiro:user>
                    </ul>
                </div><!-- END .navbar-collapse -->
            </div>
        </nav>
    </div>

    <div class="middle">
        <div class="container-fluid">
            <div class="row">
                <div id="calendar" class="col-md-3">
                    <iframe src="html/calendar.html" width="280px" height="330px"></iframe>
                </div>
                <div id="picture" class="col-md-9">
                    <div class="container-fluid">
                        <div id="myNiceCarousel" class="carousel slide" data-ride="carousel">
                            <!-- 圆点指示器 -->
                            <ol class="carousel-indicators">
                                <li data-target="#myNiceCarousel" data-slide-to="0" class="active"></li>
                                <li data-target="#myNiceCarousel" data-slide-to="1"></li>
                                <li data-target="#myNiceCarousel" data-slide-to="2"></li>
                            </ol>

                            <!-- 轮播项目 -->
                            <div class="carousel-inner">
                                <div class="item active">
                                    <img alt="First slide" src="pictures/tittle1.jpg">
                                </div>
                                <div class="item">
                                    <img alt="Second slide" src="pictures/tittle2.jpg">
                                </div>
                                <div class="item">
                                    <img alt="Third slide" src="pictures/tittle3.jpg">
                                </div>
                            </div>

                            <!-- 项目切换按钮 -->
                            <a class="left carousel-control" href="#myNiceCarousel" data-slide="prev">
                                <span class="icon icon-chevron-left"></span>
                            </a>
                            <a class="right carousel-control" href="#myNiceCarousel" data-slide="next">
                                <span class="icon icon-chevron-right"></span>
                            </a>
                        </div>
                    </div>
                </div>
            </div>

            <div class="row middle-middle">
                <div id="recruit" class="col-md-4">
                    <div class="list">
                        <!-- 列表头部 -->
                        <header>
                            <h1 style="text-align: center">最新招聘</h1>
                        </header>
                        <!-- 列表项组 -->
                        <section class="items items-hover">
                            <c:forEach items="${requestScope.jobList }" var="job">
                                <div class="item">
                                    <div class="item-heading">
                                        <div class="pull-right label label-success">recruit</div>
                                        <h4><a target="_blank" href="jobDetail?id=${job.id}">${job.tittle}</a></h4>
                                    </div>
                                    <div class="item-footer">
                                        <span class="text-muted">发布时间：${job.createTime}</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </section>
                    </div>
                </div>

                <div id="notice" class="col-md-4">
                    <div class="list">
                        <!-- 列表头部 -->
                        <header>
                            <h1 style="text-align: center">最新公告</h1>
                        </header>
                        <!-- 列表项组 -->
                        <section class="items items-hover">
                            <c:forEach items="${requestScope.noticeList }" var="notice">
                                <div class="item">
                                    <div class="item-heading">
                                        <div class="pull-right label label-success">notice</div>
                                        <h4><a target="_blank" href="noticeDetail?id=${notice.id}">${notice.tittle}</a></h4>
                                    </div>
                                    <div class="item-footer">
                                        <span class="text-muted">发布时间：${notice.publishTime}</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </section>
                    </div>
                </div>

                <div id="news" class="col-md-4">
                    <div class="list">
                        <!-- 列表头部 -->
                        <header>
                            <h1 style="text-align: center">时事新闻</h1>
                        </header>
                        <!-- 列表项组 -->
                        <section class="items items-hover">
                            <c:forEach items="${requestScope.newsList }" var="news">
                                <div class="item">
                                    <div class="item-heading">
                                        <div class="pull-right label label-success">notice</div>
                                        <h4><a target="_blank" href="newsDetail?id=${news.id}">${news.tittle}</a></h4>
                                    </div>
                                    <div class="item-footer">
                                        <span class="text-muted">发布时间：${news.publishTime}</span>
                                    </div>
                                </div>
                            </c:forEach>
                        </section>
                    </div>
                </div>
            </div>
        </div>

    </div>

    <div class="bottom">
        <div class="bottom-text">
            <p>Copyright © 2017-2018 <a target="_blank" href="http://www.shzu.edu.cn" style="color: red">石河子大学</a> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 备案/许可证编号：京ICP备18001038 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp powered by Kinson</p>
            <p>地址：新疆维吾尔自治区石河子市石河子大学 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 邮编：832000 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 邮箱：kinsonvip@gmail.com</p>
        </div>
    </div>
</div>
<script src="jquery/jquery-3.2.1.min.js"></script>
<!-- ZUI Javascript组件 -->
<script src="zui/js/zui.min.js"></script>
<script>
    $(function () {

    })
</script>
</body>
</html>