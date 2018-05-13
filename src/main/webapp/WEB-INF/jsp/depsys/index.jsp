<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE HTML>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit|ie-comp|ie-stand">
    <meta http-equiv="X-UA-Compatible" content="IE=edge,chrome=1">
    <meta name="viewport"
          content="width=device-width,initial-scale=1,minimum-scale=1.0,maximum-scale=1.0,user-scalable=no"/>
    <meta http-equiv="Cache-Control" content="no-siteapp"/>
    <!--[if lt IE 9]>
    <script type="text/javascript" src="../H-ui/lib/html5shiv.js"></script>
    <script type="text/javascript" src="../H-ui/lib/respond.min.js"></script>
    <![endif]-->
    <link rel="stylesheet" type="text/css" href="../H-ui/static/h-ui/css/H-ui.min.css"/>
    <link rel="stylesheet" type="text/css" href="../H-ui/static/h-ui.admin/css/H-ui.admin.css"/>
    <link rel="stylesheet" type="text/css" href="../H-ui/lib/Hui-iconfont/1.0.8/iconfont.css"/>
    <link rel="stylesheet" type="text/css" href="../H-ui/static/h-ui.admin/skin/default/skin.css" id="skin"/>
    <link rel="stylesheet" type="text/css" href="../H-ui/static/h-ui.admin/css/style.css"/>
    <!--[if IE 6]>
    <script type="text/javascript" src="../H-ui/lib/DD_belatedPNG_0.0.8a-min.js"></script>
    <script>DD_belatedPNG.fix('*');</script>
    <![endif]-->
    <title>用人部门后台管理</title>
    <link rel="icon" href="../icon/university.jpg">
</head>
<body>
<header class="navbar-wrapper">
    <div class="navbar navbar-fixed-top">
        <div class="container-fluid cl"><span class="logo navbar-slogan f-l mr-10 hidden-xs" style="font-size:18px"><i class="Hui-iconfont">&#xe72b;</i>用人部门管理后台V1.0</span>
            <nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
                <ul class="cl">
                    <shiro:hasRole name="2">
                        <li>欢迎登录！用人部门管理员</li>
                    </shiro:hasRole>
                    <li class="dropDown dropDown_hover">
                        <a href="#" class="dropDown_A">
                            <i class="Hui-iconfont">&#xe62d;</i>
                            <shiro:user>
                                [<shiro:principal property="nickName"/>]
                            </shiro:user>
                            <i class="Hui-iconfont">&#xe6d5;</i>
                        </a>
                        <ul class="dropDown-menu menu radius box-shadow">
                            <li><a href="javascript:;" onClick="myselfinfo()"><i class="Hui-iconfont">&#xe705;</i>&nbsp;&nbsp;个人信息</a></li>
                            <li><a href="javascript:;" onClick="updatePassword()"><i class="Hui-iconfont">&#xe63f;</i>&nbsp;&nbsp;密码修改</a></li>
                            <li><a href="${pageContext.request.contextPath}/login"><i class="Hui-iconfont">&#xe62b;</i>切换账户</a></li>
                            <li><a href="${pageContext.request.contextPath}/logout"><i class="Hui-iconfont">&#xe726;</i>退出</a></li>
                        </ul>
                    </li>
                    <li id="Hui-skin" class="dropDown right dropDown_hover">
                        <a href="javascript:;" class="dropDown_A" title="换肤"><i class="Hui-iconfont" style="font-size:18px">&#xe62a;</i></a>
                        <ul class="dropDown-menu menu radius box-shadow"  style="width: 70px">
                            <li style="background-color: #222"><a href="javascript:;" data-val="default" title="默认（黑色）">黑色</a></li>
                            <li style="background-color: #00a0e9"><a href="javascript:;" data-val="blue" title="蓝色">蓝色</a></li>
                            <li style="background-color: #19a97b"><a href="javascript:;" data-val="green" title="绿色">绿色</a></li>
                            <li style="background-color: #f43838"><a href="javascript:;" data-val="red" title="红色">红色</a></li>
                            <li style="background-color: #ffd200"><a href="javascript:;" data-val="yellow" title="黄色">黄色</a></li>
                            <li style="background-color: #f89406"><a href="javascript:;" data-val="orange" title="橙色">橙色</a></li>
                        </ul>
                    </li>
                </ul>
            </nav>
        </div>
    </div>
