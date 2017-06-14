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
            <div id="noSetPostEmpCount" class="alert alert-danger"></div>
            <div id="treeDiv"></div>
        </div>
        <div class="col-md-10">
            <div id="toolbar">
                <shiro:hasPermission name="staffing:emp:create">
                    <a class="waves-effect waves-button" href="javascript:;" onclick="createAction()"><i
                            class="zmdi zmdi-plus"></i> 新增员工</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="staffing:emp:role">
                    <a class="waves-effect waves-button" href="javascript:;" onclick="empRoleAction()"><i
                            class="zmdi zmdi-accounts"></i> 员工角色</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="staffing:emp:password">
                    <a class="waves-effect waves-button" href="javascript:;" onclick="changePwdAction()"><i
                            class="zmdi zmdi-lock"></i> 修改密码</a>
                </shiro:hasPermission>
                <shiro:hasPermission name="staffing:emp:update">
                    <a class="waves-effect waves-button" href="javascript:;" onclick="updateAction()"><i
                            class="zmdi zmdi-edit"></i> 编辑员工</a>
                </shiro:hasPermission>
                <%--<shiro:hasPermission name="staffing:emp:update">--%>
                <a class="waves-effect waves-button" href="javascript:;" onclick="empRangeAction()"><i
                        class="zmdi zmdi-edit"></i> 奖扣分范围</a>
                <%--</shiro:hasPermission>--%>
                <%--<a class="waves-effect waves-button" href="javascript:;" onclick="empOrgAction()"><i--%>
                <%--class="zmdi zmdi-edit"></i> 更换部门</a>--%>

                <a class="waves-effect waves-button" href="javascript:;" onclick="empPostAction()"><i
                        class="zmdi zmdi-edit"></i> 更换岗位</a>
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
        </div>

    </div>
</div>
<jsp:include page="/resources/inc/footer.jsp" flush="true"/>
<script>
    setNoSetPostEmpsCount();
    var $noSetPostEmpCount = $("#noSetPostEmpCount");
    function setNoSetPostEmpsCount() {
        $.ajax({
            type: 'get',
            url: '${basePath}/emp/noSetPostEmpCount',
            dataType: 'json',
            beforeSend: function () {

            },
            success: function (data) {
                if(data==0){
                    $noSetPostEmpCount.hide();
                }else {
                    $noSetPostEmpCount.show();
                    $noSetPostEmpCount.empty();
                    $noSetPostEmpCount.append("<a class='waves-effect waves-button' href='javascript:;' onclick='showNoSetPostEmpAction()'>还有" + data + "个人未设置岗位</a>");
                }
            },
            error: function (XMLHttpRequest, textStatus, errorThrown) {
            }
        });
    }


    console.log(${treeData});
    $('#treeDiv').treeview({
        data: ${treeData},
        onNodeSelected: function (event, data) {
            // Your logic goes here
            console.log(data);

            orgId = data.id;
            $table.bootstrapTable('refresh');
        }
    });


    //    function findDimensions() {
    //        var tree = document.getElementById('tree')
    //        var height = getHeight() - 50;
    //        tree.style.height = height + "px";
    //    }
    //    findDimensions();
    //    $(function () {
    //        $(window).resize(function () {
    //            findDimensions();
    //        });
    //    });

    var orgId = 0;
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
            showExport: true,
            exportDataType: 'excel',
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
            ]
        });
    });

    function tableRefresh() {
        $table.bootstrapTable('refresh');
    }

    function queryParams(params) {
        console.log(params);
        var temp = {
            limit: params.limit,
            offset: params.offset,
            sort: params.sort,
            order: params.order,
            empStatus: $("#empStatus").val(),
            orgId: orgId
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
        if (orgId == 0) {
            alert("请选择部门");
            return;
        }
        createDialog = $.dialog({
            animationSpeed: 300,
            title: '添加员工',
            content: 'url:${basePath}/emp/create?orgId=' + orgId,
            onContentReady: function () {
                initMaterialInput();
            }
        });
    }

    // 查看未分配岗位的员工
    var showNoSetPostEmpDialog;
    function showNoSetPostEmpAction() {

        showNoSetPostEmpDialog = $.dialog({
            animationSpeed: 300,
            title: '查看未分配岗位的员工',
            columnClass: 'col-md-12',
            content: 'url:${basePath}/emp/noSetPostEmp',
            onContentReady: function () {
                initMaterialInput();
            }
        });
    }

    // 员工角色
    var roleDialog;
    var roleEmpId;
    function empRoleAction() {
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
            roleEmpId = rows[0].empId;
            roleDialog = $.dialog({
                animationSpeed: 300,
                title: '用户角色',
                content: 'url:${basePath}/emp/role/' + roleEmpId,
                onContentReady: function () {
                    initMaterialInput();
                    $('select').select2({
                        placeholder: '请选择用户角色',
                        allowClear: true
                    });
                }
            });
        }
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

    var empRangeDialog;
    var empRangeEmpId
    function empRangeAction() {
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
            empRangeEmpId = rows[0].empId;
            empRangeDialog = $.dialog({
                animationSpeed: 300,
                title: '奖扣分范围',
                content: 'url:${basePath}/emp/range/' + rows[0].empId,
                onContentReady: function () {
                    initMaterialInput();
                    $('#empIds').select2({
                        placeholder: '请选择员工'
                    });

                    $('#eventIds').select2({
                        placeholder: '请选择积分事件'
                    });
                }
            });
        }
    }

    var empOrgDialog;
    var orgEmpId
    function empOrgAction() {
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
            orgEmpId = rows[0].empId;
            empOrgDialog = $.dialog({
                animationSpeed: 300,
                title: '更换部门',
                content: 'url:${basePath}/emp/org/' + rows[0].empId,
                onContentReady: function () {
                    initMaterialInput();
                    $('select').select2({
                        placeholder: '请选择员工',
                        allowClear: true
                    });
                }
            });
        }
    }


    var empPostDialog;
    var postEmpId
    function empPostAction() {
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
            postEmpId = rows[0].empId;
            empPostDialog = $.dialog({
                animationSpeed: 300,
                title: '更换岗位',
                content: 'url:${basePath}/emp/post/' + rows[0].empId,
                onContentReady: function () {
                    initMaterialInput();
                    $('select').select2({
                        placeholder: '请选择岗位',
                        allowClear: true
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