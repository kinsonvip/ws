<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>登陆</title>
    <!-- zui -->
    <link href="zui/css/zui.min.css" rel="stylesheet">
    <link href="css/public.css" type="text/css" rel="stylesheet">
</head>
<body>

<div class="container">

    <div class="row" style="height: auto;margin-top: 100px">
        <div class="col-md-4 col-md-offset-4" >
            <h4 id="erro"></h4>
            <form>
                <div class="form-group input-control has-icon-left">
                    <input id="userName" name="userName" type="text" class="form-control" placeholder="账    号">
                    <label for="userName" class="input-control-icon-left"><i class="icon icon-user "></i></label>
                </div>
                <div class="form-group input-control has-icon-left">
                    <input id="passWord" name="passWord" type="password" class="form-control" placeholder="密    码">
                    <label for="passWord" class="input-control-icon-left"><i class="icon icon-key "></i></label>
                </div>
                <div class="form-group input-control has-icon-left has-icon-right">
                    <label for="vcode" class="input-control-icon-left"><i class="icon icon-barcode"></i></label>
                    <a onclick="changeVcode()" class="input-control-icon-right" style="margin-right: 40%"><i class="icon icon-refresh"></i></a>
                    <input type="text" name="vcode" id="vcode" class="form-control" style="width: 60%;float: left" placeholder="请输入右侧验证码">
                    <img onclick="changeVcode()" alt="验证码" src="${pageContext.request.contextPath}/getGifCode" id="vcodeImg">
                </div>
                <div class="form-group input-control">
                    <label class="radio-inline">
                        <input name="role" type="radio" value="student" checked> 学生
                    </label>
                    <label class="radio-inline">
                        <input name="role" type="radio" value="empDepSys"> 用人部门管理人员
                    </label>
                    <label class="radio-inline">
                        <input name="role" type="radio" value="sys"> 系统管理员
                    </label>
                </div>
                <div class="form-group input-control has-icon-left">
                    <P><input type="checkbox" name="rememberMe"  id="rememberMe" />七天内免登录</P>
                </div>
                <%--<button id="login" class="btn btn-primary">提交</button>--%>
                <input type="button" id="login" class="btn btn-primary" value="登录" />
            </form>
        </div>
    </div>
</div>

<script src="jquery/jquery-3.2.1.min.js"></script>
<!-- ZUI Javascript组件 -->
<script src="zui/js/zui.min.js"></script>
<script>
    $(function(){
        $("#login").click(function() {
            var role = $("input[type='radio']:checked").val();
            var userName = $("#userName").val();
            var passWord = $("#passWord").val();
            var vcode = $("#vcode").val();
            var rememberMe =$('#rememberMe').is(':checked');
            $.post("doLogin", {
                "role" : role,
                "userName" : userName,
                "passWord" : passWord,
                "vcode" : vcode,
                "rememberMe" : rememberMe
            }, function(result) {
                if (result.status == 200) {
                    if(role=='student'){
                        location.href = "${pageContext.request.contextPath}/grid";
                    }else if(role=='empDepSys'){
                        location.href = "www.baidu.com";
                    }else{
                        location.href = "${pageContext.request.contextPath}/admin/index";
                    }
                } else {
                    $("#erro").html(result.message);
                }
            });
        });
    });

    function changeVcode() {
        $('#vcodeImg').attr("src", "${pageContext.request.contextPath}/getGifCode?"+Math.random());
    }
</script>
</body>
</html>