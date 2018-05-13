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
    <!-- zui -->
    <link href="../zui/css/zui.css" rel="stylesheet">
    <link href="../zui/css/zui-theme.css" rel="stylesheet">

    <link href="../css/index.css" type="text/css" rel="stylesheet">
    <link rel="icon" href="../icon/university.jpg">
</head>
<body>
<div class="total">
    <span  name="gotop"></span>

    <div class="middle">
        <div class="container-fluid">
            <div class="col-md-offset-3 col-md-6">
                <h3 class="text-center" style="margin-top: 10%">修改密码</h3>
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
        <img data-toggle="tooltip" data-tip-class="tooltip-info" title="去顶部" src="../pictures/toTop.png" id="gotop" style="position: fixed;right:40px;bottom: 120px;display: none;">
    </a>

    <div class="modal fade" id="confirmModal" style="height: 60%;width: 50%;margin-left: 25%;margin-top: 10%;overflow-x: hidden;overflow-y: hidden; ">
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
<script src="../jquery/jquery-3.2.1.min.js"></script>
<!-- ZUI Javascript组件 -->
<script src="../zui/js/zui.min.js"></script>
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
                            top.location.reload();
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