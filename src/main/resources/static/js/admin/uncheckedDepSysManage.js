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

    $('#uncheckedDepSysGrid').datagrid({
        dataSource: {
            cols:[
                {name: 'accountNum', label: '账号', width: 0.1,className: 'text-center'},
                {name: 'departmentName', label: '所属用人部门', width: 0.15,className: 'text-center'},
                {name: 'name', label: '姓名', width: 0.1,className: 'text-center'},
                {name: 'phone', label: '手机号',width: 0.15,className: 'text-center'},
                {name: 'email', label: '邮箱',width: 0.15,className: 'text-center'},
                {name: 'status', label: '状态',width: 0.1,className: 'text-center'},
                {name: 'createTime', label: '创建时间',width: 0.15,className: 'text-center'},
                {name: 'operate', label: '操作',width: 150,className: 'text-center'}
            ],
            remote: function(params) {
                return {
                    // 请求地址
                    url: 'uncheckedDepSysList',
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
                    responseData.data[i].operate= '<button class="btn btn-sm btn-success" type="button" title="通过" value="'+responseData.data[i].accountNum+'" onclick="pass(this)"><i class="icon icon-check"></i></button>&nbsp&nbsp&nbsp&nbsp' +
                        '<button class="btn btn-sm btn-warning" type="button" title="拒绝" value="'+responseData.data[i].accountNum+'" onclick="noPass(this)"><i class="icon icon-times"></i></button>';
                }
                return responseData;
            }
        },
        states: {
            pager: {page: 1,recPerPage: 10},
            fixedLeftUntil: 0,    // 固定左侧第一列
            fixedRightFrom: 8,   // 从第12列开始固定到右侧
            fixedTopUntil: 0,     // 固定顶部第一行（标题行）
        },
        configs: {
            C0: {},
            C8: {html:true}
        },
        checkable: false,
        checkByClickRow: false,
        showRowIndex: true

        // ... 其他初始化选项
    });

    $('#passBtn').click(function () {
        var accountNum = $('#passModal .accountNum').val();
        $.ajax({
            type: "post",
            url: 'passEmpDepSys',
            data: {"accountNum":accountNum},
            cache: false,
            async : false,
            dataType: "json",
            success: function (data ,textStatus, jqXHR){
                $('#passModal').modal('hide');
                if("success"==data.status){
                    var uncheckedDepSysGrid   = $('#uncheckedDepSysGrid').data('zui.datagrid');
                    uncheckedDepSysGrid.dataSource.data=null;
                    uncheckedDepSysGrid.render();
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
        var accountNum = $('#noPassModal .accountNum').val();
        $.ajax({
            type: "post",
            url: 'noPassEmpDepSys',
            data: {"accountNum":accountNum},
            cache: false,
            async : false,
            dataType: "json",
            success: function (data ,textStatus, jqXHR){
                $('#noPassModal').modal('hide');
                if("success"==data.status){
                    var uncheckedDepSysGrid   = $('#uncheckedDepSysGrid').data('zui.datagrid');
                    uncheckedDepSysGrid.dataSource.data=null;
                    uncheckedDepSysGrid.render();
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

    $("#recPerPage").change(function () {
        var recPerPage = $(this).children('option:selected').val();
        // 获取数据表格实例
        var uncheckedDepSysGrid = $('#uncheckedDepSysGrid').data('zui.datagrid');
        uncheckedDepSysGrid.setPager(-1,-1,parseInt(recPerPage));
        uncheckedDepSysGrid.render();
    })
})

function pass(obj) {
    $('.accountNum').val($(obj).val());
    $('#passContent').html("确定要通过用户：["+$(obj).val()+"]的审核吗？");
    $('#passModal').modal('show', 'fit');
}

function noPass(obj) {
    $('.accountNum').val($(obj).val());
    $('#noPassContent').html("确定要拒绝用户：["+$(obj).val()+"]的申请吗？");
    $('#noPassModal').modal('show', 'fit');
}