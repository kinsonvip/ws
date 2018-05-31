<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>审核中岗位列表</title>
    <!-- zui -->
    <link href="../zui/css/zui.css" rel="stylesheet">
    <link href="../zui/lib/datagrid/zui.datagrid.css" rel="stylesheet">
    <link href="../zui/lib/datetimepicker/datetimepicker.min.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid">
    <div class="row" style="background-color: #EDEDEE">
        <ol class="breadcrumb" style="float: left;margin-top: 20px">
            <li><i class="icon icon-home"></i>&nbsp&nbsp岗位管理</li>
            <li>审核中岗位列表</li>
        </ol>
        <a class="btn btn-success" style="float: right;margin-right: 3%;margin-top: 20px" href="javascript:location.reload();" title="刷新" ><i class="icon icon-refresh"></i></a>
    </div>
    <div class="row" style="height: auto;margin-left: 2%;margin-right: 2%;margin-top: 1%">
        <div id="uncheckedJobGrid" class="datagrid datagrid-striped">
            <div class="row">
                <div class="input-control search-box search-box-circle has-icon-left has-icon-right" id="searchbox" style="margin-bottom: 10px; max-width: 300px;float: left">
                    <input id="inputSearch" type="search" class="form-control search-input" placeholder="输入岗位名称搜索">
                    <label for="inputSearch" class="input-control-icon-left search-icon"><i class="icon icon-search"></i></label>
                    <a href="#" class="input-control-icon-right search-clear-btn"><i class="icon icon-remove"></i></a>
                </div>
                <div style="float: left;margin-left: 2%">
                    <button class="btn btn-info" type="button" title="发布岗位" onclick="add()"><i class="icon icon-plus"></i>&nbsp&nbsp发布岗位</button>
                </div>
                <div style="float: left;margin-left: 2%">
                    <button class="btn btn-danger" type="button" title="批量拒绝" onclick="delSome()"><i class="icon icon-trash"></i>&nbsp&nbsp批量删除</button>
                </div>
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

