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
            <a class="waves-effect waves-button" href="javascript:;" onclick="eventRangeSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="eventRangeDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>


    var $eventRangesTable = $('#eventRangesTable');
    $(function () {
        // bootstrap table初始化

        $eventRangesTable.bootstrapTable({
            url: '${basePath}/post/eventRange',
            height: 500,
            striped: true,
            minimumCountColumns: 2,
            clickToSelect: true,
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


    var $empRangesTable = $('#empRangesTable');
    $(function () {
        // bootstrap table初始化
        $empRangesTable.bootstrapTable({
            url: '${basePath}/post/eventRange',
            height: 500,
            striped: true,
            minimumCountColumns: 2,
            clickToSelect: true,
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


    function postRangeParams(params) {
        var temp = {
            limit: params.limit,
            offset: params.offset,
            sort: params.sort,
            order: params.order,
//            postId: rangPostId
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