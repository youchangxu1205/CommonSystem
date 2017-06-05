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
        <input type="hidden" id="permissionId" name="permissionId" value="${staffingPermission.permissionId}">
        <div class="form-group">
            <label for="permissionName">权限名称</label>
            <input id="permissionName" type="text" class="form-control" name="permissionName" maxlength="20" value="${staffingPermission.permissionName}">
        </div>
        <div class="form-group">
            <label for="permissionValue">权限值</label>
            <input id="permissionValue" type="text" class="form-control" name="permissionValue" maxlength="20" value="${staffingPermission.permissionValue}">
        </div>
        <div class="form-group">
            <label for="permissionIcon">权限图标</label>
            <input id="permissionIcon" type="text" class="form-control" name="permissionIcon" maxlength="20" value="${staffingPermission.permissionIcon}">
        </div>

        <div class="form-group">
            <label for="pPermissionId">上级权限</label>
            <input type="text" id="pPermissionId" name="pPermissionId" class="form-control" value="${staffingPermission.pPermissionId}">
        </div>
        <div class="form-group">
            <label for="permissionUri">权限地址</label>
            <input type="text" id="permissionUri" name="permissionUri" class="form-control" value="${staffingPermission.permissionUri}">
        </div>
        <div class="radio">
            <div class="radio radio-inline radio-info">
                <input id="type_1" type="radio" name="permissionType" value="1" <c:if test="${staffingPermission.permissionType==1}">checked</c:if>>
                <label for="type_1">目录 </label>
            </div>
            <div class="radio radio-inline radio-warning">
                <input id="type_2" type="radio" name="permissionType" value="2" <c:if test="${staffingPermission.permissionType==2}">checked</c:if>>
                <label for="type_2">菜单 </label>
            </div>
            <div class="radio radio-inline radio-danger">
                <input id="type_3" type="radio" name="permissionType" value="3" <c:if test="${staffingPermission.permissionType==3}">checked</c:if>>
                <label for="type_3">按钮 </label>
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
            url: '${basePath}/permission/update',
            data: $('#updateForm').serialize(),
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