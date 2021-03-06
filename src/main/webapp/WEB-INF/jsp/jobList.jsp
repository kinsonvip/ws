<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>招聘信息</title>
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
                        <li><h4 style="color: white;margin-left: 20px;margin-right: 20px">|</h4></li>
                        <li><a href="cenInfo">中心简介</a></li>
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
                        <shiro:hasRole name="1">
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
                        </shiro:hasRole>
                    </ul>
                </div><!-- END .navbar-collapse -->
            </div>
        </nav>
    </div>

    <span  name="gotop"></span>

    <div class="middle">
        <div class="container-fluid">
            <div class="col-md-offset-2 col-md-8">
                <div class="list">
                    <!-- 列表头部 -->
                    <header>
                        <h1 style="text-align: center">招聘信息</h1>
                    </header>
                    <!-- 列表项组 -->
                    <section class="items items-hover">
                        <c:forEach items="${requestScope.jobList }" var="job">
                            <div class="item">
                                <div class="item-heading">
                                    <div class="pull-right"><span class="text-muted">所属部门：${job.depName}</span></div>
                                    <h4><a target="_blank" href="jobDetail?id=${job.id}">${job.tittle}</a></h4>
                                </div>
                                <div class="item-footer">
                                    <span class="text-muted">发布时间：${job.createTime}</span>
                                </div>
                            </div>
                        </c:forEach>
                    </section>
                    <div style="text-align: center;margin-top: 2%"><span id="tip" style="display: none"><h4>别拉了，到底了，真的没有了~~</h4></span></div>
                </div>
            </div>
        </div>
    </div>

    <a href="#gotop">
        <img data-toggle="tooltip" data-tip-class="tooltip-info" title="去顶部" src="pictures/toTop.png" id="gotop" style="position: fixed;right:40px;bottom: 120px;display: none;">
    </a>
    <div class="bottom">
        <div class="bottom-text">
            <p>Copyright © 2017-2018 <a target="_blank" href="http://www.shzu.edu.cn" style="color: red">石河子大学</a> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 备案/许可证编号：京ICP备18001038 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp powered by Kinson</p>
            <p>地址：新疆维吾尔自治区石河子市石河子大学 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 邮编：832000 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 邮箱：kinsonvip@gmail.com</p>
        </div>
    </div>

</div>
<script src="js/public.js"></script>
<script src="jquery/jquery-3.2.1.min.js"></script>
<!-- ZUI Javascript组件 -->
<script src="zui/js/zui.min.js"></script>
<script>
    var pageNum = 2;
    var pageSize = 10;
    $(function () {
        var pages = ${requestScope.pages};
        var winH = $(window).height(); //页面可视区域高度
        $(window).scroll(function() {
            var pageH = $(document.body).height();
            var scrollT = $(window).scrollTop(); //滚动条top
            var aa = (pageH - winH - scrollT) / winH;
            if (aa < 0.02 && pageNum<=pages) {
                $.ajax({
                    type: "post",
                    url: 'loadJobList',
                    data: {"pageSize":pageSize,"pageNum":pageNum},
                    cache: false,
                    async : false,
                    dataType: "json",
                    success: function (data ,textStatus, jqXHR){
                        if("success"==data.status){
                            $.each(data.jobList,function (i,job) {
                                var str ="<div class=\"item\">\n" +
                                    "                                <div class=\"item-heading\">\n" +
                                    "                                    <div class=\"pull-right\"><span class=\"text-muted\">所属部门："+job.depName+"</span></div>\n" +
                                    "                                    <h4><a href=\"jobDetail?id="+job.id+"\">"+job.tittle+"</a></h4>\n" +
                                    "                                </div>\n" +
                                    "                                <div class=\"item-footer\">\n" +
                                    "                                    <span class=\"text-muted\">发布时间："+job.createTime+"</span>\n" +
                                    "                                </div>\n" +
                                    "                            </div>";
                                $(".items").append(str);
                            })
                            pageNum++;
                        }
                    },
                    error:function (jqXHR, textStatus, errorThrown) {
                        new $.zui.Messager('操作失败!', {
                            icon:'warning-sign',
                            type: 'warning',
                            time: 2000
                        }).show();
                    }
                });
            }else if(aa < 0.02 && pageNum>pages) {
                $('#tip').attr("style","display:block;");
            }
        });

    })
</script>
<script>
    $(function () {
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