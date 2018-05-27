<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>权限列表管理</title>
    <!-- zui -->
    <link href="../zui/css/zui.css" rel="stylesheet">
    <link href="../zui/lib/datagrid/zui.datagrid.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid">
    <div class="row" style="background-color: #EDEDEE">
        <ol class="breadcrumb" style="float: left;margin-top: 20px">
            <li><i class="icon icon-home"></i>&nbsp&nbsp安全管理</li>
            <li>权限列表</li>
        </ol>
        <a class="btn btn-success" style="float: right;margin-right: 3%;margin-top: 20px" href="javascript:location.reload();" title="刷新" ><i class="icon icon-refresh"></i></a>
    </div>
    <div class="row" style="height: auto;margin-left: 2%;margin-right: 2%;margin-top: 1%">
        <div id="permissionGrid" class="datagrid">
            <div class="row">
                <div class="input-control search-box search-box-circle has-icon-left has-icon-right" id="searchbox" style="margin-bottom: 10px; max-width: 300px;float: left">
                    <input id="inputSearch" type="search" class="form-control search-input" placeholder="输入url搜索">
                    <label for="inputSearch" class="input-control-icon-left search-icon"><i class="icon icon-search"></i></label>
                    <a href="#" class="input-control-icon-right search-clear-btn"><i class="icon icon-remove"></i></a>
                </div>
                <div style="float: right">
                    <button class="btn btn-info " type="button" onclick="add()" title="添加权限"><i class="icon icon-plus"></i>&nbsp&nbsp添加</button>
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


<div class="modal fade" id="deleteModal">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                <h4 class="modal-title">删除权限</h4>
            </div>
            <div class="modal-body">
                <p id="deleteContent">主题内容...</p>
            </div>
            <div class="modal-footer">
                <input type="hidden" value="" class="permissionId">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="delBtn">确定</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="addModel">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                <h4 class="modal-title">添加权限</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <form id="addForm">
                        <div class="row">
                            <label class="col-md-offset-1 col-md-2 col-sm-2"><h5><i style="color: red">*</i>url：</h5></label>
                            <div class="col-md-6 col-sm-10">
                                <input type="text" class="form-control" id="url" placeholder="请输入url" data-rule="url: required">
                            </div>
                        </div>
                        <div class="row">
                            <label class="col-md-offset-1 col-md-2 col-sm-2"><h5><i style="color: red">*</i>名称：</h5></label>
                            <div class="col-md-6 col-sm-10">
                                <input type="text" class="form-control" id="desc" placeholder="请输入名称" data-rule="名称: required">
                            </div>
                        </div>
                    </form>

                </div>

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
<!-- Validator插件 -->
<script src="../jquery/validator/dist/jquery.validator.js?local=zh-CN"></script>
<script stype="text/javascript">
    $(function(){
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

        $('#permissionGrid').datagrid({
            dataSource: {
                cols:[
                    {name: 'url', label: 'url', width: 0.4,className: 'text-center'},
                    {name: 'desc', label: '名称',width: 0.5,className: 'text-center'},
                    {name: 'operate', label: '操作',width: 0.1,className: 'text-center'}
                ],
                remote: function(params) {
                    return {
                        // 请求地址
                        url: 'permissionList',
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
                        //添加操作按钮
                        responseData.data[i].operate= '<button class="btn btn-sm btn-danger" type="button" title="删除" value="'+rowData.id+'" onclick="del(this)"><i class="icon icon-trash"></i></button>';
                    }
                    return responseData;
                }
            },
            states: {
                pager: {page: 1,recPerPage: 10},
                fixedLeftUntil: 0,    // 固定左侧第一列
                fixedRightFrom: 3,   // 从第12列开始固定到右侧
                fixedTopUntil: 0,     // 固定顶部第一行（标题行）
            },
            configs: {
                C0: {},
                C3: {html:true}
            },
            checkable: false,
            checkByClickRow: false,
            showRowIndex: true

            // ... 其他初始化选项
        });

        $('#delBtn').click(function () {
            var id = $('#deleteModal .permissionId').val();
            $.ajax({
                type: "post",
                url: 'delPermission',
                data: {"id":id},
                cache: false,
                async : false,
                dataType: "json",
                success: function (data ,textStatus, jqXHR){
                    $('#deleteModal').modal('hide');
                    if("success"==data.status){
                        var permissionGrid   = $('#permissionGrid').data('zui.datagrid');
                        permissionGrid.dataSource.data=null;
                        permissionGrid.render();
                        new $.zui.Messager('操作成功!', {
                            icon:'ok',
                            type: 'success',
                            time: 2000
                        }).show();
                    }
                },
                error:function (jqXHR, textStatus, errorThrown) {
                    $('#deleteModal').modal('hide');
                    new $.zui.Messager('操作失败!', {
                        icon:'warning-sign',
                        type: 'warning',
                        time: 2000
                    }).show();
                }
            });
        })

        $('#addBtn').click(function () {
            var url = $('#url').val().trim();
            var desc = $('#desc').val().trim();
            if ($('#addForm').isValid()){
                $.ajax({
                    type: "post",
                    url: 'addPermission',
                    data: {"url":url,"desc":desc},
                    cache: false,
                    async : false,
                    dataType: "json",
                    success: function (data ,textStatus, jqXHR){
                        $('#addModel').modal('hide');
                        if("success"==data.status){
                            var permissionGrid   = $('#permissionGrid').data('zui.datagrid');
                            permissionGrid.dataSource.data=null;
                            permissionGrid.render();
                            new $.zui.Messager('操作成功!', {
                                icon:'ok',
                                type: 'success',
                                time: 2000
                            }).show();
                        }else{
                            new $.zui.Messager(data.msg, {
                                icon:'ok',
                                type: 'danger',
                                time: 0
                            }).show();
                        }
                    },
                    error:function (jqXHR, textStatus, errorThrown) {
                        $('#addModel').modal('hide');
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
            var permissionGrid = $('#permissionGrid').data('zui.datagrid');
            permissionGrid.setPager(-1,-1,parseInt(recPerPage));
            permissionGrid.render();
        })
    })

    function del(obj) {
        $('.permissionId').val($(obj).val());
        $('#deleteContent').html("确定要删除该权限吗？");
        $('#deleteModal').modal('show', 'fit');
    }

    function add() {
        $('#url').val("");
        $('#desc').val("");
        $('#addModel').modal('show', 'fit');
    }
</script>
</body>
</html>