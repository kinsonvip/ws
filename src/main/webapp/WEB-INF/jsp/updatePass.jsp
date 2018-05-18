<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>修改密码</title>
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

    <span  name="gotop"></span>

    <div class="middle" style="height: 510px;background-color: #F1F1F1">
        <div class="container-fluid">
            <div class="col-md-offset-3 col-md-6">
                <h2 class="text-center" style="margin-top: 20%">修改密码</h2>
                <div class="row" style="margin-top: 20px">
                    <label class="col-md-offset-2 col-md-2"><h5><i style="color: red">*</i>原密码：</h5></label>
                    <div class="col-md-6">
                        <input type="password" class="form-control" id="oldPassword" placeholder="请输入原密码">
                    </div>
                </div>
                <div class="row" style="margin-top: 20px">
                    <label class="col-md-offset-2 col-md-2"><h5><i style="color: red">*</i>新密码：</h5></label>
                    <div class="col-md-6">
                        <input type="password" class="form-control" id="newPassword" placeholder="请输入新密码">
                    </div>
                </div>
                <div class="row" style="margin-top: 20px">
                    <label class="col-md-offset-2 col-md-2"><h5><i style="color: red">*</i>确认密码：</h5></label>
                    <div class="col-md-6">
                        <input type="password" class="form-control" id="confirmPassword" placeholder="请确认密码">
                    </div>
                </div>
                <h4 class="text-center" style="color: red" id="msg"></h4>
                <button title="修改信息" style="float: right;margin-top: 5px;margin-right: 20%" onclick="confirm()" type="button" class="btn btn-info">修改</button>
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

    <div class="modal fade" id="confirmModal">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                    <h4 class="modal-title">确定修改密码</h4>
                </div>
                <div class="modal-body">
                    确认要修改密码吗？
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="updateBtn">确定</button>
                </div>
            </div>
        </div>
    </div>

</div>
<script src="js/public.js"></script>
<script src="jquery/jquery-3.2.1.min.js"></script>
<!-- ZUI Javascript组件 -->
<script src="zui/js/zui.min.js"></script>
<script>
    $(function () {
        $('#updateBtn').click(function () {
            $('#confirmModal').modal('hide');
            var oldPassword = $('#oldPassword').val();
            var newPassword = $('#newPassword').val();
            $.ajax({
                type: "post",
                url: 'updatePassword',
                data: {
                    "oldPassword":oldPassword,
                    "newPassword":newPassword,
                },
                cache: false,
                async : false,
                dataType: "json",
                success: function (data ,textStatus, jqXHR){
                    if("success"==data.status){
                        $("#msg").html("");
                        new $.zui.Messager('操作成功!即将重新登陆', {
                            icon:'ok',
                            type: 'success',
                            time: 0
                        }).show();
                        setTimeout(function() {
                            window.location.href="login";
                        }, 3000);
                    }else {
                        $("#msg").html(data.msg)
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
        })
    })

    function confirm() {
        if($('#newPassword').val()==$('#confirmPassword').val()){
            $("#msg").html("");
            $('#confirmModal').modal('show', 'fit');
        }else{
            $("#msg").html("新密码两次输入不一致!!")
        }

    }
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