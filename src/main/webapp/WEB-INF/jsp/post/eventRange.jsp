<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="postEventRangeDialog" class="crudDialog">
    <form id="postEventRangeForm" method="post">

        <div class="form-group">
            <div class="row">
                <div class="col-md-5">
                    不在奖扣分范围内的事件
                    <table id="noEventRangesTable"></table>
                </div>
                <div class="col-md-2">
                    <a class="btn btn-primary" style="margin-top: 150px" href="javascript:;" onclick="addRanges()">&gt;&gt;添加&gt;&gt;</a>
                    <a class="btn btn-danger" style="margin-top: 50px" href="javascript:;" onclick="removeRanges()">&lt;&lt;取消&lt;&lt;</a>
                </div>
                <div class="col-md-5">
                    在奖扣分范围内的事件
                    <table id="eventRangesTable"></table>
                </div>
            </div>
        </div>
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="eventRangeSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="eventRangeDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>

    function addRanges() {
        var rows = $noEventRangesTable.bootstrapTable('getSelections');
        $eventRangesTable.bootstrapTable('append', rows);
        var ids = $.map($noEventRangesTable.bootstrapTable('getSelections'), function (row) {
            return row.eventId;
        });
        $noEventRangesTable.bootstrapTable('remove', {
            field: 'eventId',
            values: ids
        });
    }


    function removeRanges() {
        var rows = $eventRangesTable.bootstrapTable('getSelections');
        $noEventRangesTable.bootstrapTable('append', rows);
        var ids = $.map($eventRangesTable.bootstrapTable('getSelections'), function (row) {
            return row.eventId;
        });

        $eventRangesTable.bootstrapTable('remove', {
            field: 'eventId',
            values: ids
        });
    }

    var $eventRangesTable = $('#eventRangesTable');
    $(function () {
        // bootstrap table初始化
        $eventRangesTable.bootstrapTable({
            url: '${basePath}/post/eventRange',
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
    });

    var $noEventRangesTable = $('#noEventRangesTable');
    $(function () {
        // bootstrap table初始化
        $noEventRangesTable.bootstrapTable({
            url: '${basePath}/post/noEventRange',
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
            idField: 'eventId',
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
    });


    function postRangeParams(params) {
        var temp = {
            limit: params.limit,
            offset: params.offset,
            sort: params.sort,
            order: params.order,
            postId: eventRangePostId
        }
        return temp;
    }


    function eventRangeSubmit() {
        var ids = $.map($eventRangesTable.bootstrapTable('getData'), function (row) {
            return row.eventId;
        });

        $.ajax({
            type: 'post',
            url: '${basePath}/post/eventRange',
            data: {
                ids: ids.join("-"),
                postId: eventRangePostId
            },
            dataType: 'json',
            success: function (data) {
                if (data.success) {
                    eventRangeDialog.close();
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

</script>