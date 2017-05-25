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
        <input id="orgId" name="orgId" type="hidden" value="${staffingOrg.orgId}">
        <div class="form-group">
            <label for="orgName">部门名称</label>
            <input id="orgName" type="text" class="form-control" name="orgName" value="${staffingOrg.orgName}">
        </div>
        <div class="form-group">
            <label for="pOrgId">上级部门</label>
            <input id="pOrgId" type="text" class="form-control" name="pOrgId" value="${staffingOrg.pOrgId}">
        </div>
        <div class="radio">
            <div class="radio radio-inline radio-info">
                <input id="orgType_1" type="radio" name="orgType" value="1" <c:if test="${staffingOrg.orgType==1}">checked</c:if>>
                <label for="orgType_1">公司</label>
            </div>
            <div class="radio radio-inline radio-danger">
                <input id="orgType_2" type="radio" name="orgType" value="2" <c:if test="${staffingOrg.orgType==2}">checked</c:if>>
                <label for="orgType_2">部门</label>
            </div>
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
            url: '${basePath}/org/update',
            data: $('#updateForm').serialize(),
            dataType: 'json',
            beforeSend: function () {
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