<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="empPostDialog" class="crudDialog">
    <form id="empPostForm" method="post">
        <div class="form-group">
            <select id="postIds" name="postIds" multiple="multiple" style="width: 100%">
                <c:forEach var="post" items="${staffingPosts}">
                    <option value="${post.postId}"
                            <c:forEach var="empPost" items="${staffingPostEmps}">
                                <c:if test="${empPost.postId==post.postId}">selected="selected"</c:if>
                            </c:forEach>>${post.postName}--${post.orgName}
                    </option>
                </c:forEach>
            </select>
        </div>
        <div class="alert alert-danger">更改岗位会将员工调动至岗位的所属部门</div>
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="empPostSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="empPostDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>
    function empPostSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/emp/post/' + postEmpId,
            data: $('#empPostForm').serialize(),
            dataType: 'json',
            beforeSend: function () {

            },
            success: function (data) {
                if (data.success) {
                    empPostDialog.close();
                    setNoSetPostEmpsCount();
                    $table.bootstrapTable('refresh');
                    $noSetPostEmpTable.bootstrapTable('refresh');
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