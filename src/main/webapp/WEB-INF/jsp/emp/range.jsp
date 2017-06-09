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
        <div class="form-group">
            奖扣分员工
            <select id="empIds" name="empIds" multiple="multiple" style="width: 100%">
                <c:forEach var="emp" items="${staffingEmps}">
                    <option value="${emp.empId}"
                            <c:forEach var="rangeEmp" items="${staffingRangeEmps}">
                                <c:if test="${emp.empId==rangeEmp.lowerId}">selected="selected"</c:if>
                            </c:forEach>>${emp.empName}
                    </option>
                </c:forEach>
            </select>
            奖扣分事件

            <select id="eventIds" name="eventIds" multiple="multiple" style="width: 100%">
                <c:forEach var="event" items="${multiplescoreEvents}">
                    <option value="${event.eventId}"
                            <c:forEach var="eventRange" items="${multiplescoreEventRanges}">
                                <c:if test="${event.eventId==eventRange.eventId}">selected="selected"</c:if>
                            </c:forEach>>${event.eventName}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="empRangeSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="empRangeDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>
    function empRangeSubmit() {
        console.log($('#empRangeForm').serialize());

        $.ajax({
            type: 'post',
            url: '${basePath}/emp/range/' + empRangeEmpId,
            data: $('#empRangeForm').serialize(),
            dataType: 'json',
            beforeSend: function () {

            },
            success: function (data) {
                if (data.success) {
                    empRangeDialog.close();
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