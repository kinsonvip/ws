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
<body>
    <div class="container-fluid">
        <div class="row" style="background-color: #EDEDEE">
            <ol class="breadcrumb" style="float: left;margin-top: 20px">
                <li><i class="icon icon-home"></i>&nbsp&nbsp学生管理</li>
                <li>学生列表</li>
            </ol>
            <a class="btn btn-success" style="float: right;margin-right: 3%;margin-top: 20px" href="javascript:location.replace(location.href);" title="刷新" ><i class="icon icon-refresh"></i></a>
        </div>
        <div class="row" style="height: auto;margin-left: 2%;margin-right: 2%;margin-top: 1%">
            <div id="studentGrid" class="datagrid">
                <div class="input-control search-box search-box-circle has-icon-left has-icon-right" id="searchbox" style="margin-bottom: 10px; max-width: 300px">
                    <input id="inputSearch" type="search" class="form-control search-input" placeholder="输入学号搜索">
                    <label for="inputSearch" class="input-control-icon-left search-icon"><i class="icon icon-search"></i></label>
                    <a href="#" class="input-control-icon-right search-clear-btn"><i class="icon icon-remove"></i></a>
                </div>
                <div class="datagrid-container"></div>
                <div id="myPager" class="pager" data-elements="size_menu,first,prev,goto,next,last,page_of_total_text" data-page-Size-Options="5,10,15,20" style="margin-left: 30%"></div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="unlockModal">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                    <h4 class="modal-title">解锁用户</h4>
                </div>
                <div class="modal-body">
                    <p id="unlockContent">主题内容...</p>
                </div>
                <div class="modal-footer">
                    <input type="hidden" value="" class="stuNum">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="unlockBtn">确定</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade" id="lockModal">
        <div class="modal-dialog modal-sm">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">×</span><span class="sr-only">关闭</span></button>
                    <h4 class="modal-title">锁定用户</h4>
                </div>
                <div class="modal-body">
                    <p id="lockContent">主题内容...</p>
                </div>
                <div class="modal-footer">
                    <input type="hidden" value="" class="stuNum">
                    <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
                    <button type="button" class="btn btn-primary" id="lockBtn">确定</button>
                </div>
            </div>
        </div>
    </div>

    <script src="../jquery/jquery-3.2.1.min.js"></script>
    <!-- ZUI Javascript组件 -->
    <script src="../zui/js/zui.js"></script>
    <script src="../zui/lib/datagrid/zui.datagrid.js"></script>
    <script src="../js/admin/studentManage.js" stype="text/javascript"></script>
</body>
</html>