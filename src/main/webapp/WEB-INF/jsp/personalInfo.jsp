<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>个人信息</title>
    <link href="css/public.css" type="stylesheet">
    <!-- zui -->
    <link href="zui/css/zui.css" rel="stylesheet">
    <link href="zui/css/zui-theme.css" rel="stylesheet">
    <link href="zui/lib/datetimepicker/datetimepicker.min.css" rel="stylesheet">

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

    <div class="middle" style="height: 700px;background-color: #F1F1F1">
        <div class="container-fluid">
            <div class="col-md-offset-2 col-md-8">
                <article class="article">
                    <header>
                        <h1 class="text-center">个人信息</h1>
                        <dl class="dl-inline">
                            <dt>学院：</dt>
                            <dd class="acaName"></dd>
                            <dt>专业：</dt>
                            <dd class="majName"></dd>
                            <dt>学号：</dt>
                            <dd class="stuNum"></dd>
                            <dt>上次登录时间：</dt>
                            <dd class="lastLoginTime"></dd>
                        </dl>
                    </header>
                    <section class="content" style="text-indent: 2em">
                        <div class="row" style="margin-top: 15px">
                            <div class="col-md-4"><strong>姓名：</strong><span class="stuName"></span></div>
                            <div class="col-md-4"><strong>昵称：</strong><span class="nickName"></span></div>
                            <div class="col-md-4"><strong>性别：</strong><span class="sex"></span></div>
                        </div>
                        <div class="row" style="margin-top: 15px">
                            <div class="col-md-4"><strong>出身日期：</strong><span class="birth"></span></div>
                            <div class="col-md-4"><strong>民族：</strong><span class="ethnic"></span></div>
                            <div class="col-md-4"><strong>政治面貌：</strong><span class="policitalStatus"></span></div>
                        </div>
                        <div class="row" style="margin-top: 15px">
                            <div class="col-md-6"><strong>手机号：</strong><span class="phone"></span></div>
                            <div class="col-md-6"><strong>邮箱：</strong><span class="email"></span></div>
                        </div>
                        <div class="row" style="margin-top: 15px">
                            <div class="col-md-6"><strong>身份证号：</strong><span class="idCard"></span></div>
                            <div class="col-md-6"><strong>银行卡号：</strong><span class="bankCard"></span></div>
                        </div>
                    </section>
                    <footer>
                        <button title="修改信息" style="float: right;margin-top: 5px;margin-bottom: 5px" onclick="showUpdate()" type="button" class="btn btn-info" value=""><i class="icon icon-edit"></i>  修改</button>
                    </footer>
                </article>
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

    <div class="modal fade" id="updateModal">
        <div class="modal-dialog modal-lg">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                    <h4 class="modal-title">修改资料</h4>
                </div>
                <div class="modal-body">
                    <form id="updateForm">
                        <div class="row">
                            <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>昵称：</h5></label>
                            <div class="col-md-2 col-sm-2" style="margin-right: 15%">
                                <input type="text" class="form-control" id="nickName" placeholder="请输入昵称" data-rule="昵称: required">
                            </div>
                            <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>出生日期：</h5></label>
                            <div class="col-md-2 col-sm-2">
                                <input type="text" class="form-control form-date" id="birth">
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>民族：</h5></label>
                            <div class="col-md-2 col-sm-2 has-label-right" style="margin-right: 15%">
                                <input type="text" class="form-control" id="ethnic" placeholder="民族如：（汉）" data-rule="民族: required">
                                <label for="ethnic" class="input-control-label-right text-right text-success" style="margin-right: 5px">族</label>
                            </div>
                            <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>政治面貌：</h5></label>
                            <div class="col-md-2 col-sm-2">
                                <select class="form-control" id="policitalStatus">
                                    <option value="团员">团员</option>
                                    <option value="党员">党员</option>
                                    <option value="预备党员">预备党员</option>
                                    <option value="群众">群众</option>
                                </select>
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>手机号：</h5></label>
                            <div class="col-md-2 col-sm-2" style="margin-right: 15%">
                                <input type="text" class="form-control" id="phone" placeholder="请输入手机号" data-rule="手机号: required;mobile">
                            </div>
                            <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>邮箱：</h5></label>
                            <div class="col-md-2 col-sm-2">
                                <input type="text" class="form-control" id="email" placeholder="请输入邮箱" data-rule="邮箱: required;email">
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>身份证：</h5></label>
                            <div class="col-md-2 col-sm-2" style="margin-right: 15%">
                                <input type="text" class="form-control" id="idCard" placeholder="请输入身份证号" data-rule="身份证号: required;IDcard">
                            </div>
                            <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>银行卡号：</h5></label>
                            <div class="col-md-2 col-sm-2">
                                <input type="text" class="form-control" id="bankCard" placeholder="请输入银行卡号" data-rule="银行卡号: required;bankcard">
                            </div>
                        </div>
                    </form>
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
<script src="zui/lib/datetimepicker/datetimepicker.min.js"></script>
<!-- Validator插件 -->
<script src="jquery/validator/dist/jquery.validator.js?local=zh-CN"></script>
<script>
    $(function () {
        $(".form-date").datetimepicker(
            {
                language:  "zh-CN",
                weekStart: 1,
                todayBtn:  1,
                autoclose: 1,
                todayHighlight: 1,
                startView: 2,
                minView: 2,
                forceParse: 0,
                format: "yyyy-mm-dd"
            });

        $('.acaName').html("${requestScope.studentInfo.acaName}");
        $('.majName').html("${requestScope.studentInfo.majName}");
        $('.stuNum').html("${requestScope.studentInfo.stuNum}");
        $('.lastLoginTime').html("${requestScope.studentInfo.lastLoginTime}");
        $('.stuName').html("${requestScope.studentInfo.stuName}");
        $('.nickName').html("${requestScope.studentInfo.nickName}");
        $('.sex').html("${requestScope.studentInfo.sex}");
        $('.birth').html("${requestScope.studentInfo.birth}");
        $('.ethnic').html("${requestScope.studentInfo.ethnic}");
        $('.policitalStatus').html("${requestScope.studentInfo.policitalStatus}");
        $('.phone').html("${requestScope.studentInfo.phone}");
        $('.email').html("${requestScope.studentInfo.email}");
        $('.idCard').html("${requestScope.studentInfo.idCard}");
        $('.bankCard').html("${requestScope.studentInfo.bankCard}");

        $('#updateBtn').click(function () {
            var nickName = $('#nickName').val();
            var birth = $('#birth').val();
            var ethnic = $('#ethnic').val();
            var policitalStatus = $('#policitalStatus').val();
            var phone = $('#phone').val();
            var email = $('#email').val();
            var idCard = $('#idCard').val();
            var bankCard = $('#bankCard').val();
            if ($('#updateForm').isValid()){
                $('#updateModal').modal('hide');
                $.ajax({
                    type: "post",
                    url: 'updateStudent',
                    data: {
                        "nickName":nickName,
                        "day":birth,
                        "ethnic":ethnic,
                        "policitalStatus":policitalStatus,
                        "phone":phone,
                        "email":email,
                        "idCard":idCard,
                        "bankCard":bankCard
                    },
                    cache: false,
                    async : false,
                    dataType: "json",
                    success: function (data ,textStatus, jqXHR){
                        if("success"==data.status){
                            location.reload();
                            new $.zui.Messager('操作成功!', {
                                icon:'ok',
                                type: 'success',
                                time: 2000
                            }).show();
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
            }
        })
    })

    function showUpdate() {
        $('#nickName').val("${requestScope.studentInfo.nickName}");
        $('#birth').val("${requestScope.studentInfo.birth}");
        $('#ethnic').val("${requestScope.studentInfo.ethnic}");
        $('#policitalStatus').val("${requestScope.studentInfo.policitalStatus}");
        $('#phone').val("${requestScope.studentInfo.phone}");
        $('#email').val("${requestScope.studentInfo.email}");
        $('#idCard').val("${requestScope.studentInfo.idCard}");
        $('#bankCard').val("${requestScope.studentInfo.bankCard}");

        $('#updateModal').modal('show', 'fit');
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