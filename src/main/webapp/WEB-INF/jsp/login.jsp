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

</head>
<style>
    *{margin: 0; padding: 0; box-sizing: border-box;}

    #bg{
        background: url(pictures/starsky.jpg) no-repeat;
        background-size: cover;
        background-position: center center;
    }

    #canvas{
        position: absolute;
        top: 0;
        left: 0;
    }
</style>
<body id="bg">
<canvas id="canvas"></canvas>
<div class="container">
    <div class="row" style="height: auto;margin-top: 24%">
        <div class="col-md-4 col-md-offset-4" >
            <h3 id="erro" style="color: white"></h3>
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
                    <a onclick="changeVcode()" class="input-control-icon-right" style="margin-right: 70%"><i class="icon icon-refresh"></i></a>
                    <input type="text" name="vcode" id="vcode" class="form-control" style="width: 30%;float: left" placeholder="验证码">
                    <img style="border-radius: 5px" onclick="changeVcode()" alt="验证码" src="${pageContext.request.contextPath}/getGifCode" id="vcodeImg">
                    <div style="width: 37%;float: right">
                        <select class="form-control input-control" id="role">
                            <option value ="学生">学生</option>
                            <option value="用人部门人员">用人部门人员</option>
                            <option value="系统管理员">系统管理员</option>
                        </select>
                    </div>

                </div>
                <div class="form-group input-control">
                    <input type="checkbox" name="rememberMe"  id="rememberMe" /><span style="color:white">七天内免登录</span>
                    <a style="margin-left: 25%;display: none" onclick="regist()" id="regist">注册账号</a>
                </div>
                <div class="form-group input-control">
                    <input type="button" id="login" class="btn btn-primary" value="登录" />
                </div>
            </form>
        </div>
    </div>
</div>

<div class="modal fade" id="registModal">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                <h4 class="modal-title">账号申请</h4>
            </div>
            <div class="modal-body">
                <div class="row">
                    <label class="col-md-4"><h5><i style="color: red">*</i>账号：</h5></label>
                    <div class="col-md-8">
                        <input type="text" class="form-control" id="inputAccountNum" placeholder="请输入账号">
                    </div>
                </div>
                <div class="row">
                    <label class="col-md-4"><h5><i style="color: red">*</i>密码：</h5></label>
                    <div class="col-md-8">
                        <input type="text" class="form-control" id="inputPassword" placeholder="请输入密码">
                    </div>
                </div>
                <div class="row">
                    <label class="col-md-4"><h5><i style="color: red">*</i>确认密码：</h5></label>
                    <div class="col-md-8">
                        <input type="text" class="form-control" id="inputConfirmPassword" placeholder="请确认密码">
                    </div>
                </div>
                <div class="row">
                    <label class="col-md-4"><h5><i style="color: red">*</i>部门：</h5></label>
                    <div class="col-md-8">
                        <select class="form-control" id="inputDep">

                        </select>
                    </div>
                </div>
                <div class="row">
                    <label class="col-md-4"><h5><i style="color: red">*</i>姓名：</h5></label>
                    <div class="col-md-8">
                        <input type="text" class="form-control" id="inputName" placeholder="请确认姓名">
                    </div>
                </div>
                <div class="row">
                    <label class="col-md-4"><h5><i style="color: red">*</i>电话：</h5></label>
                    <div class="col-md-8">
                        <input type="text" class="form-control" id="inputPhone" placeholder="请确认电话">
                    </div>
                </div>
                <div class="row">
                    <label class="col-md-4"><h5><i style="color: red">*</i>邮箱：</h5></label>
                    <div class="col-md-8">
                        <input type="text" class="form-control" id="inputEmail" placeholder="请确认邮箱">
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="registBtn">确定</button>
            </div>
        </div>
    </div>
</div>

<script src="jquery/jquery-3.2.1.min.js"></script>
<!-- ZUI Javascript组件 -->
<script src="zui/js/zui.min.js"></script>

<script src="js/dots.js"></script>
<script src="js/main.js"></script>
<script>
    $(function(){
        $('#role').change(function () {
            if($(this).val()=="用人部门人员"){
                $('#regist').show()
            }else{
                $('#regist').hide()
            }
        })

        $("#registBtn").click(function () {
            if($("#inputPassword").val()!=$("#inputConfirmPassword").val()){
                new $.zui.Messager('两次密码输入不一致', {
                    icon:'warning-sign',
                    type: 'warning',
                    time: 4000
                }).show();
            }
            $('#registModal').modal('hide');
            var accountNum = $("#inputAccountNum").val();
            var password = $("#inputPassword").val();
            var depName = $("#inputDep").val();
            var name = $("#inputName").val();
            var phone = $("#inputPhone").val();
            var email = $("#inputEmail").val();

            $.ajax({
                type: "post",
                url: 'addDepSys',
                data: {
                    "accountNum":accountNum,
                    "password":password,
                    "depName":depName,
                    "name":name,
                    "phone":phone,
                    "email":email,
                },
                cache: false,
                async : false,
                dataType: "json",
                success: function (data ,textStatus, jqXHR){
                    if("success"==data.status){
                        new $.zui.Messager('注册成功，等待管理员审核!', {
                            icon:'ok',
                            type: 'success',
                            time: 4000
                        }).show();
                    }else {
                        $('#erro').html(data.msg);
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

        $("#login").click(function() {
            var role = $("#role").val();
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
                    if(role=='学生'){
                        location.href = "${pageContext.request.contextPath}/index";
                    }else if(role=='用人部门人员'){
                        location.href = "${pageContext.request.contextPath}/depsys/index";
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

    function regist(){
        $("#inputAccountNum").val("");
        $("#inputPassword").val("");
        $("#inputConfirmPassword").val("");
        $("#inputDep").val("");
        $("#inputName").val("");
        $("#inputPhone").val("");
        $("#inputEmail").val("");
        $.ajax({
            type: "post",
            url: 'getDepList',
            cache: false,
            async : false,
            dataType: "json",
            success: function (data ,textStatus, jqXHR){
                if("success"==data.status){
                    var str = "";
                    for(var i = 0;i<data.depList.length;i++){
                        str += "<option value ='"+data.depList[i]+"'>"+data.depList[i]+"</option>"
                    }
                    $('#inputDep').html(str);
                }
            },
            error:function (jqXHR, textStatus, errorThrown) {
                new $.zui.Messager('加载部门列表失败!', {
                    icon:'warning-sign',
                    type: 'warning',
                    time: 2000
                }).show();
            }
        });
        $('#registModal').modal('show', 'fit');
    }
</script>
</body>
</html>