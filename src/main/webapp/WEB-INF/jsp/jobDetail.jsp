<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>岗位详情</title>
    <link href="css/public.css" type="stylesheet">
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
                        <li><a href="your/nice/url">中心简介</a></li>
                        <li><a href="jobList">招聘信息</a></li>
                        <li><a href="noticeList">公告中心</a></li>
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
                                    <li><a href="your/nice/url"><i class="icon icon-info"></i>&nbsp&nbsp个人信息</a></li>
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

    <span  name="gotop"></span>

    <div class="middle">
        <div class="container-fluid">
            <div class="col-md-offset-2 col-md-8">
                <c:forEach items="${requestScope.job }" var="job">
                    <article class="article">
                        <header>
                            <h1 class="text-center">${job.tittle}</h1>
                            <dl class="dl-inline">
                                <dt>所属部门：</dt>
                                <dd>${job.depName}</dd>
                                <dt>创建人：</dt>
                                <dd>${job.createUser}</dd>
                                <dt>建立时间：</dt>
                                <dd>${job.createTime}</dd>
                                <dt>截止时间：</dt>
                                <dd>${job.endTime}</dd>
                            </dl>
                        </header>
                        <section class="content" style="text-indent: 2em">
                            <p><strong>岗位介绍：</strong><span>${job.jobDesc}</span></p>
                            <p><strong>工作地点：</strong><span>${job.addr}</span></p>
                            <p><strong>岗位要求：</strong><span>${job.jobReq}</span></p>
                            <p><strong>性别要求：</strong><span>${job.sexReq}</span></p>
                            <p><strong>需要人数：</strong><span>${job.requireNum}</span>人<strong>&nbsp&nbsp&nbsp&nbsp最大申请人数：</strong><span>${job.maxNum}</span>人<strong>&nbsp&nbsp&nbsp&nbsp已申请人数：</strong><span>${job.acceptNum}</span>人</p>
                            <p><strong>工作天数：</strong><span>${job.workdays}</span>天</p>
                            <p><strong>薪资：</strong><span>${job.salary}</span>元/天</p>
                            <p><strong>联系人：</strong><span>${job.linkMan}</span></p>
                            <p><strong>联系电话：</strong><span>${job.linkPhone}</span></p>
                        </section>
                        <footer>
                            <button title="申请职位" style="float: right;margin-top: 5px;margin-bottom: 5px" id="want" type="button" class="btn btn-lg btn-info" value="${job.jobId}"><i class="icon icon-heart"></i>  申请</button>
                        </footer>
                    </article>
                </c:forEach>
            </div>
        </div>
    </div>

    <a href="#gotop">
        <img data-toggle="tooltip" data-tip-class="tooltip-info" title="去顶部" src="pictures/toTop.png" id="gotop" style="position: fixed;right:40px;bottom: 120px;display: none;">
    </a>
    <div class="bottom">
        <div class="bottom-text">
            <p>Copyright © 2017-2018 <a href="http://www.shzu.edu.cn" style="color: red">石河子大学</a> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 备案/许可证编号：京ICP备18001038 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp powered by Kinson</p>
            <p>地址：新疆维吾尔自治区石河子市石河子大学 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 邮编：832000 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 邮箱：kinsonvip@gmail.com</p>
        </div>
    </div>

</div>
<script src="js/public.js"></script>
<script src="jquery/jquery-3.2.1.min.js"></script>
<!-- ZUI Javascript组件 -->
<script src="zui/js/zui.min.js"></script>
<script>
    $(function () {
        var maxNum = ${requestScope.job[0].maxNum};
        var acceptNum = ${requestScope.job[0].acceptNum};
        if(maxNum<=acceptNum){
            $('#want').attr("class","btn btn-lg btn-info disabled");
        }

        $('#want').click(function () {
            alert($(this).val());
        })

        $('[data-toggle="tooltip"]').tooltip();
        $(function(){
            $(window).scroll(function(){
                if($(window).scrollTop() > 100){
                    $("#gotop").fadeIn(1000);//一秒渐入动画
                }else{
                    $("#gotop").fadeOut(1000);//一秒渐隐动画
                }
            });
            $("#gotop").click(function(){
                $('body,html').animate({scrollTop:0},1000);
            });
        });
    });
</script>
</body>
</html>