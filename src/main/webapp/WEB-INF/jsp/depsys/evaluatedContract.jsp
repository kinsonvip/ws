<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>已评价合同列表</title>
    <!-- zui -->
    <link href="../zui/css/zui.css" rel="stylesheet">
    <link href="../zui/lib/datagrid/zui.datagrid.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid">
    <div class="row" style="background-color: #EDEDEE">
        <ol class="breadcrumb" style="float: left;margin-top: 20px">
            <li><i class="icon icon-home"></i>&nbsp&nbsp学生评价</li>
            <li>已评价合同列表</li>
        </ol>
        <a class="btn btn-success" style="float: right;margin-right: 3%;margin-top: 20px" href="javascript:location.reload();" title="刷新" ><i class="icon icon-refresh"></i></a>
    </div>
    <div class="row" style="height: auto;margin-left: 2%;margin-right: 2%;margin-top: 1%">
        <div id="evaluatedContractGrid" class="datagrid">
            <div class="row">
                <div class="input-control search-box search-box-circle has-icon-left has-icon-right" id="searchbox" style="margin-bottom: 10px; max-width: 300px;float: left">
                    <input id="inputSearch" type="search" class="form-control search-input" placeholder="输入岗位名称搜索">
                    <label for="inputSearch" class="input-control-icon-left search-icon"><i class="icon icon-search"></i></label>
                    <a href="#" class="input-control-icon-right search-clear-btn"><i class="icon icon-remove"></i></a>
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
                <h4 class="modal-title">合同评价详情</h4>
            </div>
            <div class="modal-body">
                <article class="article">
                    <header>
                        <h1 class="text-center" id="jobName">岗位名称</h1>
                        <dl class="dl-inline">
                            <dt>合同号：</dt>
                            <dd id="jobContractId"></dd>
                            <dt>薪资（/天）：</dt>
                            <dd id="salary"></dd>
                            <dt>工作天数：</dt>
                            <dd id="workdays"></dd>
                            <dt>评价人：</dt>
                            <dd id="evaluater"></dd>
                            <dt>评价时间：</dt>
                            <dd id="evaluateTime"></dd>
                        </dl>
                    </header>
                    <section class="content" style="text-indent: 2em">
                        <div class="row">
                            <div class="col-md-4 col-sm-4">
                                <strong>学号：</strong><span id="stuNum">内容</span>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <strong>学生姓名：</strong><span id="stuName">内容</span>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <strong>性别：</strong><span id="sex">内容</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-sm-4">
                                <strong>思想品德：</strong><span id="sxpd">内容</span>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <strong>敬业精神：</strong><span id="jyjs">内容</span>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <strong>工作态度：</strong><span id="gztd">内容</span>
                            </div>
                        </div>
                        <div class="row">
                            <div class="col-md-4 col-sm-4">
                                <strong>工作能力：</strong><span id="gznl">内容</span>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <strong>协作精神：</strong><span id="xzjs">内容</span>
                            </div>
                            <div class="col-md-4 col-sm-4">
                                <strong>综合素质：</strong><span id="zhsz">内容</span>
                            </div>
                        </div>
                        <p><strong>评价信息：</strong><span id="evaInfo">内容</span></p>
                    </section>
                </article>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
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

        $('#evaluatedContractGrid').datagrid({
            dataSource: {
                cols:[
                    {name: 'jobContractId', label: '合同号', width: 140,className: 'text-center'},
                    {name: 'createTime', label: '合同生成时间', width: 140,className: 'text-center'},
                    {name: 'jobName', label: '岗位名称', width: 140,className: 'text-center'},
                    {name: 'stuNum', label: '学号', width: 100,className: 'text-center'},
                    {name: 'stuName', label: '姓名',width: 100,className: 'text-center'},
                    {name: 'sex', label: '性别',width: 100,className: 'text-center'},
                    {name: 'salary', label: '薪资/天',width: 100,className: 'text-center'},
                    {name: 'workdays', label: '工作天数',width: 100,className: 'text-center'},
                    {name: 'confirmUser', label: '确认人',width: 140,className: 'text-center'},
                    {name: 'confirmTime', label: '确认时间',width: 140,className: 'text-center'},
                    {name: 'evaluater', label: '评价人',width: 140,className: 'text-center'},
                    {name: 'confirmTime', label: '评价时间',width: 140,className: 'text-center'},
                    {name: 'operate', label: '操作',width: 100,className: 'text-center'}
                ],
                remote: function(params) {
                    return {
                        // 请求地址
                        url: 'evaluatedContractList',
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
                        var contractEvaluate = rowData.jobContractId+"╪"+rowData.createTime+"╪"+rowData.jobName+"╪"+rowData.stuNum+"╪"+rowData.stuName+"╪"+rowData.sex+"╪"+rowData.salary+"╪"+rowData.workdays+"╪"+rowData.confirmUser+"╪"+rowData.confirmTime+"╪"+rowData.evaluater+"╪"+rowData.evaluateTime+"╪"+rowData.sxpd+"╪"+rowData.jyjs+"╪"+rowData.gztd+"╪"+rowData.gznl+"╪"+rowData.xzjs+"╪"+rowData.zhsz+"╪"+rowData.evaInfo;
                        //添加操作按钮
                        responseData.data[i].operate='<button class="btn btn-sm btn-info" type="button" title="查看合同评价" value="'+contractEvaluate+'" onclick="detail(this)"><i class="icon icon-zoom-in"></i>查看评价</button>';
                    }
                    return responseData;
                }
            },
            states: {
                pager: {page: 1,recPerPage: 10},
                fixedLeftUntil: 0,    // 固定左侧第一列
                fixedRightFrom: 13,   // 从第11列开始固定到右侧
                fixedTopUntil: 0,     // 固定顶部第一行（标题行）
            },
            configs: {
                C13: {html:true}
            },
            checkable: false,
            checkByClickRow: false,
            showRowIndex: true

            // ... 其他初始化选项
        });

        $("#recPerPage").change(function () {
            var recPerPage = $(this).children('option:selected').val();
            // 获取数据表格实例
            var evaluatedContractGrid = $('#evaluatedContractGrid').data('zui.datagrid');
            evaluatedContractGrid.setPager(-1,-1,parseInt(recPerPage));
            evaluatedContractGrid.render();
        })
    })

    function detail(obj) {
        var contractEvaluate = new Array();
        contractEvaluate = $(obj).val().split('╪');
        $('#jobContractId').html(contractEvaluate[0]);
        $('#jobName').html(contractEvaluate[2]);
        $('#salary').html(contractEvaluate[6]);
        $('#workdays').html(contractEvaluate[7]);
        $('#evaluater').html(contractEvaluate[10]);
        $('#evaluateTime').html(contractEvaluate[11]);
        $('#stuNum').html(contractEvaluate[3]);
        $('#stuName').html(contractEvaluate[4]);
        $('#sex').html(contractEvaluate[5]);
        $('#sxpd').html(contractEvaluate[12]);
        $('#jyjs').html(contractEvaluate[13]);
        $('#gztd').html(contractEvaluate[14]);
        $('#gznl').html(contractEvaluate[15]);
        $('#xzjs').html(contractEvaluate[16]);
        $('#zhsz').html(contractEvaluate[17]);
        $('#evaInfo').html(contractEvaluate[18]);
        $('#detailModal').modal('show', 'fit');
    }

</script>
</body>
</html>