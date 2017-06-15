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

                    <select id="drawerId" name="drawerId" style="width: 100%">
                        <option value="0">--选择开单人--
                        </option>
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

            <a class="waves-effect waves-button" href="javascript:;" onclick="deleteRecordAction()"><i
                    class="zmdi zmdi-plus"></i>
                删除新纪录</a>
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
    var addRecordDialog;
    var recordRows = new Array();
    function addRecordAction(ids) {

        if (drawerId == 0) {
            alert("选择开单人");
            return;
        }

        var rows = $scoreBillDetailTable.bootstrapTable('getData');

        addRecordDialog = $.dialog({
            animationSpeed: 300,
            title: '添加新纪录',
            columnClass: 'col-md-12',
            content: 'url:${basePath}/scorebill/addRecord',
            onContentReady: function () {
                initMaterialInput();
                $("#drawerId").select2({
                    placeholder: '请选择开单人'
                });
            }
        });
    }


    function deleteRecordAction() {
        var ids = getIdSelections();
        $scoreBillDetailTable.bootstrapTable('remove', {
            field: 'id',
            values: ids
        });
    }


    function getIdSelections() {
        return $.map($scoreBillDetailTable.bootstrapTable('getSelections'), function (row) {
            return row.id;
        });
    }


    var drawerId = 0;
    //    $("#drawerId").trigger("change");
    $("#drawerId").click(function () {
        alert("点击了");
    });
    //    var isInited = false;
    $("#drawerId").change(function () {
        drawerId = $(this).children('option:selected').val();
        $scoreBillDetailTable.bootstrapTable('removeAll');

    });

    var $scoreBillDetailTable = $('#scoreBillDetailTable');
    $(function () {
        // bootstrap table初始化
        $scoreBillDetailTable.bootstrapTable({
            height: 500,
            striped: true,
            minimumCountColumns: 2,
            clickToSelect: true,
            escape: true,
            idField: 'id',
            maintainSelected: true,
            toolbar: '#scoreBillDetailToolbar',
            columns: [
                {field: 'ck', checkbox: true},
                {field: 'id', visible: false},
                {field: 'index', title: '行号', formatter: 'indexFormatter'},
                {field: 'draweeName', title: '被开单人'},
                {field: 'drawerId', visible: false},
                {field: 'eventName', title: '事件名称'},
                {field: 'eventId', visible: false},
                {field: 'minScore', title: '最低值'},
                {field: 'maxScore', title: '最高值'},
                {
                    field: 'scoreBillDetailScore', title: '分值', editable: {
                    type: 'text',
                    defaultValue: 0,
                    validate: function (value) {
                        value = $.trim(value);
                        if (!value) {
                            return '值是必须的';
                        }
                        if (!!isNaN(value)) {
                            return '只能是数字';
                        }

                        if (value == 0 || value == '0') {
                            return '不允许为0';
                        }
                        var data = $scoreBillDetailTable.bootstrapTable('getData'),
                            index = $(this).parents('tr').data('index');
                        var row = data[index];
                        var maxScore = row.maxScore;
                        var minScore = row.minScore;
                        if (value > maxScore || value < minScore) {
                            return "超出取值范围";
                        }

                        var dot = value.indexOf(".");
                        if (dot != -1) {
                            var dotCnt = value.substring(dot + 1, value.length);
                            if (dotCnt.length > 2) {
                                return "小数位最多2位!";
                            }
                        }

                        $(this).text(value);
                    },
                    title: '分值'
                }
                },
                {
                    field: 'scoreBillDetailDesc', title: '记录描述', editable: {
                    type: 'text',
                    defaultValue: null,
                    title: '备注'
                }
                }
            ]
        });
    });


    function indexFormatter(value, row, index) {
        return index + 1;
    }

    initDateInput($('#billTime'));
    function createSubmit() {

        if (drawerId == 0) {
            alert("选择开单人");
            return;
        }


        var rows = $scoreBillDetailTable.bootstrapTable('getData');
        if (rows.length == 0) {
            alert("请添加单据记录");
            return;
        }
        $.each(rows, function (i, item) {
            //检查各个
            if (item.scoreBillDetailScore == 0) {
                alert("第" + (i + 1) + "行的分值不能为0！");
                return;
            }
        });

        $.ajax({
            type: "POST",
            url: "${basePath}/scorebill/create",
            data: {
                'bills': JSON.stringify(rows),
                'drawerID': drawerId,
                'billTime': $('#billTime').val(),
                'scoreBillDesc': $('#scoreBillDesc').val()
            },
            dataType: "json",
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