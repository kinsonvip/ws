<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>待评价合同列表</title>
    <!-- zui -->
    <link href="../zui/css/zui.css" rel="stylesheet">
    <link href="../zui/lib/datagrid/zui.datagrid.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid">
    <div class="row" style="background-color: #EDEDEE">
        <ol class="breadcrumb" style="float: left;margin-top: 20px">
            <li><i class="icon icon-home"></i>&nbsp&nbsp学生评价</li>
            <li>待评价合同列表</li>
        </ol>
        <a class="btn btn-success" style="float: right;margin-right: 3%;margin-top: 20px" href="javascript:location.reload();" title="刷新" ><i class="icon icon-refresh"></i></a>
    </div>
    <div class="row" style="height: auto;margin-left: 2%;margin-right: 2%;margin-top: 1%">
        <div id="unevaluatedContractGrid" class="datagrid">
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

<div class="modal fade" id="evalModal">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                <h4 class="modal-title">评价</h4>
            </div>
            <div class="modal-body">
                <form id="evaluateForm">
                    <div class="row">
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>思想品德：</h5></label>
                        <div class="col-md-2 col-sm-2">
                            <select class="form-control" id="inputSxpd">
                                <option value ="优秀">优秀</option>
                                <option value ="良好">良好</option>
                                <option value ="中等">中等</option>
                                <option value ="差评">差评</option>
                            </select>
                        </div>
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>敬业精神：</h5></label>
                        <div class="col-md-2 col-sm-2">
                            <select class="form-control" id="inputJyjs">
                                <option value ="优秀">优秀</option>
                                <option value ="良好">良好</option>
                                <option value ="中等">中等</option>
                                <option value ="差评">差评</option>
                            </select>
                        </div>
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>工作态度：</h5></label>
                        <div class="col-md-2 col-sm-2">
                            <select class="form-control" id="inputGztd">
                                <option value ="优秀">优秀</option>
                                <option value ="良好">良好</option>
                                <option value ="中等">中等</option>
                                <option value ="差评">差评</option>
                            </select>
                        </div>
                    </div>
                    <div class="row">
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>工作能力：</h5></label>
                        <div class="col-md-2 col-sm-2">
                            <select class="form-control" id="inputGznl">
                                <option value ="优秀">优秀</option>
                                <option value ="良好">良好</option>
                                <option value ="中等">中等</option>
                                <option value ="差评">差评</option>
                            </select>
                        </div>
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>协作精神：</h5></label>
                        <div class="col-md-2 col-sm-2">
                            <select class="form-control" id="inputXzjs">
                                <option value ="优秀">优秀</option>
                                <option value ="良好">良好</option>
                                <option value ="中等">中等</option>
                                <option value ="差评">差评</option>
                            </select>
                        </div>
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>综合素质：</h5></label>
                        <div class="col-md-2 col-sm-2">
                            <select class="form-control" id="inputZhsz">
                                <option value ="优秀">优秀</option>
                                <option value ="良好">良好</option>
                                <option value ="中等">中等</option>
                                <option value ="差评">差评</option>
                            </select>
                        </div>
                    </div>
                    <div class="row" style="margin-top: 10px">
                        <label class="col-md-offset-1 col-md-2 col-sm-2"><h5><i style="color: red">*</i>评价内容：</h5></label>
                        <div class="col-md-6 col-sm-10">
                            <textarea class="form-control" rows="6" id="inputEvaInfo" placeholder="请输入评价内容" data-rule="评价内容: required"></textarea>
                        </div>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <input type="hidden" value="" class="jobContractId">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="evalBtn">确定</button>
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

        $('#unevaluatedContractGrid').datagrid({
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
                    {name: 'confirmTime', label: '确认时间',className: 'text-center'},
                    {name: 'operate', label: '操作',width: 100,className: 'text-center'}
                ],
                remote: function(params) {
                    return {
                        // 请求地址
                        url: 'unevaluatedContractList',
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
                        responseData.data[i].operate='<button class="btn btn-sm btn-info" type="button" title="评价此合同" value="'+responseData.data[i].jobContractId+'" onclick="eval(this)"><i class="icon icon-edit"></i>评价</button>';
                    }
                    return responseData;
                }
            },
            states: {
                pager: {page: 1,recPerPage: 10},
                fixedLeftUntil: 0,    // 固定左侧第一列
                fixedRightFrom: 11,   // 从第11列开始固定到右侧
                fixedTopUntil: 0,     // 固定顶部第一行（标题行）
            },
            configs: {
                C11: {html:true}
            },
            checkable: false,
            checkByClickRow: false,
            showRowIndex: true

            // ... 其他初始化选项
        });

        $('#evalBtn').click(function () {
            var jobContractId = $('#evalModal .jobContractId').val();
            var sxpd = $('#inputSxpd').children('option:selected').val();
            var jyjs = $('#inputJyjs').children('option:selected').val();
            var gztd = $('#inputGztd').children('option:selected').val();
            var gznl = $('#inputGznl').children('option:selected').val();
            var xzjs = $('#inputXzjs').children('option:selected').val();
            var zhsz = $('#inputZhsz').children('option:selected').val();
            var evainfo = $('#inputEvaInfo').val().trim();
            if ($('#evaluateForm').isValid()){
                $.ajax({
                    type: "post",
                    url: 'evalContract',
                    data: {
                        "jobContractId":jobContractId,
                        "sxpd":sxpd,
                        "jyjs":jyjs,
                        "gztd":gztd,
                        "gznl":gznl,
                        "xzjs":xzjs,
                        "zhsz":zhsz,
                        "evainfo":evainfo,
                    },
                    cache: false,
                    async : false,
                    dataType: "json",
                    success: function (data ,textStatus, jqXHR){
                        $('#evalModal').modal('hide');
                        if("success"==data.status){
                            var unevaluatedContractGrid   = $('#unevaluatedContractGrid').data('zui.datagrid');
                            unevaluatedContractGrid.dataSource.data=null;
                            unevaluatedContractGrid.render();
                            new $.zui.Messager('操作成功!', {
                                icon:'ok',
                                type: 'success',
                                time: 2000
                            }).show();
                        }
                    },
                    error:function (jqXHR, textStatus, errorThrown) {
                        $('#evalModal').modal('hide');
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
            var unevaluatedContractGrid = $('#unevaluatedContractGrid').data('zui.datagrid');
            unevaluatedContractGrid.setPager(-1,-1,parseInt(recPerPage));
            unevaluatedContractGrid.render();
        })
    })

    function eval(obj) {
        $('#inputSxpd').val('优秀');
        $('#inputJyjs').val('优秀');
        $('#inputGztd').val('优秀');
        $('#inputGznl').val('优秀');
        $('#inputXzjs').val('优秀');
        $('#inputZhsz').val('优秀');
        $('#inputEvaInfo').val("");
        $('.jobContractId').val($(obj).val());
        $('#evalModal').modal('show', 'fit');
    }

</script>
</body>
</html>