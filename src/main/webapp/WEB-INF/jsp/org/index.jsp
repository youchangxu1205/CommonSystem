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
                <%--<div class="panel-body" style="overflow: inherit;">--%>
                <%--&lt;%&ndash;<ul id="orgTree" class="ztree"></ul>&ndash;%&gt;--%>
            </div>
            <%--<div class="alert alert-danger" role="alert"><a href="javascript:;" onclick="showNotInOrgEmpsAction()">${noInOrgEmpIds.size()}个员工没有分配岗位</a></div>--%>
            <div id="treeDiv"></div>
        </div>
        <div class="col-md-10">
            <div id="toolbar">
                <button type="button" class="btn btn-default" onclick="createAction()">添加部门</button>
                <button type="button" class="btn btn-default" onclick="orgTreeAction()">组织架构</button>
            </div>
            <table id="table" class="table"></table>
        </div>
    </div>
</div>

<div id="setting" class="btn-group-vertical" role="group" aria-label="btn" style="display: none">
    <button type="button" class="btn btn-default">Left</button>
    <button type="button" class="btn btn-default">Middle</button>
    <button type="button" class="btn btn-default">Right</button>
</div>
<jsp:include page="/resources/inc/footer.jsp" flush="true"/>
<script>
    //    function findDimensions() {
    //        var tree=document.getElementById('tree')
    //        tree.style.height = getHeight()+"px";
    //    }
    //    findDimensions();
    //    $(function () {
    //        $(window).resize(function () {
    //            findDimensions();
    //        });
    //    });

    function refreshTree() {
        $.ajax({
            type: 'get',
            url: '${basePath}/org/bootstrapOrgTree',
            dataType: 'json',
            beforeSend: function () {
            },
            success: function (data) {
                $('#treeDiv').treeview({
                    data: data,
                    onNodeSelected: function (event, data) {
                        // Your logic goes here
                        console.log(data);
                        orgId = data.id;
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


    var orgId = 0;
    $('#treeDiv').treeview({
        data: ${treeData},
        onNodeSelected: function (event, data) {
            // Your logic goes here
            console.log(data);
            orgId = data.id;
            $table.bootstrapTable('refresh');
        }
    });

    var $table = $('#table');
    $(function () {
        // bootstrap table初始化
        $table.bootstrapTable({
            url: '${basePath}/org/list',
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
            idField: 'orgId',
            maintainSelected: true,
            toolbar: '#toolbar',
            columns: [
                {field: 'ck', checkbox: true},
                {field: 'orgId', title: '编号', sortable: true, align: 'center'},
                {field: 'orgName', title: '名称'},
                {field: 'orgType', title: '类型', formatter: 'orgTypeFormatter'},
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


    function orgTypeFormatter(value, row, index) {
        if (value == 1) {
            return '<span class="label label-success">公司</span>';
        } else {
            return '<span class="label label-warning">部门</span>';
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
    }
    // 新增
    var createDialog;
    function createAction() {
        if (orgId == 0) {
            alert("请选择上级部门");
            return;
        }
        createDialog = $.dialog({
            animationSpeed: 300,
            title: '添加部门',
            content: 'url:${basePath}/org/create?orgId=' + orgId,
            onContentReady: function () {
                initMaterialInput();
                $('select').select2({
                    placeholder: '请选择上级部门',
                    allowClear: true
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
                title: '编辑组织',
                content: 'url:${basePath}/org/update/' + rows[0].orgId,
                onContentReady: function () {
                    initMaterialInput();
                }
            });
        }
    }

    var orgTreeDialog;
    function orgTreeAction() {
        orgTreeDialog = $.dialog({
            animationSpeed: 300,
            title: '组织架构',

            content: 'url:${basePath}/org/orgTree',
            onContentReady: function () {
                initMaterialInput();
            }
        });
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
                content: '确认删除该组织吗？',
                buttons: {
                    confirm: {
                        text: '确认',
                        btnClass: 'waves-effect waves-button',
                        action: function () {
                            var ids = new Array();
                            for (var i in rows) {
                                ids.push(rows[i].orgId);
                            }
                            $.ajax({
                                type: 'post',
                                url: '${basePath}/org/delete/' + ids.join("-"),
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