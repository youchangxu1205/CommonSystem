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
    <title>单据管理</title>
    <jsp:include page="/resources/inc/head.jsp" flush="true"/>
</head>
<body>
<div id="main">
    <div id="toolbar">
        <a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i class="zmdi zmdi-plus"></i>
            新增单据</a>
        <a class="waves-effect waves-button" href="javascript:;" onclick="updateAction()"><i class="zmdi zmdi-edit"></i>
            编辑单据</a>
        <a class="waves-effect waves-button" href="javascript:;" onclick="showDetailAction()"><i class="zmdi zmdi-edit"></i>
            查看单据详情</a>
    </div>
    <table id="table"></table>
</div>
<jsp:include page="/resources/inc/footer.jsp" flush="true"/>
<script>
    var showDetailDialog;
    function showDetailAction() {
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
            showDetailDialog = $.dialog({
                animationSpeed: 300,
                title: '单据详情',
                columnClass:'col-md-12',
                content: 'url:${basePath}/scorebill/detail/' + rows[0].scoreBillId,
                onContentReady: function () {
                    initMaterialInput();
                }
            });
        }
    }
    
    

    var $table = $('#table');
    $(function () {
        // bootstrap table初始化
        $table.bootstrapTable({
            url: '${basePath}/scorebill/list',
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
                {field: 'scoreBillId', title: '编号', sortable: true, align: 'center'},
                {field: 'scoreBillNo', title: '单据号'},
                {field: 'drawerName', title: '开单人'},
                {field: 'scoreBillDesc', title: '单据描述'},
                {field: 'scoreBillStatus', title: '单据状态',formatter:'scoreBillstatusFormatter'},
                {field: 'enable', title: '是否可用',formatter:'enableFormatter'},
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
    function scoreBillstatusFormatter(value, row, index) {
        if(value==1){
            return '<span class="label label-danger">待审核</span>';
        }else if(value == 2){
            return '<span class="label label-success">已审核</span>';
        }else{
            return '<span class="label label-default">已作废</span>';
        }
    }

    function enableFormatter(value, row, index) {
        if(value){
            return '<span class="label label-success">可用</span>';
        }else{
            return '<span class="label label-default">不可用</span>';
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
            order: params.order
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
        createDialog = $.dialog({
            animationSpeed: 300,
            title: '添加单据',
            columnClass:'col-md-12',
            content: 'url:${basePath}/scorebill/create',
            onContentReady: function () {
                initMaterialInput();
                $("#drawerId").select2({
                    placeholder: '请选择开单人'
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
                title: '编辑单据',
                content: 'url:${basePath}/scorebill/update/' + rows[0].enterpriseId,
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
                content: '确认删除该单据吗？',
                buttons: {
                    confirm: {
                        text: '确认',
                        btnClass: 'waves-effect waves-button',
                        action: function () {
                            var ids = new Array();
                            for (var i in rows) {
                                ids.push(rows[i].scoreEventId);
                            }
                            $.ajax({
                                type: 'post',
                                url: '${basePath}/scorebill/delete/' + ids.join("-"),
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