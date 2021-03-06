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
    <title>积分事件管理</title>
    <jsp:include page="/resources/inc/head.jsp" flush="true"/>
</head>
<body>
<div id="main">
    <div id="toolbar">

        <a class="waves-effect waves-button" href="javascript:;" onclick="createCategoryAction()"><i
                class="zmdi zmdi-plus"></i> 新增分类</a>
        <a class="waves-effect waves-button" href="javascript:;" onclick="updateCategoryAction()"><i
                class="zmdi zmdi-edit"></i> 修改分类</a>
        <a class="waves-effect waves-button" href="javascript:;" onclick="deleteCategoryAction()"><i
                class="zmdi zmdi-delete"></i> 删除分类</a>
        <a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i class="zmdi zmdi-plus"></i>
            新增事件</a>
        <a class="waves-effect waves-button" href="javascript:;" onclick="updateAction()"><i class="zmdi zmdi-edit"></i>
            编辑事件</a>
    </div>

    <div class="row">
        <div class="col-md-2">
            <div id="tree" class="panel panel-default">
                <div class="panel-heading">事件分类</div>
            </div>
            <div id="treeDiv"></div>
        </div>
        <div class="col-md-10">
            <table id="table"></table>
        </div>
    </div>

</div>
<jsp:include page="/resources/inc/footer.jsp" flush="true"/>
<script>
    var eventCategoryId;
    $('#treeDiv').treeview({
        data: ${eventCategories},
        onNodeSelected: function (event, data) {
            // Your logic goes here
            console.log(data);

            eventCategoryId = data.id;
            $table.bootstrapTable('refresh');
        }
    });

    function treeRefresh() {
        $.ajax({
            type: 'get',
            url: '${basePath}/event/listCategory',
            dataType: 'json',
            beforeSend: function () {

            },
            success: function (data) {
                $('#treeDiv').treeview({
                    data: data,
                    onNodeSelected: function (event, data) {
                        eventCategoryId = data.id;
                        $table.bootstrapTable('refresh');
                    }
                });
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

    var $table = $('#table');
    $(function () {
        // bootstrap table初始化
        $table.bootstrapTable({
            url: '${basePath}/event/list',
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
                {field: 'eventId', title: '编号', sortable: true, align: 'center'},
                {field: 'eventName', title: '事件名称'},
                {field: 'minScore', title: '最低分'},
                {field: 'maxScore', title: '最高分'},
                {field: 'fixed', title: '事件属性', formatter: 'fixedFormatter'},
                {field: 'eventDesc', title: '事件描述'},
                {
                    field: 'action',
                    title: '操作',
                    align: 'center',
                    formatter: 'actionFormatter',
                    events: 'actionEvents',
                    clickToSelect: false
                }
            ]
        });
    });

    function fixedFormatter(value, row, index) {
        if (value == 1) {
            return '<span class="label label-success">固定事件</span>';
        } else if (value == 0) {
            return '<span class="label label-danger">随机事件</span>';
        }
    }

    function tableRefresh() {
        $table.bootstrapTable('refresh');
    }

    function queryParams(params) {
        var temp = {
            limit: params.limit,
            offset: params.offset,
            sort: params.sort,
            order: params.order,
            eventCategoryId: eventCategoryId
        }
        return temp;
    }

    // 格式化操作按钮
    function actionFormatter(value, row, index) {
        return [
            '<a class="update" href="javascript:;" onclick="updateAction()" data-toggle="tooltip" title="Edit"><i class="glyphicon glyphicon-edit"></i></a>　',
            '<a class="delete" href="javascript:;" onclick="deleteAction()" data-toggle="tooltip" title="Remove"><i class="glyphicon glyphicon-remove"></i></a>'
        ].join('');
    }
    // 新增
    var createDialog;
    function createAction() {
        if (eventCategoryId==undefined) {
            $.confirm({
                title: false,
                content: '请选择分类！',
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
        createDialog = $.dialog({
            animationSpeed: 300,
            title: '添加事件',
            content: 'url:${basePath}/event/create',
            onContentReady: function () {
                initMaterialInput();
                $('select').select2({
                    placeholder: '请选择事件属性'
                });
            }
        });
    }

    // 新增
    var createCategoryDialog;
    function createCategoryAction() {

        createCategoryDialog = $.dialog({
            animationSpeed: 300,
            title: '添加分类',
            content: 'url:${basePath}/event/category/create',
            onContentReady: function () {
                initMaterialInput();
            }
        });
    }
    var updateCategoryDialog;
    function updateCategoryAction() {
        if (eventCategoryId == 0) {
            $.confirm({
                title: false,
                content: '请选择分类！',
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
        updateCategoryDialog = $.dialog({
            animationSpeed: 300,
            title: '修改分类',
            content: 'url:${basePath}/event/category/update/' + eventCategoryId,
            onContentReady: function () {
                initMaterialInput();
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
                title: '编辑事件',
                content: 'url:${basePath}/event/update/' + rows[0].eventId,
                onContentReady: function () {
                    initMaterialInput();
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
                content: '确认删除该事件吗？',
                buttons: {
                    confirm: {
                        text: '确认',
                        btnClass: 'waves-effect waves-button',
                        action: function () {
                            var ids = new Array();
                            for (var i in rows) {
                                ids.push(rows[i].eventId);
                            }
                            $.ajax({
                                type: 'post',
                                url: '${basePath}/event/delete/' + ids.join("-"),
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


    // 删除
    var deleteCategoryDialog;
    function deleteCategoryAction() {
        if (eventCategoryId == 0) {
            $.confirm({
                title: false,
                content: '请选择积分事件分类！',
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
            deleteCategoryDialog = $.confirm({
                type: 'red',
                animationSpeed: 300,
                title: false,
                content: '确认删除该分类吗？这将会删除分类下的事件，是否确定删除',
                buttons: {
                    confirm: {
                        text: '确认',
                        btnClass: 'waves-effect waves-button',
                        action: function () {

                            $.ajax({
                                type: 'post',
                                url: '${basePath}/event/deleteCategory/' + eventCategoryId,
                                dataType: 'json',
                                success: function (data) {
                                    if (data.success) {
                                        deleteCategoryDialog.close();
                                        treeRefresh();
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