<div class="modal fade" id="detailModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                <h4 class="modal-title">岗位详情</h4>
            </div>
            <div class="modal-body">
                <article class="article">
                    <header>
                        <h1 class="text-center" id="tittle">岗位标题</h1>
                        <dl class="dl-inline">
                            <dt>所属部门：</dt>
                            <dd id="depName">某某部门</dd>
                            <dt>创建人：</dt>
                            <dd id="createUser">某某人</dd>
                            <dt>建立时间：</dt>
                            <dd id="createTime">2018-04-27 00:19:47</dd>
                            <dt>截止时间：</dt>
                            <dd id="endTime">2018-04-27 00:19:47</dd>
                        </dl>
                    </header>
                    <section class="content" style="text-indent: 2em">
                        <p><strong>岗位介绍：</strong><span id="jobDesc">内容</span></p>
                        <p><strong>工作地点：</strong><span id="addr">内容</span></p>
                        <p><strong>岗位要求：</strong><span id="jobReq">内容</span></p>
                        <p><strong>性别要求：</strong><span id="sexReq">内容</span></p>
                        <p><strong>需要人数：</strong><span id="requireNum">内容</span>人</p>
                        <p><strong>工作天数：</strong><span id="workdays">内容</span>天</p>
                        <p><strong>薪资：</strong><span id="salary">内容</span>元/天</p>
                        <p><strong>联系人：</strong><span id="linkMan">内容</span></p>
                        <p><strong>联系电话：</strong><span id="linkPhone">内容</span></p>
                    </section>

                </article>
            </div>
            <div class="modal-footer">
                <input type="hidden" value="" class="jobId">
                <button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="delModal">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                <h4 class="modal-title">删除岗位</h4>
            </div>
            <div class="modal-body">
                <p id="delContent">主题内容...</p>
            </div>
            <div class="modal-footer">
                <input type="hidden" value="" class="jobId">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="delBtn">确定</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="delSomeModal">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                <h4 class="modal-title">批量删除</h4>
            </div>
            <div class="modal-body">
                <p id="delSomeContent">主题内容...</p>
            </div>
            <div class="modal-footer">
                <input type="hidden" value="" class="jobIdArr">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="delSomeBtn">确定</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="editModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                <h4 class="modal-title">编辑岗位</h4>
            </div>
            <div class="modal-body">
                <form id="editForm">
                    <div class="row">
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>岗位名称：</h5></label>
                        <div class="col-md-8 col-sm-8" style="width: 60%">
                            <input type="text" class="form-control" id="editTittle" placeholder="请输入岗位名称" data-rule="岗位名称: required">
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>需求人数：</h5></label>
                        <div class="col-md-4 col-sm-4" style="width: 20%;margin-right: 12%">
                            <input type="text" class="form-control" id="editRequireNum" placeholder="请输入需求人数" data-rule="需求人数: required;digits">
                        </div>
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>最大申请人数：</h5></label>
                        <div class="col-md-4 col-sm-4" style="width: 20%">
                            <input type="text" class="form-control" id="editMaxNum" placeholder="最大申请人数" data-rule="最大申请人数: required;digits">
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>截止：</h5></label>
                        <div class="col-md-4 col-sm-4" style="width: 20%;margin-right: 12%">
                            <input type="text" class="form-control form-datetime" id="editEndTime" data-rule="截至日期: required">
                        </div>
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>性别要求：</h5></label>
                        <div class="col-md-4 col-sm-4" style="width: 20%">
                            <select class="form-control" id="editSexReq">
                                <option value ="不限">不限</option>
                                <option value="男">男</option>
                                <option value="女">女</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>工作天数：</h5></label>
                        <div class="col-md-4 col-sm-4" style="width: 20%;margin-right: 12%">
                            <input type="text" class="form-control" id="editWorkdays" placeholder="请输入工作天数" data-rule="工作天数: required;digits">
                        </div>
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>薪资（/天）：</h5></label>
                        <div class="col-md-4 col-sm-4" style="width: 20%">
                            <input type="text" class="form-control" id="editSalary" placeholder="请输入薪资" data-rule="薪资: required;digits">
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>工作地址：</h5></label>
                        <div class="col-md-10 col-sm-10" style="width: 60%">
                            <input type="text" class="form-control" id="editAddr" placeholder="请输入工作地址" data-rule="工作地点: required">
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>联系人：</h5></label>
                        <div class="col-md-4 col-sm-4" style="width: 20%;margin-right: 12%">
                            <input type="text" class="form-control" id="editLinkMan" placeholder="请输入联系人" data-rule="联系人: required">
                        </div>
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>联系电话：</h5></label>
                        <div class="col-md-4 col-sm-4" style="width: 20%">
                            <input type="text" class="form-control" id="editLinkPhone" placeholder="请输入联系电话" data-rule="联系电话: required;mobile">
                        </div>
                    </div>
                    <h5><i style="color: red">*</i>岗位描述：</h5>
                    <script id="editor3" type="text/plain" style="height: 300px"></script>
                    <h5><i style="color: red">*</i>岗位要求：</h5>
                    <script id="editor4" type="text/plain" style="height: 300px"></script>
                </form>

            </div>
            <div class="modal-footer">
                <input type="hidden" value="" class="jobId">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="updateBtn">确定</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="addModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                <h4 class="modal-title">发布岗位</h4>
            </div>
            <div class="modal-body">
                <form id="addForm">
                    <div class="row">
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>岗位名称：</h5></label>
                        <div class="col-md-10 col-sm-10" style="width: 60%">
                            <input type="text" class="form-control" id="inputTittle" placeholder="请输入岗位名称" data-rule="岗位名称: required">
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>需求人数：</h5></label>
                        <div class="col-md-4 col-sm-4" style="width: 20%;margin-right: 12%">
                            <input type="text" class="form-control" id="inputRequireNum" placeholder="请输入需求人数" data-rule="需求人数: required;digits">
                        </div>
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>最大申请人数：</h5></label>
                        <div class="col-md-4 col-sm-4" style="width: 20%">
                            <input type="text" class="form-control" id="inputMaxNum" placeholder="最大申请人数" data-rule="最大申请人数: required;digits">
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>截止：</h5></label>
                        <div class="col-md-4 col-sm-4" style="width: 20%;margin-right: 12%">
                            <input type="text" class="form-control form-datetime" id="inputEndTime" data-rule="截至日期: required">
                        </div>
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>性别要求：</h5></label>
                        <div class="col-md-4 col-sm-4" style="width: 20%">
                            <select class="form-control" id="inputSexReq">
                                <option value ="不限">不限</option>
                                <option value="男">男</option>
                                <option value="女">女</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>工作天数：</h5></label>
                        <div class="col-md-4 col-sm-4" style="width: 20%;margin-right: 12%">
                            <input type="text" class="form-control" id="inputWorkdays" placeholder="请输入工作天数" data-rule="工作天数: required;digits">
                        </div>
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>薪资（/天）：</h5></label>
                        <div class="col-md-4 col-sm-4" style="width: 20%">
                            <input type="text" class="form-control" id="inputSalary" placeholder="请输入薪资" data-rule="薪资: required;digits">
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>工作地址：</h5></label>
                        <div class="col-md-10 col-sm-10" style="width: 60%">
                            <input type="text" class="form-control" id="inputAddr" placeholder="请输入工作地址" data-rule="工作地址: required">
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>联系人：</h5></label>
                        <div class="col-md-4 col-sm-4" style="width: 20%;margin-right: 12%">
                            <input type="text" class="form-control" id="inputLinkMan" placeholder="请输入联系人" data-rule="联系人: required">
                        </div>
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>联系电话：</h5></label>
                        <div class="col-md-4 col-sm-4" style="width: 20%">
                            <input type="text" class="form-control" id="inputLinkPhone" placeholder="请输入联系电话" data-rule="联系电话: required;mobile">
                        </div>
                    </div>
                    <h5><i style="color: red">*</i>岗位描述：</h5>
                    <script id="editor" type="text/plain" style="height: 300px"></script>
                    <h5><i style="color: red">*</i>岗位要求：</h5>
                    <script id="editor2" type="text/plain" style="height: 300px"></script>
                </form>

            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="addBtn">确定</button>
            </div>
        </div>
    </div>
