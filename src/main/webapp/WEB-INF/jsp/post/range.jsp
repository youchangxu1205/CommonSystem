<%@ page contentType="text/html; charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring" %>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<style>
    .value-item{
        height: 30px;
        cursor: pointer;
        overflow: hidden;
    }
</style>
<div id="scoreRangeDialog" class="crudDialog">
    <form id="scoreRangeForm" method="post">
        <div class="row">
            <div class="col-md-5">
                <div class="row">
                    <div class="col-md-4">
                        <ul id="noChooseEmps">
                            <c:forEach items="${staffingEmps}" var="emp">
                                <li class="value-item">
                                        ${emp.empName}
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <ul id="noChoosePosts">
                            <c:forEach items="${staffingPosts}" var="post">
                                <li class="value-item">
                                        ${post.postName}
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                    <div class="col-md-4">
                        <ul id="noChooseOrgs">
                            <c:forEach items="${staffingOrgs}" var="org">
                                <li class="value-item">
                                        ${org.orgName}
                                </li>
                            </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-2">
            </div>
            <div class="col-md-5">
                <div id="choosedEmps">
                    选择的员工
                </div>
                <div id="choosedPosts">
                    选择的岗位
                </div>
                <div id="choosedOrgs">
                    选择的部门
                </div>
            </div>
        </div>
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="createSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="scoreRangeDialog.close();">取消</a>
        </div>
    </form>
</div>
<script src="${basePath}/resources/zheng-admin/js/range.js"></script>
<script>



    <%--var noChooseEmps = new Vue({--%>
    <%--el:'#noChooseEmps',--%>
    <%--data:{--%>
    <%--emps:${staffingEmps}--%>
    <%--}--%>
    <%--})--%>
    //初始化左边的数据
    //1.初始化员工列表
    //2.初始化岗位列表
    //3.初始化部门列表
    //初始化右边的数据
</script>