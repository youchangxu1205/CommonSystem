<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="createDialog" class="crudDialog">
    <form id="createForm" method="post">
        <div class="row">
            <div class="col-md-4">
                <label>开单人:</label>
                <div class="form-group">

                    <select id="drawerId" name="drawerId"  style="width: 100%">
                        <c:forEach var="emp" items="${staffingEmps}">
                            <option value="${emp.empId}">${emp.empName}
                            </option>
                        </c:forEach>
                    </select>

                    <%--<input id="drawerId" name="drawerId" class="form-control">--%>
                </div>
            </div>
            <div class="col-md-4">
                <label>开单日期:</label>
                <div class="form-group">
                    <input id="billTime" name="billTime" class="form-control" type="text">
                </div>
            </div>
            <div class="col-md-4">
                <label>单据备注:</label>
                <div class="form-group">
                    <input id="scoreBillDesc" name="scoreBillDesc" class="form-control">
                </div>
            </div>
        </div>
        <div id="scoreBillDetailToolbar">
            <a class="waves-effect waves-button" href="javascript:;" onclick="addRecordAction()"><i
                    class="zmdi zmdi-plus"></i>
                新增新纪录</a>
        </div>
        <div class="row">
            <div class="col-md-12">
                <table id="scoreBillDetailTable"></table>
            </div>
        </div>

        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>
    var adddRecordDialog;
    function addRecordAction(ids) {
        var rows = $scoreBillDetailTable.bootstrapTable('getData');

        adddRecordDialog = $.dialog({
            animationSpeed: 300,
            title: '添加新纪录',
            columnClass:'col-md-12',
            content: 'url:${basePath}/scorebill/addRecord',
            onContentReady: function () {
                initMaterialInput();
                $("#drawerId").select2({
                    placeholder: '请选择开单人'
                });
            }
        });

        console.log(rows);
    }
    
    
    var $scoreBillDetailTable = $('#scoreBillDetailTable');
    $(function () {
        // bootstrap table初始化
        $scoreBillDetailTable.bootstrapTable({
            height: 500,
            striped: true,
            minimumCountColumns: 2,
            clickToSelect: true,
            queryParams: 'queryParams',
            paginationLoop: false,
            sidePagination: 'server',
            silentSort: false,
            smartDisplay: false,
            escape: true,
            idField: 'empId',
            maintainSelected: true,
            toolbar: '#scoreBillDetailToolbar',
            columns: [
                {field: 'ck', checkbox: true},
                {field: 'scoreBillNo', title: '被开单人'},
                {field: 'drawerId', title: '分值'},
                {field: 'scoreBillDesc', title: '记录描述'},
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


    initDateInput($('#billTime'));
    function createSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/scorebill/create',
            data: $('#createForm').serialize(),
            dataType: 'json',
            beforeSend: function () {

            },
            success: function (data) {
                if (data.success) {
                    createDialog.close();
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