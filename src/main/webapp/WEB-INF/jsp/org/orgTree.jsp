<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<jsp:include page="/resources/inc/head.jsp" flush="true"/>
<ul id="orgTree" class="ztree"></ul>
<jsp:include page="/resources/inc/footer.jsp" flush="true"/>
<script>
    var zTreeObj;
    // zTree 的参数配置，深入使用请参考 API 文档（setting 配置详解）
    var setting = {
        async: {
            enable: true,
            type: "get",
            url: "${basePath}/org/orgTree/1"
        },
        view:{
            showIcon:false
        }
    };

    // zTree 的数据属性，深入使用请参考 API 文档（zTreeNode 节点数据详解）

    $(document).ready(function () {
        zTreeObj = $.fn.zTree.init($("#orgTree"), setting);
    });

</script>
