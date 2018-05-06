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
    <title>后台管理</title>
    <link rel="icon" href="../icon/university.jpg">
</head>
<body>
<header class="navbar-wrapper">
    <div class="navbar navbar-fixed-top">
        <div class="container-fluid cl"><span class="logo navbar-slogan f-l mr-10 hidden-xs" style="font-size:18px"><i class="Hui-iconfont">&#xe72b;</i>勤工助学网站后台V1.0</span>
            <nav id="Hui-userbar" class="nav navbar-nav navbar-userbar hidden-xs">
                <ul class="cl">
                    <shiro:hasRole name="3">
                        <li>欢迎登录！管理员</li>
                    </shiro:hasRole>
                    <shiro:hasRole name="4">
                        <li>（超级管理员）</li>
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
                            <li><a href="javascript:;" onClick="myselfinfo()"><i class="Hui-iconfont">&#xe705;</i>个人信息</a></li>
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
        <dl id="menu-webManage">
            <dt><i class="Hui-iconfont">&#xe625;</i>&nbsp;&nbsp;网站管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="noticeManage" data-title="公告管理" href="javascript:void(0)"><i class="Hui-iconfont">&#xe72d;</i>&nbsp;&nbsp;公告管理</a></li>
                    <li><a data-href="newsManage" data-title="新闻管理" href="javascript:void(0)"><i class="Hui-iconfont">&#xe616;</i>&nbsp;&nbsp;新闻管理</a></li>
                </ul>
            </dd>
        </dl>
        <dl id="menu-job">
            <dt><i class="Hui-iconfont">&#xe637;</i>&nbsp;&nbsp;岗位管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="uncheckedJob" data-title="待审核岗位" href="javascript:void(0)"><i class="Hui-iconfont">&#xe702;</i>&nbsp;&nbsp;待审核岗位</a></li>
                    <li><a data-href="checkedJob" data-title="已审核岗位" href="javascript:void(0)"><i class="Hui-iconfont">&#xe6ff;</i>&nbsp;&nbsp;已审核岗位</a></li>
                </ul>
            </dd>
        </dl>
        <dl id="menu-contract">
            <dt><i class="Hui-iconfont">&#xe636;</i>&nbsp;&nbsp;合同管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="uncheckedContract" data-title="待审核合同" href="javascript:void(0)"><i class="Hui-iconfont">&#xe702;</i>&nbsp;&nbsp;待审核合同</a></li>
                    <li><a data-href="checkedContract" data-title="已审核合同" href="javascript:void(0)"><i class="Hui-iconfont">&#xe6ff;</i>&nbsp;&nbsp;已审核合同</a></li>
                </ul>
            </dd>
        </dl>
        <dl id="menu-person">
            <dt><i class="Hui-iconfont">&#xe611;</i>&nbsp;&nbsp;学生管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="studentManage" data-title="学生列表" href="javascript:void(0)"><i class="Hui-iconfont">&#xe62c;</i>&nbsp;&nbsp;学生列表</a></li>
                </ul>
            </dd>
        </dl>
        <dl id="menu-department">
            <dt><i class="Hui-iconfont">&#xe643;</i>&nbsp;&nbsp;部门管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
            <dd>
                <ul>
                    <li><a data-href="departmentManage" data-title="部门列表" href="javascript:void(0)"><i class="Hui-iconfont">&#xe643;</i>&nbsp;&nbsp;部门管理</a></li>
                    <li><a data-href="departmentSysManage" data-title="人员列表" href="javascript:void(0)"><i class="Hui-iconfont">&#xe653;</i>&nbsp;&nbsp;人员列表</a></li>
                    <li><a data-href="uncheckedDepSysManage" data-title="待审核人员" href="javascript:void(0)"><i class="Hui-iconfont">&#xe61d;</i>&nbsp;&nbsp;待审核列表</a></li>
                </ul>
            </dd>
        </dl>
        <shiro:hasRole name="4">
            <dl id="menu-admin">
                <dt><i class="Hui-iconfont">&#xe61d;</i>&nbsp;&nbsp;安全管理<i class="Hui-iconfont menu_dropdown-arrow">&#xe6d5;</i></dt>
                <dd>
                    <ul>
                        <li><a data-href="role.html" data-title="角色管理" href="javascript:void(0)"><i class="Hui-iconfont">&#xe60d;</i>&nbsp;&nbsp;角色管理</a></li>
                        <li><a data-href="permission.html" data-title="权限管理" href="javascript:void(0)"><i class="Hui-iconfont">&#xe611;</i>&nbsp;&nbsp;权限管理</a></li>
                        <li><a data-href="adminManage.html" data-title="管理员列表" href="javascript:void(0)"><i class="Hui-iconfont">&#xe62d;</i>&nbsp;&nbsp;管理员列表</a></li>
                    </ul>
                </dd>
            </dl>
        </shiro:hasRole>
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
            type: 1,
            area: ['300px', '200px'],
            fix: false, //不固定
            maxmin: true,
            shade: 0.4,
            title: '查看信息',
            content: '<div>管理员信息</div>'
        });
    }
</script>
</body>
</html>