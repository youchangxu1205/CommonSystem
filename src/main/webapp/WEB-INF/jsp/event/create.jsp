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
        <input id="eventCategoryId" name="eventCategoryId" type="hidden"/>
        <div class="form-group">
            <label for="eventName">事件名称</label>
            <input id="eventName" type="text" class="form-control" name="eventName" maxlength="50">
        </div>
        <label for="isFixed">事件属性</label>
        <div class="form-group">
            <%--<input id="isFixed" type="text" class="form-control" name="isFixed" maxlength="20">--%>
            <select class="form-control" id="isFixed" name="isFixed">
                <option value="1">固定事件</option>
                <option value="2">随机事件</option>
            </select>

        </div>
        <div id="eventScoreDiv" class="form-group">
            <label for="eventScore">单人单月最高奖分</label>
            <input id="eventScore" type="text" class="form-control" name="eventScore" maxlength="200">
        </div>
        <div class="form-group">
            <label for="eventDesc">事件描述</label>
            <input id="eventDesc" type="text" class="form-control" name="eventDesc" maxlength="200">
        </div>
        <div class="form-group">
            <label for="minScore">最低分</label>
            <input id="minScore" type="text" class="form-control" name="minScore" maxlength="200">
        </div>
        <div class="form-group">
            <label for="maxScore">最高分</label>
            <input id="maxScore" type="text" class="form-control" name="maxScore" maxlength="200">
        </div>
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="createDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>
    $("#isFixed").trigger("change");
    $("#eventScoreDiv").show();
    $("#isFixed").change(function () {
        var value = $(this).children('option:selected').val();
        if (value == 1) {
            $("#eventScoreDiv").show();
        } else {
            $("#eventScoreDiv").hide();
        }

    })
    $("#eventCategoryId").val(eventCategoryId);
    function createSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/event/create',
            data: $('#createForm').serialize(),
            dataType: 'json',
            beforeSend: function () {
                var minScore = $("#minScore").val();
                var maxScore = $("#maxScore").val();
                if (minScore > maxScore) {
                    alert("最低分不能高于最高分");
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