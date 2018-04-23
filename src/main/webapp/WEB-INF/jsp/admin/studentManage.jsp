<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>学生列表管理</title>
    <!-- zui -->
    <link href="../zui/css/zui.css" rel="stylesheet">
    <link href="../zui/lib/datagrid/zui.datagrid.css" rel="stylesheet">
</head>
<body style="margin-left: 2%;margin-right: 2%">
    <div class="container-fluid">
        <div class="row" style="height: auto">
            <div id="studentGrid" class="datagrid">
                <div class="datagrid-container"></div>
                <div id="myPager" class="pager" data-elements="size_menu,first,prev,goto,next,last,page_of_total_text" data-page-Size-Options="5,10,15,20" style="margin-left: 30%"></div>
            </div>
        </div>
    </div>

    <script src="../jquery/jquery-3.2.1.min.js"></script>
    <!-- ZUI Javascript组件 -->
    <script src="../zui/js/zui.js"></script>
    <script src="../zui/lib/datagrid/zui.datagrid.js"></script>
    <script type="text/javascript">
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
                        {name: 'stuNum', label: '学号', width: 100,className: 'text-center stuName'},
                        {name: 'majorName', label: '专业', width: 200,className: 'text-center'},
                        {name: 'stuName', label: '姓名', width: 100,className: 'text-center'},
                        {name: 'sex', label: '性别',width: 50,className: 'text-center'},
                        {name: 'ethnic', label: '民族',width: 50,className: 'text-center'},
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
                            url: '/ws/admin/stuList',
                            // 请求类型
                            type: 'GET',
                            // 数据类型
                            dataType: 'json'
                        };
                    },
                    remoteConverter:function (responseData,textStatus,jqXHR,datagrid) {
                        jqxhr = jqXHR;
                        for(var i = 0;i < responseData.data.length;i++){
                            //添加操作按钮
                            responseData.data[i].operate= '<button class=\"btn btn-sm btn-success \" type=\"button\" title="解锁"><i class="icon icon-unlock-alt"></i></button>&nbsp&nbsp&nbsp&nbsp' +
                                '<button class=\"btn btn-sm btn-warning \" type=\"button\" title="锁定"><i class="icon icon-lock"></i></button>';
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

            $('#myPager').on('onPageChange', function(e, state, oldState) {
                if (state.page !== oldState.page) {
                    console.log('页码从', oldState.page, '变更为', state.page);
                    console.log(state.recPerPage);
                }

                // 获取分页器实例对象
                var myPager = $('#myPager').data('zui.pager');
                //myPager.render();
                // 设置当前页码为 4，并同时设置记录总数为 100， 每页记录数目为 30
                /*myPager.set({
                    recTotal: 1000
                });*/
            });

        })

    </script>
</body>
</html>