</div>

<script src="../jquery/jquery-3.2.1.min.js"></script>
<!-- ZUI Javascript组件 -->
<script src="../zui/js/zui.js"></script>
<script src="../zui/lib/datagrid/zui.datagrid.js"></script>
<script src="../zui/lib/datetimepicker/datetimepicker.min.js"></script>
<!-- Validator插件 -->
<script src="../jquery/validator/dist/jquery.validator.js?local=zh-CN"></script>
<!-- UEditor组件 -->
<script type="text/javascript" charset="utf-8" src="../H-ui/lib/ueditor/1.4.3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../H-ui/lib/ueditor/1.4.3/ueditor.all.js"> </script>
<script type="text/javascript" charset="utf-8" src="../H-ui/lib/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
<script>
    var ue = UE.getEditor('editor');
    var ue2 = UE.getEditor('editor2');
    var ue3 = UE.getEditor('editor3');
    var ue4 = UE.getEditor('editor4');
    UE.Editor.prototype._bkGetActionUrl = UE.Editor.prototype.getActionUrl;
    UE.Editor.prototype.getActionUrl = function(action) {
        if (action == 'uploadimage' || action == 'uploadscrawl' || action == 'uploadimage') {
            return '../ueditor/imgUpload';//指定访问路径
        } else if (action == 'uploadvideo') {
            return '';
        } else {
            return this._bkGetActionUrl.call(this, action);
        }
    }
