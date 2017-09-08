<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<!DOCTYPE HTML>
<html lang="zh-cn">
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>组织管理</title>
    <jsp:include page="/resources/inc/head.jsp" flush="true"/>
</head>
<body>
<div id="main">

    <div class="row">
        <div class="col-md-2">
            <div id="tree" class="panel panel-default">
                <div class="panel-heading">组织架构</div>
            </div>
            <div id="treeDiv"></div>
        </div>
        <div class="col-md-10">
            <div id="toolbar">
                <shiro:hasPermission name="staffing:post:create">
                <a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i
                        class="zmdi zmdi-plus"></i> 新增岗位</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="staffing:post:update">
                <a class="waves-effect waves-button" href="javascript:;" onclick="updateAction()"><i
                        class="zmdi zmdi-edit"></i> 编辑岗位</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="staffing:post:emp">
                <a class="waves-effect waves-button" href="javascript:;" onclick="showEmpAction()"><i
                        class="zmdi zmdi-edit"></i> 查看岗位担任人</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="multiplescore:post:postrange">
                <a class="waves-effect waves-button" href="javascript:;" onclick="postRangeAction()"><i
                        class="zmdi zmdi-edit"></i> 岗位范围</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="multiplescore:post:eventrange">
                <a class="waves-effect waves-button" href="javascript:;" onclick="eventRangeAction()"><i
                        class="zmdi zmdi-edit"></i> 事件范围</a>
                </shiro:hasPermission>
            </div>
            <table id="table"></table>
        </div>
    </div>
