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
                <table id="showScoreBillDetailTable"></table>
            </div>
        </div>

</div>
<script>
    var $showScoreBillDetailTable = $('#showScoreBillDetailTable');
    $(function () {
        // bootstrap table初始化
        $showScoreBillDetailTable.bootstrapTable({
            data: ${scoreBillDetails},
            height: 500,
            striped: true,
            minimumCountColumns: 2,
            clickToSelect: true,
            escape: true,
            idField: 'empId',
            maintainSelected: true,
            columns: [
                {field: 'scoreBillDetailId', title: '编号', sortable: true, align: 'center'},
                {field: 'draweeName', title: '被开单人'},
                {field: 'eventName', title: '积分事件'},
                {field: 'scoreBillDetailScore', title: '单据分值'},
                {field: 'scoreBillDetailDesc', title: '单据描述'}
            ]
        });
    });
</script>