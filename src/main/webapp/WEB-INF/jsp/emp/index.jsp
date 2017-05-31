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
        <%--<div class="col-md-2">--%>
            <%--<div id="tree" class="panel panel-default">--%>
                <%--<div class="panel-heading">组织架构</div>--%>

                <%--<div class="panel-body">--%>

                    <%--<ul id="orgTree" class="ztree"></ul>--%>
                <%--</div>--%>
            <%--</div>--%>

        <%--</div>--%>
        <%--<div class="col-md-10">--%>
            <div id="toolbar">
                <shiro:hasPermission name="staffing:emp:create">
                    <a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i class="zmdi zmdi-plus"></i> 新增员工</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="staffing:emp:role">
                    <a class="waves-effect waves-button" href="javascript:;" onclick="empRoleAction()"><i class="zmdi zmdi-accounts"></i> 员工角色</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="staffing:emp:password">
                    <a class="waves-effect waves-button" href="javascript:;" onclick="changePwdAction()"><i class="zmdi zmdi-lock"></i> 修改密码</a>
                </shiro:hasPermission>


                员工状态:
                <select id="empStatus" name="empStatus" class="form-control" style="width: 100px"
                        onchange="tableRefresh()">
                    <option value="1">在职</option>
                    <option value="0">全部</option>
                    <option value="2">试岗中</option>
                    <option value="3">休长假</option>
                    <option value="-1">离职</option>
                    <option value="-2">试岗离开</option>
                </select>

            </div>
            <table id="table"></table>

        <%--</div>--%>
    </div>


</div>
<jsp:include page="/resources/inc/footer.jsp" flush="true"/>
<script>

    var $table = $('#table');
    $(function () {
        // bootstrap table初始化
        $table.bootstrapTable({
            url: '${basePath}/emp/list',
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
                {field: 'empId', title: '编号', sortable: true, align: 'center'},
                {field: 'username', title: '账户名'},
                {field: 'empName', title: '员工姓名'},
                {field: 'entryTime', title: '入职时间', sortable: true, formatter: 'dateFormatter'},
                {field: 'beFormalTime', title: '转正时间', sortable: true, formatter: 'dateFormatter'},
                {field: 'empStatus', title: '状态', sortable: true, formatter: 'statusFormatter'}
//                ,
//                {
//                    field: 'action',
//                    title: '操作',
//                    align: 'center',
//                    formatter: 'actionFormatter',
//                    events: 'actionEvents',
//                    clickToSelect: false
//                }
            ]
        });
    });

    var zTreeObj;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        view:{
            showIcon:false
        },
        async: {
            enable: true,
            type: "get",
            url: "${basePath}/org/orgTree/1",
            autoParam: ["id=orgId", "name"]
        },
        callback: {
            beforeClick: orgClick
        }
    };

    function orgClick(treeId, treeNode, clickFlag) {
        alert(treeNode.id);

        $table.bootstrapTable()
    }
    // zTree 的数据属性，深入使用请参考 API 文档（zTreeNode 节点数据详解）

    $(document).ready(function () {
        zTreeObj = $.fn.zTree.init($("#orgTree"), setting);
    });

    function tableRefresh() {
        $table.bootstrapTable('refresh');
    }

    function queryParams(params) {
        var temp = {
            limit: params.limit,
            offset: params.offset,
            sort: params.sort,
            order: params.order,
            empStatus: $("#empStatus").val(),
            orgId: 1
        }
        return temp;
    }

    function dateFormatter(value, row, index) {
        if (value == null || value == "")
            return '<span class="label label-danger">未设置</span>';

        var date = new Date(value);

        return getFormatDate(date, "yyyy年MM月dd日");
    }

    function statusFormatter(value, row, index) {
        if (value == -2) {
            return '<span class="label label-default">试岗离开</span>';
        } else if (value == -1) {
            return '<span class="label label-danger">离职</span>';
        } else if (value == 3) {
            return '<span class="label label-info">休长假</span>';
        } else if (value == 1) {
            return '<span class="label label-success">在职</span>';
        } else if (value == 2) {
            return '<span class="label label-primary">试岗中</span>';
        }
    }
    // 格式化操作按钮
    function actionFormatter(value, row, index) {
        return [
            '<a class="update" href="javascript:;" onclick="changePwdAction()" data-toggle="tooltip" title="ChangePwd">修改密码</i></a>　',
            '<a class="update" href="javascript:;" onclick="updateAction()" data-toggle="tooltip" title="Edit">编辑</i></a>　',
            '<a class="delete" href="javascript:;" onclick="deleteAction()" data-toggle="tooltip" title="Remove">删除</i></a>'
        ].join('');
    }

    var changePwdDialog;
    function changePwdAction() {
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
            changePwdDialog = $.dialog({
                animationSpeed: 300,
                title: '修改密码',
                content: 'url:${basePath}/emp/changePwd/' + rows[0].empId,
                onContentReady: function () {
                    initMaterialInput();
                }
            });
        }

    }


    // 新增
    var createDialog;
    function createAction() {
        createDialog = $.dialog({
            animationSpeed: 300,
            title: '添加员工',
            content: 'url:${basePath}/emp/create',
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
                title: '编辑员工',
                content: 'url:${basePath}/emp/update/' + rows[0].empId,
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
                content: '确认删除该员工吗？',
                buttons: {
                    confirm: {
                        text: '确认',
                        btnClass: 'waves-effect waves-button',
                        action: function () {
                            var ids = new Array();
                            for (var i in rows) {
                                ids.push(rows[i].empId);
                            }
                            $.ajax({
                                type: 'post',
                                url: '${basePath}/emp/delete/' + ids.join("-"),
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