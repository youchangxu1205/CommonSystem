<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="empOrgDialog" class="crudDialog">
    <form id="empOrgForm" method="post">
        <div class="form-group">
            <select id="orgIds" name="orgIds" multiple="multiple" style="width: 100%">
                <c:forEach var="org" items="${staffingOrgs}">
                    <option value="${org.orgId}"
                            <c:forEach var="empOrg" items="${staffingOrgEmps}">
                                <c:if test="${empOrg.orgId==org.orgId}">selected="selected"</c:if>
                            </c:forEach>>${org.orgName}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="empOrgSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="empOrgDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>
    function empOrgSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/emp/org/' + orgEmpId,
            data: $('#empOrgForm').serialize(),
            dataType: 'json',
            beforeSend: function () {

            },
            success: function (data) {
                if (data.success) {
                    empOrgDialog.close();
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