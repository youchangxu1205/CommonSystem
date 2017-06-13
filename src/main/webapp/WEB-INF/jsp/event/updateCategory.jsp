<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="updateCategoryDialog" class="crudDialog">
    <form id="updateCategoryForm" method="post">
        <input id="eventCategoryId" type="hidden" name="eventCategoryId" value="${multiplescoreEventCategory.eventCategoryId}"/>
        <div class="form-group">
            <label for="eventCategoryName">分类名称</label>
            <input id="eventCategoryName" type="text" class="form-control" name="eventCategoryName" maxlength="50" value="${multiplescoreEventCategory.eventCategoryName}">
        </div>
        <div class="form-group">
            <label for="eventCategoryDesc">分类描述</label>
            <input id="eventCategoryDesc" type="text" class="form-control" name="eventCategoryDesc" value="${multiplescoreEventCategory.eventCategoryDesc}" >
        </div>
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="updateCategorySubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="updateCategoryDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>
    function updateCategorySubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/event/updateCategory',
            data: $('#updateCategoryForm').serialize(),
            dataType: 'json',
            beforeSend: function () {

            },
            success: function (data) {
                if (data.success) {
                    updateCategoryDialog.close();
                    treeRefresh();
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