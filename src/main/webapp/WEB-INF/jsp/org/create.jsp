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
        <label class="label label-danger" id="error"></label>
        <div class="form-group">
            <label for="orgName">部门名称</label>
            <input id="orgName" type="text" class="form-control" name="orgName" maxlength="20">
        </div>
        <label>上级部门</label>
        <div class="form-group">
            <%--<input id="pOrgId" type="text" class="form-control" name="pOrgId" maxlength="20">--%>
            <select id="pOrgId" name="pOrgId" style="width: 100%">
                <c:forEach var="org" items="${orgs}">
                    <option value="${org.orgId}"
                            <c:if test="${org.orgId==orgId}">selected="selected"</c:if>>${org.orgName}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="radio">
            <div class="radio radio-inline radio-info">
                <input id="orgType_1" type="radio" name="orgType" value="1" checked>
                <label for="orgType_1">公司</label>
            </div>
            <div class="radio radio-inline radio-danger">
                <input id="orgType_2" type="radio" name="orgType" value="2">
                <label for="orgType_2">部门</label>
            </div>
        </div>
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>
    function createSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/org/create',
            data: $('#createForm').serialize(),
            dataType: 'json',
            beforeSend: function () {
            },
            success: function (data) {
                if (data.success) {
                    createDialog.close();
                    $table.bootstrapTable('refresh');
                    refreshTree();
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