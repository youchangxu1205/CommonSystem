<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="updateDialog" class="crudDialog">
    <form id="updateForm" method="post">
        <label class="label label-danger" id="error"></label>
        <input id="enterpriseId" type="hidden" name="enterpriseId" value="${staffingEnterprise.enterpriseId}">
        <div class="form-group">
            <label for="enterpriseName">企业名称</label>
            <input id="enterpriseName" type="text" class="form-control" name="enterpriseName" value="${staffingEnterprise.enterpriseName}"
                   maxlength="20">
        </div>
        <div class="form-group">
            <label for="enterpriseCode">企业编码</label>
            <input id="enterpriseCode" type="text" class="form-control" name="enterpriseCode" value="${staffingEnterprise.enterpriseCode}"
                   maxlength="20">
        </div>
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="updateSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="updateDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>


    function updateSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/enterprise/update',
            data: $('#updateForm').serialize(),
            dataType: 'json',
            beforeSend: function () {
                if ($('#enterpriseName').val() == '') {
                    $('#enterpriseName').focus();
                    $('#error').val("企业名称不能为空");
                    return false;
                }
                if ($('#enterpriseCode').val() == '') {
                    $('#enterpriseCode').focus();
                    $('#error').val("企业编码不能为空");
                    return false;
                }
            },
            success: function (data) {
                if (data.success) {
                    updateDialog.close();
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