</header>
<aside class="Hui-aside">
    <div class="menu_dropdown bk_2">
        <dl id="menu-job">
            <dt><i class="Hui-iconfont">&#xe637;</i>&nbsp;&nbsp;岗位管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="uncheckedJob" data-title="审核中岗位" href="javascript:void(0)"><i class="Hui-iconfont">&#xe702;</i>&nbsp;&nbsp;审核中岗位</a></li>
                    <li><a data-href="checkedJob" data-title="已审核岗位" href="javascript:void(0)"><i class="Hui-iconfont">&#xe6ff;</i>&nbsp;&nbsp;已审核岗位</a></li>
                </ul>
            </dd>
        </dl>
        <dl id="menu-contract">
            <dt><i class="Hui-iconfont">&#xe636;</i>&nbsp;&nbsp;合同管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="unconfirmedContract" data-title="待确认合同" href="javascript:void(0)"><i class="Hui-iconfont">&#xe702;</i>&nbsp;&nbsp;待确认合同</a></li>
                    <li><a data-href="confirmedContract" data-title="已确认合同" href="javascript:void(0)"><i class="Hui-iconfont">&#xe6ff;</i>&nbsp;&nbsp;已确认合同</a></li>
                </ul>
            </dd>
        </dl>
        <dl id="menu-evaluate">
            <dt><i class="Hui-iconfont">&#xe611;</i>&nbsp;&nbsp;学生评价<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="unevaluatedContract" data-title="待评价" href="javascript:void(0)"><i class="Hui-iconfont">&#xe702;</i>&nbsp;&nbsp;待评价</a></li>
                    <li><a data-href="evaluatedContract" data-title="已评价" href="javascript:void(0)"><i class="Hui-iconfont">&#xe6ff;</i>&nbsp;&nbsp;已评价</a></li>
                </ul>
            </dd>
        </dl>
    </div>
</aside>
<div class="dislpayArrow hidden-xs"><a class="pngfix" href="javascript:void(0);" onClick="displaynavbar(this)"></a>
</div>
<section class="Hui-article-box">
    <div id="Hui-tabNav" class="Hui-tabNav hidden-xs">
        <div class="Hui-tabNav-wp">
            <ul id="min_title_list" class="acrossTab cl">
                <li class="active">
                    <span title="我的桌面" data-href="welcome">我的桌面</span>
                    <em></em>
                </li>
            </ul>
        </div>
        <div class="Hui-tabNav-more btn-group">
            <a id="js-tabNav-prev" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d4;</i></a>
            <a id="js-tabNav-next" class="btn radius btn-default size-S" href="javascript:;"><i class="Hui-iconfont">&#xe6d7;</i></a>
        </div>
    </div>
    <div id="iframe_box" class="Hui-article">
        <div class="show_iframe">
            <div style="display:none" class="loading"></div>
            <iframe scrolling="yes" frameborder="0" src="welcome"></iframe>
        </div>
    </div>
</section>

<div class="contextMenu" id="Huiadminmenu">
    <ul>
        <li id="closethis">关闭当前</li>
        <li id="closeall">关闭全部</li>
    </ul>
</div>
<!--_footer 作为公共模版分离出去-->
<script type="text/javascript" src="../H-ui/lib/jquery/1.9.1/jquery.min.js"></script>
<script type="text/javascript" src="../H-ui/lib/layer/2.4/layer.js"></script>
<script type="text/javascript" src="../H-ui/static/h-ui/js/H-ui.min.js"></script>
<script type="text/javascript" src="../H-ui/static/h-ui.admin/js/H-ui.admin.js"></script> <!--/_footer 作为公共模版分离出去-->

<!--请在下方写此页面业务相关的脚本-->
<script type="text/javascript" src="../H-ui/lib/jquery.contextmenu/jquery.contextmenu.r2.js"></script>
<script type="text/javascript">
    /*个人信息*/
    function myselfinfo() {
        layer.open({
            type: 2,
            title: '个人详情',
            shadeClose: true,
            shade: 0.8,
            area: ['680px', '60%'],
            content: 'personalInfo' //iframe的url
        });
    }

    function updatePassword() {
        layer.open({
            type: 2,
            title: '密码修改',
            shadeClose: true,
            shade: 0.8,
            area: ['680px', '65%'],
            content: 'updatePass' //iframe的url
        });
    }
</script>
</body>
</html>