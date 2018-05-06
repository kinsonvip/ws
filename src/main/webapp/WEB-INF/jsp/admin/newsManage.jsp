<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>新闻管理列表</title>
    <!-- zui -->
    <link href="../zui/css/zui.css" rel="stylesheet">
    <link href="../zui/lib/datagrid/zui.datagrid.css" rel="stylesheet">
</head>
<body>
<div class="container-fluid">
    <div class="row" style="background-color: #EDEDEE">
        <ol class="breadcrumb" style="float: left;margin-top: 20px">
            <li><i class="icon icon-home"></i>&nbsp&nbsp网站管理</li>
            <li>新闻管理列表</li>
        </ol>
        <a class="btn btn-success" style="float: right;margin-right: 3%;margin-top: 20px" href="javascript:location.reload();" title="刷新" ><i class="icon icon-refresh"></i></a>
    </div>
    <div class="row" style="height: auto;margin-left: 2%;margin-right: 2%;margin-top: 1%">
        <div id="newsGrid" class="datagrid datagrid-striped">
            <div class="row">
                <div class="input-control search-box search-box-circle has-icon-left has-icon-right" id="searchbox" style="margin-bottom: 10px; max-width: 300px;float: left">
                    <input id="inputSearch" type="search" class="form-control search-input" placeholder="输入新闻标题搜索">
                    <label for="inputSearch" class="input-control-icon-left search-icon"><i class="icon icon-search"></i></label>
                    <a href="#" class="input-control-icon-right search-clear-btn"><i class="icon icon-remove"></i></a>
                </div>
                <div style="float: left;margin-left: 2%">
                    <button class="btn btn-info" type="button" title="添加" onclick="add()"><i class="icon icon-plus"></i>&nbsp&nbsp添加新闻</button>
                </div>
                <div style="float: left;margin-left: 2%">
                    <button class="btn btn-danger" type="button" title="批量删除" onclick="delSome()"><i class="icon icon-trash"></i>&nbsp&nbsp批量删除</button>
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
                <h4 class="modal-title">新闻详情</h4>
            </div>
            <div class="modal-body">
                <article class="article">
                    <header>
                        <h1 class="text-center" id="tittle">新闻标题</h1>
                        <dl class="dl-inline">
                            <dt>创建人：</dt>
                            <dd id="publisher">某某人</dd>
                            <dt>建立时间：</dt>
                            <dd id="publishTime">2018-04-27 00:19:47</dd>
                        </dl>
                    </header>
                    <section class="content" style="text-indent: 2em">
                        <p><span id="content">内容</span></p>
                    </section>

                </article>
            </div>
            <div class="modal-footer">
                <input type="hidden" value="" class="newsId">
                <button type="button" class="btn btn-primary" data-dismiss="modal">确定</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="addModal">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                <h4 class="modal-title">添加新闻</h4>
            </div>
            <div class="modal-body">
                <div class="container-fluid">
                    <div class="row">
                        <label class="col-md-2 col-sm-2"><h5><i style="color: red">*</i>新闻标题：</h5></label>
                        <div class="col-md-8 col-sm-10">
                            <input type="text" class="form-control" id="newsTittle" placeholder="请输入新闻标题">
                        </div>
                    </div>
                    <h5><i style="color: red">*</i>新闻内容：</h5>
                    <script id="editor" type="text/plain" style="height: 400px"></script>
                </div>
            </div>
            <div class="modal-footer">
                <input type="hidden" value="" class="newsId">
                <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                <button type="button" class="btn btn-primary" id="addBtn">确定</button>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="delModal">
    <div class="modal-dialog modal-sm">
        <div class="modal-content">
            <div class="modal-header">
                <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                <h4 class="modal-title">删除新闻</h4>
            </div>
            <div class="modal-body">
                <p id="delContent">主题内容...</p>
            </div>
            <div class="modal-footer">
                <input type="hidden" value="" class="newsId">
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
                <input type="hidden" value="" class="newsIdArr">
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
<script type="text/javascript" charset="utf-8" src="../H-ui/lib/ueditor/1.4.3/ueditor.config.js"></script>
<script type="text/javascript" charset="utf-8" src="../H-ui/lib/ueditor/1.4.3/ueditor.all.js"> </script>
<script type="text/javascript" charset="utf-8" src="../H-ui/lib/ueditor/1.4.3/lang/zh-cn/zh-cn.js"></script>
<script>
    var ue = UE.getEditor('editor');
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

        $('#newsGrid').datagrid({
            height:'page',
            dataSource: {
                cols:[
                    {name: 'myCheckbox', label: '<i onclick="changeAllCheckbox(this)" class="icon icon-check-empty">', width: 36,className: 'text-center'},
                    {name: 'tittle', label: '新闻标题', width: 0.6},
                    {name: 'publisher', label: '创建人', width: 0.1,className: 'text-center'},
                    {name: 'publishTime', label: '创建时间', width: 0.2,className: 'text-center'},
                    {name: 'operate', label: '操作',width: 0.1,className: 'text-center'}
                ],
                remote: function(params) {
                    return {
                        // 请求地址
                        url: 'newsList',
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
                        var news = rowData.newsId+"╪"+rowData.publisher+"╪"+rowData.publishTime+"╪"+rowData.tittle+"╪"+rowData.content;
                        responseData.data[i].myCheckbox='<i name="myCheckbox" onclick="changeCheckbox(this)" value="'+rowData.newsId+'" class="icon icon-check-empty">';
                        //添加操作按钮
                        responseData.data[i].operate= '<button class="btn btn-sm btn-info" type="button" title="详情" value="'+news+'" onclick="detail(this)"><i class="icon icon-zoom-in"></i></button>&nbsp&nbsp&nbsp&nbsp' +
                            '<button class="btn btn-sm btn-danger" type="button" title="删除" value="'+news+'" onclick="del(this)"><i class="icon icon-trash"></i></button>';
                    }
                    return responseData;
                }
            },
            states: {
                pager: {page: 1,recPerPage: 10},
                fixedLeftUntil: 0,    // 固定左侧第一列
                fixedRightFrom: 5,   // 从第12列开始固定到右侧
                fixedTopUntil: 0,     // 固定顶部第一行（标题行）
            },
            configs: {
                C1: {html:true},
                C5: {html:true}
            },
            checkable: false,
            checkByClickRow: false,
            showRowIndex: true

            // ... 其他初始化选项
        });

        $('#delBtn').click(function () {
            var newsId = $('#delModal .newsId').val();
            $.ajax({
                type: "post",
                url: 'delNews',
                data: {"newsId":newsId},
                cache: false,
                async : false,
                dataType: "json",
                success: function (data ,textStatus, jqXHR){
                    $('#delModal').modal('hide');
                    if("success"==data.status){
                        var newsGrid   = $('#newsGrid').data('zui.datagrid');
                        newsGrid.dataSource.data=null;
                        newsGrid.render();
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
            var newsIdArr = $('#delSomeModal .newsIdArr').val();
            $.ajax({
                type: "post",
                url: 'delSomeNews',
                data: {"newsIdArr":newsIdArr},
                cache: false,
                async : false,
                dataType: "json",
                success: function (data ,textStatus, jqXHR){
                    $('#delSomeModal').modal('hide');
                    if("success"==data.status){
                        var newsGrid   = $('#newsGrid').data('zui.datagrid');
                        newsGrid.dataSource.data=null;
                        newsGrid.render();
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
        
        $("#addBtn").click(function () {
            var content = ue.getContent();
            var reg=/"/g;
            content = content.replace(reg,'\'');
            var tittle = $('#newsTittle').val();

            $.ajax({
                type: "post",
                url: 'addNews',
                data: {"tittle":tittle,"content":content},
                cache: false,
                async : false,
                dataType: "json",
                success: function (data ,textStatus, jqXHR){
                    $('#addModal').modal('hide');
                    if("success"==data.status){
                        var newsGrid   = $('#newsGrid').data('zui.datagrid');
                        newsGrid.dataSource.data=null;
                        newsGrid.render();
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
        })

        $("#recPerPage").change(function () {
            var recPerPage = $(this).children('option:selected').val();
            // 获取数据表格实例
            var newsGrid = $('#newsGrid').data('zui.datagrid');
            newsGrid.setPager(-1,-1,parseInt(recPerPage));
            newsGrid.render();
        })
    })

    function detail(obj) {
        var news = new Array();
        news = $(obj).val().split('╪');
        $('.newsId').val(news[0]);
        $('#tittle').html(news[3]);
        $('#publisher').html(news[1]);
        $('#publishTime').html(news[2]);
        $('#content').html(news[4]);
        $('#detailModal').modal('show', 'fit');
    }

    function add(obj) {
        ue.setContent('');
        $('#addModal').modal('show', 'fit');
    }

    function del(obj) {
        var news = new Array();
        news = $(obj).val().split('╪');
        $('.newsId').val(news[0]);
        $('#delContent').html("确定删除新闻：["+news[3]+"]吗？");
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
            $('.newsIdArr').val(arr);
            $('#delSomeContent').html("确定要删除所选["+arr.length+"]个新闻吗？");
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