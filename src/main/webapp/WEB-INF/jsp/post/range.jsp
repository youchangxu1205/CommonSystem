<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="scoreRangeDialog" class="crudDialog">
    <form id="scoreRangeForm" method="post">
        <div class="form-group">
            <table id="rangesTable"></table>
        </div>
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="scoreRangeDialog.close();">取消</a>
        </div>
    </form>
</div>
<script src="${basePath}/resources/zheng-admin/js/range.js"></script>
<script>

    var $rangesTable = $('#rangesTable');
    $(function () {
        // bootstrap table初始化
        $rangesTable.bootstrapTable({
            url: '${basePath}/post/postRange',
            height: getHeight(),
            striped: true,
            showRefresh: true,
            minimumCountColumns: 2,
            clickToSelect: true,
            pagination: true,
            queryParams: 'postRangeParams',
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
                {field: 'orgPathName', title: '组织路径'},
                {field: 'postName', title: '岗位名称'},
                {field: 'postEmpName', title: '任职人'},
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

    function postRangeParams(params) {
        var temp = {
            limit: params.limit,
            offset: params.offset,
            sort: params.sort,
            order: params.order,
            eventCategoryId: eventCategoryId
        }
        return temp;
    }
    <%--var noChooseEmps = new Vue({--%>
    <%--el:'#noChooseEmps',--%>
    <%--data:{--%>
    <%--emps:${staffingEmps}--%>
    <%--}--%>
    <%--})--%>
    //初始化左边的数据
    //1.初始化员工列表
    //2.初始化岗位列表
    //3.初始化部门列表
    //初始化右边的数据
</script>