</script>
<script stype="text/javascript">
    $(function(){
        $(".form-datetime").datetimepicker(
            {
                weekStart: 1,
                todayBtn:  1,
                autoclose: 1,
                todayHighlight: 1,
                startView: 2,
                forceParse: 0,
                showMeridian: 1,
                format: "yyyy-mm-dd hh:ii:ss"
            });

        var jqxhr;
        //设置ajax请求完成后运行的函数,
        $.ajaxSetup({
            complete:function(){
                if("REDIRECT" == jqxhr.getResponseHeader("REDIRECT")){ //若HEADER中含有REDIRECT说明后端想重定向，
                    var win = window;
                    while(win != win.top){
                        win = win.top;
                    }
                    win.location.href = jqxhr.getResponseHeader("CONTENTPATH");//将后端重定向的地址取出来,使用win.location.href去实现重定向的要求
                }
            }
        });

        $('#uncheckedJobGrid').datagrid({
            height:'page',
            dataSource: {
                cols:[
                    {name: 'myCheckbox', label: '<i onclick="changeAllCheckbox(this)" class="icon icon-check-empty">', width: 36,className: 'text-center'},
                    {name: 'depName', label: '用人部门', width: 0.1,className: 'text-center'},
                    {name: 'tittle', label: '岗位名称', width: 0.15,className: 'text-center'},
                    {name: 'requireNum', label: '需求人数', width: 0.1,className: 'text-center'},
                    {name: 'sexReq', label: '性别要求',width: 0.1,className: 'text-center'},
                    {name: 'workdays', label: '工作天数',width: 0.1,className: 'text-center'},
                    {name: 'salary', label: '薪资/天',width: 0.1,className: 'text-center'},
                    {name: 'createUser', label: '创建人',width: 0.1,className: 'text-center'},
                    {name: 'createTime', label: '创建时间',width: 0.15,className: 'text-center'},
                    {name: 'status', label: '状态',width: 0.1,className: 'text-center'},
                    {name: 'operate', label: '操作',width: 0.2,className: 'text-center'}
                ],
                remote: function(params) {
                    return {
                        // 请求地址
                        url: 'uncheckedJobList',
                        // 请求类型
                        type: 'GET',
                        // 数据类型
                        dataType: 'json'
                    };
                },
                remoteConverter:function (responseData,textStatus,jqXHR,datagrid) {
                    jqxhr = jqXHR;
                    for(var i = 0;i < responseData.data.length;i++){
                        var rowData = responseData.data[i];
                        var job = rowData.jobId+"╪"+rowData.depName+"╪"+rowData.tittle+"╪"+rowData.jobDesc+"╪"+rowData.requireNum+"╪"+rowData.jobReq+"╪"+rowData.sexReq+"╪"+rowData.workdays+"╪"+rowData.salary+"╪"+rowData.addr+"╪"+rowData.linkMan+"╪"+rowData.linkPhone+"╪"+rowData.createTime+"╪"+rowData.endTime+"╪"+rowData.createUser+"╪"+rowData.status+"╪"+rowData.maxNum;
                        responseData.data[i].myCheckbox='<i name="myCheckbox" onclick="changeCheckbox(this)" value="'+rowData.jobId+'" class="icon icon-check-empty">';
                        //添加操作按钮
                        responseData.data[i].operate= '<button class="btn btn-sm btn-info" type="button" title="详情" value="'+job+'" onclick="detail(this)"><i class="icon icon-zoom-in"></i></button>&nbsp&nbsp&nbsp&nbsp' +
                            '<button class="btn btn-sm btn-success" type="button" title="修改" value="'+job+'" onclick="edit(this)"><i class="icon icon-edit"></i></button>&nbsp&nbsp&nbsp&nbsp' +
                            '<button class="btn btn-sm btn-danger" type="button" title="删除" value="'+job+'" onclick="del(this)"><i class="icon icon-trash"></i></button>';
                    }
                    return responseData;
                }
            },
            states: {
                pager: {page: 1,recPerPage: 10},
                fixedLeftUntil: 0,    // 固定左侧第一列
                fixedRightFrom: 11,   // 从第12列开始固定到右侧
                fixedTopUntil: 0,     // 固定顶部第一行（标题行）
            },
            configs: {
                C1: {html:true},
                C11: {html:true}
            },
            checkable: false,
            checkByClickRow: false,
            showRowIndex: true

            // ... 其他初始化选项
        });

        $('#delBtn').click(function () {
            var jobId = $('#delModal .jobId').val();
            $.ajax({
                type: "post",
                url: 'delJob',
                data: {"jobId":jobId},
                cache: false,
                async : false,
                dataType: "json",
                success: function (data ,textStatus, jqXHR){
                    $('#delModal').modal('hide');
                    if("success"==data.status){
                        var uncheckedJobGrid   = $('#uncheckedJobGrid').data('zui.datagrid');
                        uncheckedJobGrid.dataSource.data=null;
                        uncheckedJobGrid.render();
                        new $.zui.Messager('操作成功!', {
                            icon:'ok',
                            type: 'success',
                            time: 2000
                        }).show();
                    }
                },
                error:function (jqXHR, textStatus, errorThrown) {
                    $('#delModal').modal('hide');
                    new $.zui.Messager('操作失败!', {
                        icon:'warning-sign',
                        type: 'warning',
                        time: 2000
                    }).show();
                }
            });
        })

        $('#delSomeBtn').click(function () {
            var jobIdArr = $('#delSomeModal .jobIdArr').val();
            $.ajax({
                type: "post",
                url: 'delSomeJob',
                data: {"jobIdArr":jobIdArr},
                cache: false,
                async : false,
                dataType: "json",
                success: function (data ,textStatus, jqXHR){
                    $('#delSomeModal').modal('hide');
                    if("success"==data.status){
                        var uncheckedJobGrid   = $('#uncheckedJobGrid').data('zui.datagrid');
                        uncheckedJobGrid.dataSource.data=null;
                        uncheckedJobGrid.render();
                        new $.zui.Messager('操作成功!', {
                            icon:'ok',
                            type: 'success',
                            time: 2000
                        }).show();
                    }
                },
                error:function (jqXHR, textStatus, errorThrown) {
                    $('#delSomeModal').modal('hide');
                    new $.zui.Messager('操作失败!', {
                        icon:'warning-sign',
                        type: 'warning',
                        time: 2000
                    }).show();
                }
            });
        })

        $('#addBtn').click(function () {
            var reg=/"/g;
            var sexReq = $('#inputSexReq').children('option:selected').val().trim();
            var tittle = $('#inputTittle').val().trim();
            var requireNum = $('#inputRequireNum').val().trim();
            var maxNum = $('#inputMaxNum').val().trim();
            var endTime = $('#inputEndTime').val().trim();
            var workdays = $('#inputWorkdays').val().trim();
            var salary = $('#inputSalary').val().trim();
            var addr = $('#inputAddr').val().trim();
            var linkMan = $('#inputLinkMan').val().trim();
            var linkPhone = $('#inputLinkPhone').val().trim();
            var jobDesc = ue.getContent().replace(reg,'\'');
            var jobReq = ue2.getContent().replace(reg,'\'');
            if ($('#addForm').isValid()){
                $.ajax({
                    type: "post",
                    url: 'addJob',
                    data: {
                        "sexReq":sexReq,
                        "tittle":tittle,
                        "requireNum":requireNum,
                        "maxNum":maxNum,
                        "time":endTime,
                        "workdays":workdays,
                        "salary":salary,
                        "addr":addr,
                        "linkman":linkMan,
                        "linkphone":linkPhone,
                        "jobDesc":jobDesc,
                        "jobReq":jobReq
                    },
                    cache: false,
                    async : false,
                    dataType: "json",
                    success: function (data ,textStatus, jqXHR){
                        $('#addModal').modal('hide');
                        if("success"==data.status){
                            var uncheckedJobGrid   = $('#uncheckedJobGrid').data('zui.datagrid');
                            uncheckedJobGrid.dataSource.data=null;
                            uncheckedJobGrid.render();
                            new $.zui.Messager('操作成功!', {
                                icon:'ok',
                                type: 'success',
                                time: 2000
                            }).show();
                        }
                    },
                    error:function (jqXHR, textStatus, errorThrown) {
                        $('#addModal').modal('hide');
                        new $.zui.Messager('操作失败!', {
                            icon:'warning-sign',
                            type: 'warning',
                            time: 2000
                        }).show();
                    }
                });
            }
        })

        $('#updateBtn').click(function () {
            var reg=/"/g;
            var jobId = $('#editModal .jobId').val().trim();
            var sexReq = $('#editSexReq').children('option:selected').val().trim();
            var tittle = $('#editTittle').val().trim();
            var requireNum = $('#editRequireNum').val().trim();
            var maxNum = $('#editMaxNum').val().trim();
            var endTime = $('#editEndTime').val().trim();
            var workdays = $('#editWorkdays').val().trim();
            var salary = $('#editSalary').val().trim();
            var addr = $('#editAddr').val().trim();
            var linkMan = $('#editLinkMan').val().trim();
            var linkPhone = $('#editLinkPhone').val().trim();
            var jobDesc = ue3.getContent().replace(reg,'\'');
            var jobReq = ue4.getContent().replace(reg,'\'');
            if ($('#editForm').isValid()){
                $('#editModal').modal('hide');
                $.ajax({
                    type: "post",
                    url: 'updateJob',
                    data: {
                        "id":jobId,
                        "sexReq":sexReq,
                        "tittle":tittle,
                        "requireNum":requireNum,
                        "maxNum":maxNum,
                        "time":endTime,
                        "workdays":workdays,
                        "salary":salary,
                        "addr":addr,
                        "linkman":linkMan,
                        "linkphone":linkPhone,
                        "jobDesc":jobDesc,
                        "jobReq":jobReq
                    },
                    cache: false,
                    async : false,
                    dataType: "json",
                    success: function (data ,textStatus, jqXHR){
                        if("success"==data.status){
                            var uncheckedJobGrid   = $('#uncheckedJobGrid').data('zui.datagrid');
                            uncheckedJobGrid.dataSource.data=null;
                            uncheckedJobGrid.render();
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

        $("#recPerPage").change(function () {
            var recPerPage = $(this).children('option:selected').val();
            // 获取数据表格实例
            var uncheckedJobGrid = $('#uncheckedJobGrid').data('zui.datagrid');
            uncheckedJobGrid.setPager(-1,-1,parseInt(recPerPage));
            uncheckedJobGrid.render();
        })
    })

    function detail(obj) {
        var job = new Array();
        job = $(obj).val().split('╪');
        $('.jobId').val(job[0]);
        $('#tittle').html(job[2]);
        $('#depName').html(job[1]);
        $('#createUser').html(job[14]);
        $('#createTime').html(job[12]);
        $('#endTime').html(job[13]);
        $('#jobDesc').html(job[3]);
        $('#addr').html(job[9]);
        $('#jobReq').html(job[5]);
        $('#sexReq').html(job[6]);
        $('#requireNum').html(job[4]);
        $('#workdays').html(job[7]);
        $('#salary').html(job[8]);
        $('#linkMan').html(job[10]);
        $('#linkPhone').html(job[11]);
        $('#detailModal').modal('show', 'fit');
    }

    function del(obj) {
        var job = new Array();
        job = $(obj).val().split('╪');
        $('.jobId').val(job[0]);
        $('#delContent').html("确定要删除岗位：["+job[2]+"]吗？");
        $('#delModal').modal('show', 'fit');
    }

    function changeCheckbox(obj) {
        if($(obj).attr("class")=="icon icon-check-empty"){
            $(obj).attr("class","icon icon-check-sign");
        }else{
            $(obj).attr("class","icon icon-check-empty")
        }
    }

    function changeAllCheckbox(obj) {
        var checkboxList = $('i[name="myCheckbox"]');
        if($(obj).attr("class")=="icon icon-check-empty"){
            $(obj).attr("class","icon icon-check-sign");
            for(var i = 0; i < checkboxList.length; i++){
                $(checkboxList[i]).attr("class","icon icon-check-sign");
            }
        }else{
            for(var i = 0; i < checkboxList.length; i++){
                $(obj).attr("class","icon icon-check-empty")
                $(checkboxList[i]).attr("class","icon icon-check-empty");
            }
        }
    }

    function add() {
        $('#inputTittle').val("");
        $('#inputRequireNum').val("");
        $('#inputMaxNum').val("");
        $('#inputEndTime').val("");
        $('#inputSexReq').val("不限");
        $('#inputWorkdays').val("");
        $('#inputSalary').val("");
        $('#inputAddr').val("");
        $('#inputLinkMan').val("");
        $('#inputLinkPhone').val("");
        ue.setContent('');
        ue2.setContent('');
        $('#addModal').modal('show', 'fit');
    }

    function edit(obj) {
        var job = new Array();
        job = $(obj).val().split('╪');
        $('.jobId').val(job[0]);
        $('#editTittle').val(job[2]);
        $('#editRequireNum').val(job[4]);
        $('#editMaxNum').val(job[16]);
        $('#editEndTime').val(job[13]);
        $('#editSexReq').val(job[6]);
        $('#editWorkdays').val(job[7]);
        $('#editSalary').val(job[8]);
        $('#editAddr').val(job[9]);
        $('#editLinkMan').val(job[10]);
        $('#editLinkPhone').val(job[11]);
        ue3.setContent(job[3]);
        ue4.setContent(job[5]);
        $('#editModal').modal('show', 'fit');
    }

    function delSome() {
        var arr = new Array();
        var checkboxList = $('i[name="myCheckbox"][class="icon icon-check-sign"]');
        if(checkboxList.length==0){
            new $.zui.Messager('请选择要操作的数据!', {
                icon:'warning-sign',
                type: 'warning',
                time: 2000
            }).show();
        }else{
            for(var i = 0;i<checkboxList.length;i++){
                arr.push($(checkboxList[i]).attr("value"));
            }
            $('.jobIdArr').val(arr);
            $('#delSomeContent').html("确定要删除所选["+arr.length+"]个岗位吗？");
            $('#delSomeModal').modal('show', 'fit');
        }
    }

</script>
</body>
</html>