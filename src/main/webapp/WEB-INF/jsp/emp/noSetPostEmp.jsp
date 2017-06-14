<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="noSetPostEmpDialog" class="crudDialog">
    <form id="noSetPostEmpForm" method="post">
        <div id="noSetPostEmpToolbar">
            <a class="waves-effect waves-button" href="javascript:;" onclick="noSetPostEmpAction()"><i
                    class="zmdi zmdi-edit"></i> 更换岗位</a>

        </div>
        <div class="form-group">
            <div class="row">
                <div class="col-md-12">
                    <table id="noSetPostEmpTable"></table>
                </div>

            </div>
        </div>
    </form>
</div>
<script>
    function noSetPostEmpAction() {
        var rows = $noSetPostEmpTable.bootstrapTable('getSelections');
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

    var $noSetPostEmpTable = $('#noSetPostEmpTable');
    $(function () {
        // bootstrap table初始化
        $noSetPostEmpTable.bootstrapTable({
            url: '${basePath}/emp/noSetPostEmpTable',
            height: 500,
            striped: true,
            minimumCountColumns: 2,
            clickToSelect: true,
//            pagination: true,
            queryParams: 'postRangeParams',
            paginationLoop: false,
            sidePagination: 'server',
            silentSort: false,
            smartDisplay: false,
            escape: true,
            idField: 'postId',
            toolbar:'#noSetPostEmpToolbar',
            maintainSelected: true,
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




    function postRangeParams(params) {
        var temp = {
            limit: params.limit,
            offset: params.offset,
            sort: params.sort,
            order: params.order,
        }
        return temp;
    }


</script>