</div>
<jsp:include page="/resources/inc/footer.jsp" flush="true"/>
<script>

    //初始化组织架构树
    $('#treeDiv').treeview({
        data: ${treeData},
        onNodeSelected: function (event, data) {
            // Your logic goes here
            console.log(data);

            orgId = data.id;
            $table.bootstrapTable('refresh');
        }
    });
    //初始化表格
    var $table = $('#table');
    $(function () {
        // bootstrap table初始化
        $table.bootstrapTable({
            url: '${basePath}/post/list',
            height: getHeight(),
            striped: true,
            showRefresh: true,
            minimumCountColumns: 2,
            clickToSelect: true,
            pagination: true,
            queryParams: 'queryParams',
            paginationLoop: false,
            sidePagination: 'server',
            silentSort: false,
            smartDisplay: false,
            escape: true,
            idField: 'empId',
            maintainSelected: true,
            toolbar: '#toolbar',
            columns: [
                {field: 'ck', checkbox: true},
                {field: 'postId', title: '编号', sortable: true, align: 'center'},
                {field: 'postName', title: '岗位名称'},
                {field: 'manager', title: '岗位属性', formatter: 'managerFormatter'}
            ]
        });
    });

    //查看岗位担任人
    var showEmpDialog;
    var showEmpPostId;
    function showEmpAction() {
        var rows = $table.bootstrapTable('getSelections');
        if (rows.length != 1) {
            $.confirm({
                title: false,
                content: '请选择一条记录！',
                autoClose: 'cancel|3000',
                backgroundDismiss: true,
                buttons: {
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            });
        } else {

            showEmpPostId = rows[0].postId;
            showEmpDialog = $.dialog({
                animationSpeed: 300,
                title: '岗位担任人',
                content: 'url:${basePath}/post/emp',
                columnClass: 'col-md-12',
                onContentReady: function () {
                    initMaterialInput();
                }
            });
        }
    }

    //设置岗位的事件范围
    var eventRangeDialog;
    var eventRangePostId;
    function eventRangeAction() {
        var rows = $table.bootstrapTable('getSelections');
        if (rows.length != 1) {
            $.confirm({
                title: false,
                content: '请选择一条记录！',
                autoClose: 'cancel|3000',
                backgroundDismiss: true,
                buttons: {
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            });
        } else {
            var post = rows[0];
            if (!post.manager) {
                $.confirm({
                    title: false,
                    content: '请选择岗位属性为管理岗的岗位！',
                    autoClose: 'cancel|3000',
                    backgroundDismiss: true,
                    buttons: {
                        cancel: {
                            text: '取消',
                            btnClass: 'waves-effect waves-button'
                        }
                    }
                });
                return;
            }

            eventRangePostId = rows[0].postId;
            eventRangeDialog = $.dialog({
                animationSpeed: 300,
                title: '奖扣分范围',
                content: 'url:${basePath}/post/eventRange/' + rows[0].postId,
                columnClass: 'col-md-12',
                onContentReady: function () {
                    initMaterialInput();
                }
            });
        }
    }
    //设置岗位的岗位范围
    var postRangeDialog;
    var postRangePostId;
    function postRangeAction() {
        var rows = $table.bootstrapTable('getSelections');
        if (rows.length != 1) {
            $.confirm({
                title: false,
                content: '请选择一条记录！',
                autoClose: 'cancel|3000',
                backgroundDismiss: true,
                buttons: {
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            });
        } else {
            var post = rows[0];
            if (!post.manager) {
                $.confirm({
                    title: false,
                    content: '请选择岗位属性为管理岗的岗位！',
                    autoClose: 'cancel|3000',
                    backgroundDismiss: true,
                    buttons: {
                        cancel: {
                            text: '取消',
                            btnClass: 'waves-effect waves-button'
                        }
                    }
                });
                return;
            }
            postRangePostId = rows[0].postId;
            postRangeDialog = $.dialog({
                animationSpeed: 300,
                title: '奖扣分范围',
                content: 'url:${basePath}/post/range/' + rows[0].postId,
                columnClass: 'col-md-12',
                onContentReady: function () {
                    initMaterialInput();
                }
            });
        }
    }




    function tableRefresh() {
        $table.bootstrapTable('refresh');
    }
    var orgId = 0;
    function queryParams(params) {
        var temp = {
            limit: params.limit,
            offset: params.offset,
            sort: params.sort,
            order: params.order,
            orgId: orgId
        }
        return temp;
    }

    // 格式化操作按钮
    function actionFormatter(value, row, index) {
        return [
            '<a class="update" href="javascript:;" onclick="updateAction()" data-toggle="tooltip" title="Edit"><i class="glyphicon glyphicon-edit"></i></a>　',
            '<a class="delete" href="javascript:;" onclick="deleteAction()" data-toggle="tooltip" title="Remove"><i class="glyphicon glyphicon-remove"></i></a>'
        ].join('');
    }// 格式化操作按钮
    function managerFormatter(value, row, index) {
        if (value) {
            return '<span class="label label-success">管理岗</span>';
        } else {
            return '<span class="label label-danger">非管理岗</span>';
        }
    }
    // 新增
    var createDialog;
    function createAction() {

        if (orgId == 0) {
            alert("请选择部门");
            return;
        }

        createDialog = $.dialog({
            animationSpeed: 300,
            title: '添加岗位',
            content: 'url:${basePath}/post/create?orgId=' + orgId,
            onContentReady: function () {
                initMaterialInput();
                $('select').select2({
                    placeholder: '请选择所属部门'
                });
            }
        });
    }
    // 编辑
    var updateDialog;
    function updateAction() {
        var rows = $table.bootstrapTable('getSelections');
        if (rows.length != 1) {
            $.confirm({
                title: false,
                content: '请选择一条记录！',
                autoClose: 'cancel|3000',
                backgroundDismiss: true,
                buttons: {
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            });
        } else {
            updateDialog = $.dialog({
                animationSpeed: 300,
                title: '编辑岗位',
                content: 'url:${basePath}/post/update/' + rows[0].postId,
                onContentReady: function () {
                    initMaterialInput();
                    $('select').select2({
                        placeholder: '请选择所属部门'
                    });
                }
            });
        }
    }
    // 删除
    var deleteDialog;
    function deleteAction() {
        var rows = $table.bootstrapTable('getSelections');
        if (rows.length == 0) {
            $.confirm({
                title: false,
                content: '请至少选择一条记录！',
                autoClose: 'cancel|3000',
                backgroundDismiss: true,
                buttons: {
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            });
        } else {
            deleteDialog = $.confirm({
                type: 'red',
                animationSpeed: 300,
                title: false,
                content: '确认删除该岗位吗？',
                buttons: {
                    confirm: {
                        text: '确认',
                        btnClass: 'waves-effect waves-button',
                        action: function () {
                            var ids = new Array();
                            for (var i in rows) {
                                ids.push(rows[i].postId);
                            }
                            $.ajax({
                                type: 'post',
                                url: '${basePath}/post/delete/' + ids.join("-"),
                                dataType: 'json',
                                success: function (data) {
                                    if (data.success) {
                                        deleteDialog.close();
                                        $table.bootstrapTable('refresh');
                                    } else {

                                        $.confirm({
                                            theme: 'dark',
                                            animation: 'rotateX',
                                            closeAnimation: 'rotateX',
                                            title: false,
                                            content: data.msg,
                                            buttons: {
                                                confirm: {
                                                    text: '确认',
                                                    btnClass: 'waves-effect waves-button waves-light'
                                                }
                                            }
                                        });
                                    }
                                },
                                error: function (XMLHttpRequest, textStatus, errorThrown) {
                                    $.confirm({
                                        theme: 'dark',
                                        animation: 'rotateX',
                                        closeAnimation: 'rotateX',
                                        title: false,
                                        content: textStatus,
                                        buttons: {
                                            confirm: {
                                                text: '确认',
                                                btnClass: 'waves-effect waves-button waves-light'
                                            }
                                        }
                                    });
                                }
                            });
                        }
                    },
                    cancel: {
                        text: '取消',
                        btnClass: 'waves-effect waves-button'
                    }
                }
            });
        }
    }
</script>
</body>
</html>