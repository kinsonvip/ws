<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>已通过审核岗位列表</title>
    <!-- zui -->
    <link href="../zui/css/zui.css" rel="stylesheet">
    <link href="../zui/lib/datagrid/zui.datagrid.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid">
    <div class="row" style="background-color: #EDEDEE">
        <ol class="breadcrumb" style="float: left;margin-top: 20px">
            <li><i class="icon icon-home"></i>&nbsp&nbsp岗位管理</li>
            <li>已通过审核岗位列表</li>
        </ol>
        <a class="btn btn-success" style="float: right;margin-right: 3%;margin-top: 20px" href="javascript:location.reload();" title="刷新" ><i class="icon icon-refresh"></i></a>
    </div>
    <div class="row" style="height: auto;margin-left: 2%;margin-right: 2%;margin-top: 1%">
        <div id="checkedJobGrid" class="datagrid">
            <div class="input-control search-box search-box-circle has-icon-left has-icon-right" id="searchbox" style="margin-bottom: 10px; max-width: 300px">
                <input id="inputSearch" type="search" class="form-control search-input" placeholder="输入岗位名称搜索">
                <label for="inputSearch" class="input-control-icon-left search-icon"><i class="icon icon-search"></i></label>
                <a href="#" class="input-control-icon-right search-clear-btn"><i class="icon icon-remove"></i></a>
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

        $('#checkedJobGrid').datagrid({
            dataSource: {
                cols:[
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
                        url: 'checkedJobList',
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
                        //添加操作按钮
                        responseData.data[i].operate= '<button class="btn btn-sm btn-info" type="button" title="详情" value="'+job+'" onclick="detail(this)"><i class="icon icon-zoom-in"></i></button>&nbsp&nbsp&nbsp&nbsp' +
                            '<button class="btn btn-sm btn-danger" type="button" title="删除" value="'+job+'" onclick="del(this)"><i class="icon icon-trash"></i></button>';
                    }
                    return responseData;
                }
            },
            states: {
                pager: {page: 1,recPerPage: 10},
                fixedLeftUntil: 0,    // 固定左侧第一列
                fixedRightFrom: 9,   // 从第12列开始固定到右侧
                fixedTopUntil: 0,     // 固定顶部第一行（标题行）
            },
            configs: {
                C0: {},
                C9: {html:true}
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
                        var checkedJobGrid   = $('#checkedJobGrid').data('zui.datagrid');
                        checkedJobGrid.dataSource.data=null;
                        checkedJobGrid.render();
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

        $("#recPerPage").change(function () {
            var recPerPage = $(this).children('option:selected').val();
            // 获取数据表格实例
            var checkedJobGrid = $('#checkedJobGrid').data('zui.datagrid');
            checkedJobGrid.setPager(-1,-1,parseInt(recPerPage));
            checkedJobGrid.render();
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

    function del(obj) {
        var job = new Array();
        job = $(obj).val().split('╪');
        $('.jobId').val(job[0]);
        $('#delContent').html("确定要删除岗位：["+job[2]+"]吗？");
        $('#delModal').modal('show', 'fit');
    }
</script>
</body>
</html>