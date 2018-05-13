<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html lang="zh-cn">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>我的合同</title>
    <link href="css/public.css" type="stylesheet">
    <!-- zui -->
    <link href="zui/css/zui.css" rel="stylesheet">
    <link href="zui/css/zui-theme.css" rel="stylesheet">
    <link href="zui/lib/datagrid/zui.datagrid.css" rel="stylesheet">

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
                        <li><a href="your/nice/url">中心简介</a></li>
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
            <div id="contractGrid" class="datagrid">
                <div class="input-control search-box search-box-circle has-icon-left has-icon-right" id="searchbox" style="margin-bottom: 10px; max-width: 300px">
                    <input id="inputSearch" type="search" class="form-control search-input" placeholder="输入岗位名称搜索">
                    <label for="inputSearch" class="input-control-icon-left search-icon"><i class="icon icon-search"></i></label>
                    <a href="#" class="input-control-icon-right search-clear-btn"><i class="icon icon-remove"></i></a>
                </div>
                <div class="datagrid-container"></div>
                <div class="row">
                    <div style="margin-left: 20%;margin-top:1.5%;margin-right:1%;float: left">
                        <select id="recPerPage" class="select form-control">
                            <option value="10">每页10项</option>
                            <option value="20">每页20项</option>
                            <option value="100">每页100项</option>
                        </select>
                    </div>
                    <div id="myPager" class="pager" data-elements="first,prev,goto,next,last,page_of_total_text" data-page-Size-Options="10,15,20"></div>
                </div>
            </div>
        </div>
    </div>

    <div class="bottom">
        <div class="bottom-text">
            <p>Copyright © 2017-2018 <a href="http://www.shzu.edu.cn" style="color: red">石河子大学</a> &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 备案/许可证编号：京ICP备18001038 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp powered by Kinson</p>
            <p>地址：新疆维吾尔自治区石河子市石河子大学 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 邮编：832000 &nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp&nbsp 邮箱：kinsonvip@gmail.com</p>
        </div>
    </div>
    
</div>
<script src="js/public.js"></script>
<script src="jquery/jquery-3.2.1.min.js"></script>
<!-- ZUI Javascript组件 -->
<script src="zui/js/zui.min.js"></script>
<script src="zui/lib/datagrid/zui.datagrid.js"></script>
<script>
    $(function () {
        $('#contractGrid').datagrid({
            dataSource: {
                cols:[
                    {name: 'jobContractId', label: '合同号', width: 100,className: 'text-center'},
                    {name: 'createTime', label: '合同生成时间', width: 140,className: 'text-center'},
                    {name: 'tittle', label: '岗位名称', width: 140,className: 'text-center'},
                    {name: 'stuNum', label: '学号', width: 100,className: 'text-center'},
                    {name: 'name', label: '姓名',width: 100,className: 'text-center'},
                    {name: 'salary', label: '薪资/天',width: 100,className: 'text-center'},
                    {name: 'workdays', label: '工作天数',width: 100,className: 'text-center'},
                    {name: 'status', label: '需要人数',width: 100,className: 'text-center'},
                    {name: 'mark', label: '备注',className: 'text-center'},
                ],
                remote: function(params) {
                    return {
                        // 请求地址
                        url: 'myContractList',
                        // 请求类型
                        type: 'POST',
                        // 数据类型
                        dataType: 'json'
                    };
                },
                remoteConverter:function (responseData,textStatus,jqXHR,datagrid) {
                    jqxhr = jqXHR;
                    for(var i = 0;i < responseData.data.length;i++){
                        var rowData = responseData.data[i];
                        //添加操作按钮
                    }
                    return responseData;
                }
            },
            states: {
                pager: {page: 1,recPerPage: 10},
            },
            configs: {
            },
            checkable: false,
            checkByClickRow: false,
            showRowIndex: true

            // ... 其他初始化选项
        });
    })
</script>
</body>
</html>