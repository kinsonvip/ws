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
            <div class="col-md-offset-2 col-md-8">
                <article class="article">
                    <section class="content" style="text-indent: 2em">
                        <p>1、负责全校学生奖助学金工作，完善我校助学体系;</p>
                        <p>2、做好贫困生认定工作，建立和维护贫困家庭学生档案数据库;</p>
                        <p>3、会同经办银行认真落实国家助学贷款银校合作协议;</p>
                        <p>4、负责做好我校国家助学贷款需求额度上报工作;</p>
                        <p>5、负责国家助学贷款的咨询、资格审核及协助发放、贷后管理和诚信教育;</p>
                        <p>6、按期向教育部全国学生管理中心报送国家助学贷款工作进展情况;</p>
                        <p>7、负责国家助学贷款学生个人信息采集、汇总及上报工作;</p>
                        <p>8、国家助学贷款代偿资助的宣传、动员，报送申请国家助学贷款代偿资助学生材料工作;</p>
                        <p>9、负责办理继续攻读硕士学位的贷款毕业生展期手续;</p>
                        <p>10、负责我校国家奖学金、国家励志奖学金、国家助学金的评审和发放;并监督获奖学生奖助学金的使用;</p>
                        <p>11、联络、评审和发放社会各类奖助学金;</p>
                        <p>12、负责临时困难补助;</p>
                        <p>13、负责全校勤工助学活动的管理，开辟和管理勤工助学岗位;</p>
                        <p>14、完成上级交办的其他任务。</p>
                    </section>
                </article>
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
<script src="js/public.js"></script>
<script src="jquery/jquery-3.2.1.min.js"></script>
<!-- ZUI Javascript组件 -->
<script src="zui/js/zui.min.js"></script>
</body>
</html>