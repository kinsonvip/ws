<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>待审核岗位列表</title>
    <!-- zui -->
    <link href="../zui/css/zui.css" rel="stylesheet">
    <link href="../zui/lib/datagrid/zui.datagrid.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid">
    <div class="row" style="background-color: #EDEDEE">
        <ol class="breadcrumb" style="float: left;margin-top: 20px">
            <li><i class="icon icon-home"></i>&nbsp&nbsp岗位管理</li>
            <li>待审核岗位列表</li>
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
                    <button class="btn btn-success" type="button" title="批量通过" onclick="passSome()"><i class="icon icon-check"></i>&nbsp&nbsp批量通过</button>
                </div>
                <div style="float: left;margin-left: 2%">
                    <button class="btn btn-warning" type="button" title="批量拒绝" onclick="noPassSome()"><i class="icon icon-times"></i>&nbsp&nbsp批量拒绝</button>
                </div>
            </div>

            <div class="datagrid-container"></div>
            <div class="row">
                <div style="margin-left: 20%;margin-top:2%;margin-right:2%;float: left">
                    每页<select id="recPerPage" class="select">
                    <option value="10">10</option>
                    <option value="20">20</option>
                    <option value="100">100</option>
                </select>项
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

<div class="modal fade" id="passModal">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                <h4 class="modal-title">审核通过</h4>
            </div>
            <div class="modal-body">
                <p id="passContent">主题内容...</p>
            </div>
            <div class="modal-footer">
                <input type="hidden" value="" class="jobId">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="passBtn">确定</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="noPassModal">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                <h4 class="modal-title">审核拒绝</h4>
            </div>
            <div class="modal-body">
                <p id="noPassContent">主题内容...</p>
            </div>
            <div class="modal-footer">
                <input type="hidden" value="" class="jobId">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="noPassBtn">确定</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="passSomeModal">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                <h4 class="modal-title">审核通过</h4>
            </div>
            <div class="modal-body">
                <p id="passSomeContent">主题内容...</p>
            </div>
            <div class="modal-footer">
                <input type="hidden" value="" class="jobIdArr">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="passSomeBtn">确定</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="noPassSomeModal">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                <h4 class="modal-title">审核拒绝</h4>
            </div>
            <div class="modal-body">
                <p id="noPassSomeContent">主题内容...</p>
            </div>
            <div class="modal-footer">
                <input type="hidden" value="" class="jobIdArr">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="noPassSomeBtn">确定</button>
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

        $('#uncheckedJobGrid').datagrid({
            height:'page',
            dataSource: {
                cols:[
                    {name: 'myCheckbox', label: '<i onclick="changeAllCheckbox(this)" class="icon icon-check-empty">', width: 36,className: 'text-center'},
                    {name: 'depName', label: '用人部门', width: 0.1,className: 'text-center'},
                    {name: 'tittle', label: '招聘标题', width: 0.15,className: 'text-center'},
                    {name: 'requireNum', label: '需求人数', width: 0.1,className: 'text-center'},
                    {name: 'sexReq', label: '性别要求',width: 0.1,className: 'text-center'},
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
                        var job = rowData.jobId+"╪"+rowData.depName+"╪"+rowData.tittle+"╪"+rowData.jobDesc+"╪"+rowData.requireNum+"╪"+rowData.jobReq+"╪"+rowData.sexReq+"╪"+rowData.salary+"╪"+rowData.addr+"╪"+rowData.linkMan+"╪"+rowData.linkPhone+"╪"+rowData.createTime+"╪"+rowData.endTime+"╪"+rowData.createUser+"╪"+rowData.status;
                        responseData.data[i].myCheckbox='<i name="myCheckbox" onclick="changeCheckbox(this)" value="'+rowData.jobId+'" class="icon icon-check-empty">';
                        //添加操作按钮
                        responseData.data[i].operate= '<button class="btn btn-sm btn-info" type="button" title="详情" value="'+job+'" onclick="detail(this)"><i class="icon icon-zoom-in"></i></button>&nbsp&nbsp&nbsp&nbsp' +
                            '<button class="btn btn-sm btn-success" type="button" title="通过" value="'+job+'" onclick="pass(this)"><i class="icon icon-check"></i></button>&nbsp&nbsp&nbsp&nbsp' +
                            '<button class="btn btn-sm btn-warning" type="button" title="拒绝" value="'+job+'" onclick="noPass(this)"><i class="icon icon-times"></i></button>';
                    }
                    return responseData;
                }
            },
            states: {
                pager: {page: 1,recPerPage: 10},
                fixedLeftUntil: 0,    // 固定左侧第一列
                fixedRightFrom: 10,   // 从第12列开始固定到右侧
                fixedTopUntil: 0,     // 固定顶部第一行（标题行）
            },
            configs: {
                C1: {html:true},
                C10: {html:true}
            },
            checkable: false,
            checkByClickRow: false,
            showRowIndex: true

            // ... 其他初始化选项
        });

        $('#passBtn').click(function () {
            var jobId = $('#passModal .jobId').val();
            $.ajax({
                type: "post",
                url: 'passJob',
                data: {"jobId":jobId},
                cache: false,
                async : false,
                dataType: "json",
                success: function (data ,textStatus, jqXHR){
                    $('#passModal').modal('hide');
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
                    $('#passModal').modal('hide');
                    new $.zui.Messager('操作失败!', {
                        icon:'warning-sign',
                        type: 'warning',
                        time: 2000
                    }).show();
                }
            });
        })

        $('#noPassBtn').click(function () {
            var jobId = $('#noPassModal .jobId').val();
            $.ajax({
                type: "post",
                url: 'noPassJob',
                data: {"jobId":jobId},
                cache: false,
                async : false,
                dataType: "json",
                success: function (data ,textStatus, jqXHR){
                    $('#noPassModal').modal('hide');
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
                    $('#noPassModal').modal('hide');
                    new $.zui.Messager('操作失败!', {
                        icon:'warning-sign',
                        type: 'warning',
                        time: 2000
                    }).show();
                }
            });
        })

        $('#passSomeBtn').click(function () {
            var jobIdArr = $('#passSomeModal .jobIdArr').val();
            $.ajax({
                type: "post",
                url: 'passSomeJob',
                data: {"jobIdArr":jobIdArr},
                cache: false,
                async : false,
                dataType: "json",
                success: function (data ,textStatus, jqXHR){
                    $('#passSomeModal').modal('hide');
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
                    $('#passSomeModal').modal('hide');
                    new $.zui.Messager('操作失败!', {
                        icon:'warning-sign',
                        type: 'warning',
                        time: 2000
                    }).show();
                }
            });
        })

        $('#noPassSomeBtn').click(function () {
            var jobIdArr = $('#noPassSomeModal .jobIdArr').val();
            $.ajax({
                type: "post",
                url: 'noPassSomeJob',
                data: {"jobIdArr":jobIdArr},
                cache: false,
                async : false,
                dataType: "json",
                success: function (data ,textStatus, jqXHR){
                    $('#noPassSomeModal').modal('hide');
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
                    $('#noPassSomeModal').modal('hide');
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
        $('#createUser').html(job[13]);
        $('#createTime').html(job[11]);
        $('#endTime').html(job[12]);
        $('#jobDesc').html(job[3]);
        $('#addr').html(job[8]);
        $('#jobReq').html(job[5]);
        $('#sexReq').html(job[6]);
        $('#requireNum').html(job[4]);
        $('#salary').html(job[7]);
        $('#linkMan').html(job[9]);
        $('#linkPhone').html(job[10]);
        $('#detailModal').modal('show', 'fit');
    }

    function pass(obj) {
        var job = new Array();
        job = $(obj).val().split('╪');
        $('.jobId').val(job[0]);
        $('#passContent').html("确定要通过岗位：["+job[2]+"]的审核吗？");
        $('#passModal').modal('show', 'fit');
    }

    function noPass(obj) {
        var job = new Array();
        job = $(obj).val().split('╪');
        $('.jobId').val(job[0]);
        $('#noPassContent').html("确定不通过岗位：["+job[2]+"]的审核吗？");
        $('#noPassModal').modal('show', 'fit');
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

    function passSome() {
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
            $('#passSomeContent').html("确定要通过所选["+arr.length+"]个岗位的审核吗？");
            $('#passSomeModal').modal('show', 'fit');
        }
    }

    function noPassSome() {
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
            $('#noPassSomeContent').html("确定要拒绝所选["+arr.length+"]个岗位的审核吗？");
            $('#noPassSomeModal').modal('show', 'fit');
        }
    }
</script>
</body>
</html>