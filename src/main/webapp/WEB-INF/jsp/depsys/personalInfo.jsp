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
    <link href="../css/public.css" type="stylesheet">
    <!-- zui -->
    <link href="../zui/css/zui.css" rel="stylesheet">
    <link href="../zui/css/zui-theme.css" rel="stylesheet">

    <link rel="icon" href="../icon/university.jpg">
</head>
<body>
<div class="total">
    <span  name="gotop"></span>

    <div class="middle">
        <div class="container-fluid">
            <div class="col-md-offset-2 col-md-8">
                <article class="article">
                    <header>
                        <h1 class="text-center">个人信息</h1>
                        <dl class="dl-inline">
                            <dt>账号：</dt>
                            <dd class="accountNum"></dd>
                            <dt>昵称：</dt>
                            <dd class="nickName"></dd>
                            <dt>上次登录时间：</dt>
                            <dd class="lastLoginTime"></dd>
                        </dl>
                    </header>
                    <section class="content" style="text-indent: 2em">
                        <p><strong>姓名：</strong><span class="userName"></span></p>
                        <p><strong>电话：</strong><span class="phone"></span></p>
                        <p><strong>邮箱：</strong><span class="email"></span></p>
                    </section>
                    <footer>
                        <button title="修改信息" style="float: right;margin-top: 5px;margin-bottom: 5px" onclick="showUpdate()" type="button" class="btn btn-info" value=""><i class="icon icon-edit"></i>  修改</button>
                    </footer>
                </article>
            </div>
        </div>
    </div>

    <a href="#gotop">
        <img data-toggle="tooltip" data-tip-class="tooltip-info" title="去顶部" src="../pictures/toTop.png" id="gotop" style="position: fixed;right:40px;bottom: 120px;display: none;">
    </a>

    <div class="modal fade" id="updateModal" style="height: 95%;width: 50%;margin-left: 25%;margin-top: 1%;overflow-x: hidden;overflow-y: hidden; ">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                    <h4 class="modal-title">修改资料</h4>
                </div>
                <div class="modal-body">
                    <form id="updateForm">
                        <div class="row">
                            <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>昵称：</h5></label>
                            <div class="col-md-4 col-sm-4" style="width: 50%">
                                <input type="text" class="form-control" id="nickName" placeholder="请输入昵称" data-rule="昵称: required">
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>电话：</h5></label>
                            <div class="col-md-4 col-sm-4" style="width: 50%">
                                <input type="text" class="form-control" id="phone" placeholder="请输入手机号" data-rule="手机号: required;mobile">
                            </div>
                            <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>邮箱：</h5></label>
                            <div class="col-md-4 col-sm-4" style="width: 50%">
                                <input type="text" class="form-control" id="email" placeholder="请输入邮箱" data-rule="邮箱: required;email">
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
<script src="../jquery/jquery-3.2.1.min.js"></script>
<!-- ZUI Javascript组件 -->
<script src="../zui/js/zui.min.js"></script>
<!-- Validator插件 -->
<script src="../jquery/validator/dist/jquery.validator.js?local=zh-CN"></script>
<script>
    $(function () {

        $('.accountNum').html("${requestScope.depsysInfo.accountNum}");
        $('.nickName').html("${requestScope.depsysInfo.nickName}");
        $('.lastLoginTime').html("${requestScope.depsysInfo.lastLoginTime}");
        $('.userName').html("${requestScope.depsysInfo.name}");
        $('.phone').html("${requestScope.depsysInfo.phone}");
        $('.email').html("${requestScope.depsysInfo.email}");

        $('#updateBtn').click(function () {
            var nickName = $('#nickName').val().trim();
            var phone = $('#phone').val().trim();
            var email = $('#email').val().trim();
            if ($('#updateForm').isValid()){
                $('#updateModal').modal('hide');
                $.ajax({
                    type: "post",
                    url: 'updateDepSys',
                    data: {
                        "nickName":nickName,
                        "phone":phone,
                        "email":email
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
        $('#nickName').val("${requestScope.depsysInfo.nickName}");
        $('#phone').val("${requestScope.depsysInfo.phone}");
        $('#email').val("${requestScope.depsysInfo.email}");
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