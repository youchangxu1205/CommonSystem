<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="createDialog" class="crudDialog">

    <div class="row">
        <div class="col-md-12">
            <table id="showPostEmpTable"></table>
        </div>
    </div>

</div>
<script>
    var $showPostEmpTable = $('#showPostEmpTable');
    $(function () {
        // bootstrap table初始化
        $showPostEmpTable.bootstrapTable({
            url: '${basePath}/post/emp/' + showEmpPostId,
            height: 500,
            striped: true,
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
            columns: [
                {field: 'ck', checkbox: true},
                {field: 'empId', title: '编号', sortable: true, align: 'center'},
                {field: 'username', title: '账户名'},
                {field: 'empName', title: '员工姓名'},
                {field: 'entryTime', title: '入职时间',  formatter: 'dateFormatter'},
                {field: 'beFormalTime', title: '转正时间',  formatter: 'dateFormatter'},
                {field: 'empStatus', title: '状态',  formatter: 'statusFormatter'}
            ]
        });
    });

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
</script>