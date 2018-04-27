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

    $('#depSysGrid').datagrid({
        dataSource: {
            cols:[
                {name: 'accountNum', label: '账号', width: 0.1,className: 'text-center'},
                {name: 'departmentName', label: '所属用人部门', width: 0.15,className: 'text-center'},
                {name: 'name', label: '姓名', width: 0.1,className: 'text-center'},
                {name: 'phone', label: '手机号',width: 0.15,className: 'text-center'},
                {name: 'email', label: '邮箱',width: 0.15,className: 'text-center'},
                {name: 'status', label: '状态',width: 0.1,className: 'text-center'},
                {name: 'lastLoginTime', label: '最后登陆',width: 0.15,className: 'text-center'},
                {name: 'operate', label: '操作',width: 150,className: 'text-center'}
            ],
            remote: function(params) {
                return {
                    // 请求地址
                    url: '/ws/admin/depSysList',
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
                    responseData.data[i].operate= '<button class="btn btn-sm btn-success" type="button" title="解锁" value="'+responseData.data[i].accountNum+'" onclick="unlock(this)"><i class="icon icon-unlock-alt"></i></button>&nbsp&nbsp&nbsp&nbsp' +
                        '<button class="btn btn-sm btn-warning" type="button" title="锁定" value="'+responseData.data[i].accountNum+'" onclick="lock(this)"><i class="icon icon-lock"></i></button>';
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

    $('#unlockBtn').click(function () {
        var accountNum = $('#unlockModal .accountNum').val();
        $.ajax({
            type: "post",
            url: '/ws/admin/unlockDepSys',
            data: {"accountNum":accountNum},
            cache: false,
            async : false,
            dataType: "json",
            success: function (data ,textStatus, jqXHR){
                $('#unlockModal').modal('hide');
                if("success"==data.status){
                    var depSysGrid   = $('#depSysGrid').data('zui.datagrid');
                    depSysGrid.dataSource.data=null;
                    depSysGrid.render();
                    new $.zui.Messager('操作成功!', {
                        icon:'ok',
                        type: 'success',
                        time: 2000
                    }).show();
                }
            },
            error:function (jqXHR, textStatus, errorThrown) {
                $('#unlockModal').modal('hide');
                new $.zui.Messager('操作失败!', {
                    icon:'warning-sign',
                    type: 'warning',
                    time: 2000
                }).show();
            }
        });
    })

    $('#lockBtn').click(function () {
        var accountNum = $('#lockModal .accountNum').val();
        $.ajax({
            type: "post",
            url: '/ws/admin/lockDepSys',
            data: {"accountNum":accountNum},
            cache: false,
            async : false,
            dataType: "json",
            success: function (data ,textStatus, jqXHR){
                $('#lockModal').modal('hide');
                if("success"==data.status){
                    var depSysGrid   = $('#depSysGrid').data('zui.datagrid');
                    depSysGrid.dataSource.data=null;
                    depSysGrid.render();
                    new $.zui.Messager('操作成功!', {
                        icon:'ok',
                        type: 'success',
                        time: 2000
                    }).show();
                }
            },
            error:function (jqXHR, textStatus, errorThrown) {
                $('#lockModal').modal('hide');
                new $.zui.Messager('操作失败!', {
                    icon:'warning-sign',
                    type: 'warning',
                    time: 2000
                }).show();
            }
        });
    })

})

function unlock(obj) {
    $('.accountNum').val($(obj).val());
    $('#unlockContent').html("确定要解除用户：["+$(obj).val()+"]的锁定吗？");
    $('#unlockModal').modal('show', 'fit');
}

function lock(obj) {
    $('.accountNum').val($(obj).val());
    $('#lockContent').html("确定要对用户：["+$(obj).val()+"]进行锁定吗？");
    $('#lockModal').modal('show', 'fit');
}