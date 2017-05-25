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
        <div class="form-group">
            <label for="userName">账户名</label>
            <input id="userName" type="text" class="form-control" name="userName" maxlength="20">
        </div>
        <div class="form-group">
            <label for="empName">姓名</label>
            <input id="empName" type="text" class="form-control" name="empName" maxlength="20">
        </div>
        <div class="form-group">
            <label for="empPhone">电话</label>
            <input id="empPhone" type="text" class="form-control" name="empPhone" maxlength="20">
        </div>

        <div class="form-group">
            <label for="entryTime">入职时间</label>
            <input type="text" id="entryTime" name="entryTime" class="form-control">
        </div>
        <div class="form-group">
            <label for="beFormalTime">转正时间</label>
            <input type="text" id="beFormalTime" name="beFormalTime" class="form-control">
        </div>
        <div class="form-group">员工状态:
            <select id="empStatus" name="empStatus" class="form-control">
                <option value="1">在职</option>
                <option value="2">试岗中</option>
                <option value="3">休长假</option>
                <option value="-1">离职</option>
                <option value="-2">试岗离开</option>
            </select>
        </div>
        <div class="radio">
            <div class="radio radio-inline radio-info">
                <input id="sex_1" type="radio" name="sex" value="1" checked>
                <label for="sex_1">男 </label>
            </div>
            <div class="radio radio-inline radio-danger">
                <input id="sex_0" type="radio" name="sex" value="0">
                <label for="sex_0">女 </label>
            </div>
        </div>
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>
    initDateInput($('#entryTime'));
    initDateInput($('#beFormalTime'));
    function createSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/emp/create',
            data: $('#createForm').serialize(),
            dataType: 'json',
            beforeSend: function () {
                if ($('#userName').val() == '') {
                    $('#userName').focus();
                    $('#error').val("用户名不能为空");
                    return false;
                }
                if ($('#empName').val() == '') {
                    $('#empName').focus();
                    $('#error').val("员工名不能为空");
                    return false;
                }
                if ($('#entryTime').val() == '') {
                    $('#entryTime').focus();
                    $('#error').val("入职时间不能为空");
                    return false;
                }
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