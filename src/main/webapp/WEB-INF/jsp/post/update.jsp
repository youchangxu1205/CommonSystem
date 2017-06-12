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
        <input id="postId" type="hidden" name="postId" value="${staffingPost.postId}">
        <div class="form-group">
            <label for="postName">岗位名称</label>
            <input id="postName" type="text" class="form-control" name="postName" maxlength="50" value="${staffingPost.postName}">
        </div>
        <div class="form-group">
            所属部门
            <select id="orgId" name="orgId" style="width: 100%">
                <c:forEach var="org" items="${staffingOrgs}">
                    <option value="${org.orgId}"
                                <c:if test="${staffingPost.orgId==org.orgId}">selected="selected"</c:if>>${org.orgName}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="radio">
            <div class="radio radio-inline radio-info">
                <input id="type_1" type="radio" name="permissionType" value="1" <c:if test="${staffingPost.manager==true}">checked</c:if>>
                <label for="type_1">管理岗 </label>
            </div>
            <div class="radio radio-inline radio-warning">
                <input id="type_0" type="radio" name="permissionType" value="0" <c:if test="${staffingPost.manager==false}">checked</c:if>>
                <label for="type_0">非管理岗 </label>
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
            url: '${basePath}/post/update',
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
            success: function (result) {
                if (result.success) {
                    updateDialog.close();
                    $table.bootstrapTable('refresh');
                } else {
                    $.confirm({
                        theme: 'dark',
                        animation: 'rotateX',
                        closeAnimation: 'rotateX',
                        title: false,
                        content: result.msg,
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