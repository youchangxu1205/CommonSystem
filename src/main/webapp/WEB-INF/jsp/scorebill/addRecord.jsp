<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="addRecordDialog" class="crudDialog">
    <form id="addRecordForm" method="post">

        <div class="form-group">
            <div class="row">
                <div class="col-md-6">
                    选择积分事件
                    <table id="eventRangesTable"></table>
                </div>

                <div class="col-md-6">
                    选择被开单人
                    <table id="empRangesTable"></table>
                </div>
            </div>
        </div>
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="adddRecordSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="addRecordDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>

    var checkedEmpIds = new Array();
    var checkedEventIds = new Array();
    var $empRangesTable = $('#empRangesTable');
    var $eventRangesTable = $('#eventRangesTable');
    $(function () {
        // bootstrap table初始化
        //获取开单人的奖扣分事件
        $eventRangesTable.bootstrapTable({
            url: '${basePath}/event/empEvent',
            height: 500,
            striped: true,
            minimumCountColumns: 2,
            clickToSelect: true,
            queryParams: 'params',
            paginationLoop: false,
            sidePagination: 'server',
            silentSort: false,
            smartDisplay: false,
            escape: true,
            idField: 'postId',
            maintainSelected: true,
            columns: [
                {field: 'ck', checkbox: true},
                {field: 'eventId', title: '事件编号'},
                {field: 'eventName', title: '事件名称'},
                {field: 'eventDesc', title: '事件描述'},
                {field: 'maxScore', title: '最高分'},
                {field: 'minScore', title: '最低分'}
            ]
        });

        // bootstrap table初始化
        $empRangesTable.bootstrapTable({
            url: '${basePath}/emp/lowerEmp',
            height: 500,
            striped: true,
            minimumCountColumns: 2,
            queryParams: 'params',
            clickToSelect: true,
            paginationLoop: false,
            sidePagination: 'server',
            silentSort: false,
            smartDisplay: false,
            escape: true,
            idField: 'postId',
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

        $.each(recordRows, function (i, record) {
            checkedEmpIds[i] = record.draweeId;
            checkedEventIds[i] = record.eventId;
        });
//        console.log(checkedEmpIds);
//        console.log(checkedEventIds);
//        $empRangesTable.bootstrapTable('checkBy',{
//            field:'empId',
//            values:checkedEmpIds
//        });
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


    function params(params) {
        var temp = {
            limit: params.limit,
            offset: params.offset,
            sort: params.sort,
            order: params.order,
            empId: drawerId
        }
        return temp;
    }

    function adddRecordSubmit() {
        recordRows = new Array();
        var empRanges = $empRangesTable.bootstrapTable('getSelections');
        var eventRanges = $eventRangesTable.bootstrapTable('getSelections');
        $.each(empRanges, function (i, empRange) {
            $.each(eventRanges, function (j, eventRange) {

                var record = {
                    id:createUUID(),
                    drawerId: drawerId,
                    draweeId: empRange.empId,
                    scoreBillDetailScore: eventRange.minScore,
                    scoreBillDetailDesc: '无',
                    eventName: eventRange.eventName,
                    minScore: eventRange.minScore,
                    maxScore: eventRange.maxScore,
                    eventId: eventRange.eventId,
                    draweeName: empRange.empName
                };
                recordRows.push(record);
            });
        });

        $scoreBillDetailTable.bootstrapTable('append', recordRows);
        addRecordDialog.close();
    }


</script>