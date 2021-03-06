<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>已录用的学生合同列表</title>
    <!-- zui -->
    <link href="../zui/css/zui.css" rel="stylesheet">
    <link href="../zui/lib/datagrid/zui.datagrid.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid">
    <div class="row" style="background-color: #EDEDEE">
        <ol class="breadcrumb" style="float: left;margin-top: 20px">
            <li><i class="icon icon-home"></i>&nbsp&nbsp合同管理</li>
            <li>已录用学生的合同列表</li>
        </ol>
        <a class="btn btn-success" style="float: right;margin-right: 3%;margin-top: 20px" href="javascript:location.reload();" title="刷新" ><i class="icon icon-refresh"></i></a>
    </div>
    <div class="row" style="height: auto;margin-left: 2%;margin-right: 2%;margin-top: 1%">
        <div id="confirmedContractGrid" class="datagrid">
            <div class="row">
                <div class="input-control search-box search-box-circle has-icon-left has-icon-right" id="searchbox" style="margin-bottom: 10px; max-width: 300px;float: left">
                    <input id="inputSearch" type="search" class="form-control search-input" placeholder="输入岗位名称搜索">
                    <label for="inputSearch" class="input-control-icon-left search-icon"><i class="icon icon-search"></i></label>
                    <a href="#" class="input-control-icon-right search-clear-btn"><i class="icon icon-remove"></i></a>
                </div>
                <div style="float: left;margin-left: 2%">
                    <button class="btn btn-danger" type="button" title="批量删除" onclick="delSome()"><i class="icon icon-trash"></i>&nbsp&nbsp批量删除</button>
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
                <input type="hidden" value="" class="jobContractId">
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
                <input type="hidden" value="" class="jobContractIdArr">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="delSomeBtn">确定</button>
            </div>
        </div>
    </div>
</div>

<script src="../jquery/jquery-3.2.1.min.js"></script>
<!-- ZUI Javascript组件 -->
<script src="../zui/js/zui.js"></script>
<script src="../zui/lib/datagrid/zui.datagrid.js"></script>
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

        $('#confirmedContractGrid').datagrid({
            dataSource: {
                cols:[
                    {name: 'myCheckbox', label: '<i onclick="changeAllCheckbox(this)" class="icon icon-check-empty">', width: 36,className: 'text-center'},
                    {name: 'jobContractId', label: '合同号', width: 0.1,className: 'text-center'},
                    {name: 'createTime', label: '合同生成时间', width: 140,className: 'text-center'},
                    {name: 'jobName', label: '岗位名称', width: 140,className: 'text-center'},
                    {name: 'stuNum', label: '学号', width: 100,className: 'text-center'},
                    {name: 'stuName', label: '姓名',width: 100,className: 'text-center'},
                    {name: 'sex', label: '性别',width: 100,className: 'text-center'},
                    {name: 'sexReq', label: '性别限制',width: 100,className: 'text-center'},
                    {name: 'requireNum', label: '需要人数',width: 100,className: 'text-center'},
                    {name: 'maxNum', label: '最多申请人数',width: 120,className: 'text-center'},
                    {name: 'acceptNum', label: '已录用人数',width: 100,className: 'text-center'},
                    {name: 'status', label: '状态',width: 100,className: 'text-center'},
                    {name: 'confirmUser', label: '确认人',width: 140,className: 'text-center'},
                    {name: 'confirmTime', label: '确认时间',width: 140,className: 'text-center'},
                    {name: 'operate', label: '操作',width: 50,className: 'text-center'}
                ],
                remote: function(params) {
                    return {
                        // 请求地址
                        url: 'confirmedContractList',
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
                        responseData.data[i].myCheckbox='<i name="myCheckbox" onclick="changeCheckbox(this)" value="'+rowData.jobContractId+'" class="icon icon-check-empty">';
                        //添加操作按钮
                        responseData.data[i].operate='<button class="btn btn-sm btn-danger" type="button" title="删除" value="'+responseData.data[i].jobContractId+'" onclick="del(this)"><i class="icon icon-trash"></i></button>';
                    }
                    return responseData;
                }
            },
            states: {
                pager: {page: 1,recPerPage: 10},
                fixedLeftUntil: 0,    // 固定左侧第一列
                fixedRightFrom: 15,   // 从第12列开始固定到右侧
                fixedTopUntil: 0,     // 固定顶部第一行（标题行）
            },
            configs: {
                C1: {html:true},
                C15: {html:true}
            },
            checkable: false,
            checkByClickRow: false,
            showRowIndex: true

            // ... 其他初始化选项
        });

        $('#delBtn').click(function () {
            var jobContractId = $('#delModal .jobContractId').val();
            $.ajax({
                type: "post",
                url: 'delContract',
                data: {"jobContractId":jobContractId},
                cache: false,
                async : false,
                dataType: "json",
                success: function (data ,textStatus, jqXHR){
                    $('#delModal').modal('hide');
                    if("success"==data.status){
                        var confirmedContractGrid   = $('#confirmedContractGrid').data('zui.datagrid');
                        confirmedContractGrid.dataSource.data=null;
                        confirmedContractGrid.render();
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
            $('#delSomeModal').modal('hide');
            var jobContractIdArr = $('#delSomeModal .jobContractIdArr').val();
            $.ajax({
                type: "post",
                url: 'delSomeContract',
                data: {"jobContractIdArr":jobContractIdArr},
                cache: false,
                async : false,
                dataType: "json",
                success: function (data ,textStatus, jqXHR){
                    if("success"==data.status){
                        var confirmedContractGrid   = $('#confirmedContractGrid').data('zui.datagrid');
                        confirmedContractGrid.dataSource.data=null;
                        confirmedContractGrid.render();
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
        })

        $("#recPerPage").change(function () {
            var recPerPage = $(this).children('option:selected').val();
            // 获取数据表格实例
            var confirmedContractGrid = $('#confirmedContractGrid').data('zui.datagrid');
            confirmedContractGrid.setPager(-1,-1,parseInt(recPerPage));
            confirmedContractGrid.render();
        })
    })

    function del(obj) {
        $('.jobContractId').val($(obj).val());
        $('#delContent').html("确定要删除合同号为：["+$(obj).val()+"]的合同吗？");
        $('#delModal').modal('show', 'fit');
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
            $('.jobContractIdArr').val(arr);
            $('#delSomeContent').html("确定要删除所选["+arr.length+"]个岗位吗？");
            $('#delSomeModal').modal('show', 'fit');
        }
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
</script>
</body>
</html>