<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="createCategoryDialog" class="crudDialog">
    <form id="createCategoryForm" method="post">
        <div class="form-group">
            <label for="eventCategoryName">分类名称</label>
            <input id="eventCategoryName" type="text" class="form-control" name="eventCategoryName" maxlength="50">
        </div>
        <div class="form-group">
            <label for="eventCategoryDesc">分类描述</label>
            <input id="eventCategoryDesc" type="text" class="form-control" name="eventCategoryDesc">
        </div>
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="createCategorySubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="createCategoryDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>
    function createCategorySubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/event/createCategory',
            data: $('#createCategoryForm').serialize(),
            dataType: 'json',
            beforeSend: function () {

            },
            success: function (data) {
                if (data.success) {
                    createCategoryDialog.close();
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