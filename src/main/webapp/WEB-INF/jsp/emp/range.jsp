<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="empRangeDialog" class="crudDialog">
    <form id="empRangeForm" method="post">

        <div class="row">
            <div class="col-md-5">
                <div class="form-group">
                    <%--<input id="pOrgId" type="text" class="form-control" name="pOrgId" maxlength="20">--%>
                    <select id="pOrgId" name="pOrgId"  style="width: 100%">
                        <c:forEach var="org" items="${orgs}">
                            <option value="${org.orgId}"
                                    <c:if test="${org.orgId==orgId}">selected="selected"</c:if>>${org.orgName}
                            </option>
                        </c:forEach>
                    </select>
                </div>
                <div style="min-height: 300px">

                </div>
            </div>
            <div class="col-md-2">
                <button style="margin-top: 100px">&gt;&gt;添加&gt;&gt;</button>
                <button style="margin-top: 50px">&lt;&lt;取消&lt;&lt;</button>
            </div>
            <div class="col-md-5">
                右
                <div style="min-height: 300px">

                </div>
            </div>
        </div>
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="roleSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="empRangeDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>
    function roleSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/emp/role/' + roleEmpId,
            data: $('#roleForm').serialize(),
            dataType:'json',
            beforeSend: function () {

            },
            success: function (data) {
                if (data.success) {
                    roleDialog.close();
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