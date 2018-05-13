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

    $('#studentGrid').datagrid({
        dataSource: {
            cols:[
                {name: 'stuNum', label: '学号', width: 100,className: 'text-center'},
                {name: 'majorName', label: '专业', width: 200,className: 'text-center'},
                {name: 'stuName', label: '姓名', width: 150,className: 'text-center'},
                {name: 'sex', label: '性别',width: 100,className: 'text-center'},
                {name: 'ethnic', label: '民族',width: 150,className: 'text-center'},
                {name: 'birth', label: '出生日期',width: 100,className: 'text-center'},
                {name: 'policitalStatus', label: '政治面貌',width: 80,className: 'text-center'},
                {name: 'phone', label: '手机号',width: 100,className: 'text-center'},
                {name: 'email', label: '邮箱',width: 200,className: 'text-center'},
                {name: 'status', label: '状态',width: 100,className: 'text-center'},
                {name: 'lastLoginTime', label: '最后登陆',width: 200,className: 'text-center'},
                {name: 'operate', label: '操作',width: 150,className: 'text-center'}
            ],
            remote: function(params) {
                return {
                    // 请求地址
                    url: 'stuList',
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
                    responseData.data[i].operate= '<button class="btn btn-sm btn-success" type="button" title="解锁" value="'+responseData.data[i].stuNum+'" onclick="unlock(this)"><i class="icon icon-unlock-alt"></i></button>&nbsp&nbsp&nbsp&nbsp' +
                        '<button class="btn btn-sm btn-warning" type="button" title="锁定" value="'+responseData.data[i].stuNum+'" onclick="lock(this)"><i class="icon icon-lock"></i></button>';
                }
                return responseData;
            }
        },
        states: {
            pager: {page: 1,recPerPage: 10},
            fixedLeftUntil: 0,    // 固定左侧第一列
            fixedRightFrom: 12,   // 从第12列开始固定到右侧
            fixedTopUntil: 0,     // 固定顶部第一行（标题行）
        },
        configs: {
            C0: {},
            C12: {html:true}
        },
        checkable: false,
        checkByClickRow: false,
        showRowIndex: true

        // ... 其他初始化选项
    });

    $('#unlockBtn').click(function () {
        var stuNum = $('#unlockModal .stuNum').val();
        $.ajax({
            type: "post",
            url: 'unlockStu',
            data: {"stuNum":stuNum},
            cache: false,
            async : false,
            dataType: "json",
            success: function (data ,textStatus, jqXHR){
                $('#unlockModal').modal('hide');
                if("success"==data.status){
                    var studentGrid   = $('#studentGrid').data('zui.datagrid');
                    studentGrid.dataSource.data=null;
                    studentGrid.render();
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
        var stuNum = $('#lockModal .stuNum').val();
        $.ajax({
            type: "post",
            url: 'lockStu',
            data: {"stuNum":stuNum},
            cache: false,
            async : false,
            dataType: "json",
            success: function (data ,textStatus, jqXHR){
                $('#lockModal').modal('hide');
                if("success"==data.status){
                    var studentGrid   = $('#studentGrid').data('zui.datagrid');
                    studentGrid.dataSource.data=null;
                    studentGrid.render();
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

    $("#recPerPage").change(function () {
        var recPerPage = $(this).children('option:selected').val();
        // 获取数据表格实例
        var studentGrid = $('#studentGrid').data('zui.datagrid');
        studentGrid.setPager(-1,-1,parseInt(recPerPage));
        studentGrid.render();
    })
})

function unlock(obj) {
    $('.stuNum').val($(obj).val());
    $('#unlockContent').html("确定要解除用户：["+$(obj).val()+"]的锁定吗？");
    $('#unlockModal').modal('show', 'fit');
}

function lock(obj) {
    $('.stuNum').val($(obj).val());
    $('#lockContent').html("确定要对用户：["+$(obj).val()+"]进行锁定吗？");
    $('#lockModal').modal('show', 'fit');
}