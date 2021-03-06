<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="postRangeDialog" class="crudDialog">
    <form id="postRangeForm" method="post">

        <div class="form-group">
            <div class="row">
                <div class="col-md-5">
                    不在奖扣分范围内的岗位
                    <table id="noRangesTable"></table>
                </div>
                <div class="col-md-2">
                    <a class="btn btn-primary" style="margin-top: 150px" href="javascript:;" onclick="addRanges()">&gt;&gt;添加&gt;&gt;</a>
                    <a class="btn btn-danger" style="margin-top: 50px" href="javascript:;" onclick="removeRanges()">&lt;&lt;取消&lt;&lt;</a>
                </div>
                <div class="col-md-5">
                    在奖扣分范围内的岗位
                    <table id="rangesTable"></table>
                </div>
            </div>
        </div>
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="scoreRangeSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="scoreRangeDialog.close();">取消</a>
        </div>
    </form>
</div>
<script src="${basePath}/resources/zheng-admin/js/range.js"></script>
<script>

    function addRanges() {
        var rows = $noRangesTable.bootstrapTable('getSelections');
        $rangesTable.bootstrapTable('append', rows);
        var ids = $.map($noRangesTable.bootstrapTable('getSelections'), function (row) {
            return row.postId;
        });
        $noRangesTable.bootstrapTable('remove', {
            field: 'postId',
            values: ids
        });
    }


    function removeRanges() {
        var rows = $rangesTable.bootstrapTable('getSelections');
        $noRangesTable.bootstrapTable('append', rows);
        var ids = $.map($rangesTable.bootstrapTable('getSelections'), function (row) {
            return row.postId;
        });

        $rangesTable.bootstrapTable('remove', {
            field: 'postId',
            values: ids
        });
    }

    var $rangesTable = $('#rangesTable');
    $(function () {
        // bootstrap table初始化
        $rangesTable.bootstrapTable({
            url: '${basePath}/post/range',
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
                {field: 'postId', title: '岗位编号'},
                {field: 'postName', title: '岗位名称'},
                {field: 'postEmpName', title: '任职人'},
                {field: 'orgName', title: '所属部门'}
            ]
        });
    });

    var $noRangesTable = $('#noRangesTable');
    $(function () {
        // bootstrap table初始化
        $noRangesTable.bootstrapTable({
            url: '${basePath}/post/noRange',
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
                {field: 'postId', title: '岗位编号'},
                {field: 'postName', title: '岗位名称'},
                {field: 'postEmpName', title: '任职人'},
                {field: 'orgName', title: '所属部门'}
            ]
        });
    });


    function postRangeParams(params) {
        var temp = {
            limit: params.limit,
            offset: params.offset,
            sort: params.sort,
            order: params.order,
            postId: postRangePostId
        }
        return temp;
    }


    function scoreRangeSubmit() {
        var ids = $.map($rangesTable.bootstrapTable('getData'), function (row) {
            return row.postId;
        });

        $.ajax({
            type: 'post',
            url: '${basePath}/post/postRange',
            data: {
                ids: ids.join("-"),
                postId: postRangePostId
            },
            dataType: 'json',
            success: function (data) {
                if (data.success) {
                    postRangeDialog.close();
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