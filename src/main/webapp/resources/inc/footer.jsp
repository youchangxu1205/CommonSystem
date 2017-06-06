<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<script>var BASE_PATH = '${basePath}';</script>
<script src="${basePath}/resources/zheng-admin/plugins/jquery.1.12.4.min.js"></script>
<script src="${basePath}/resources/zheng-admin/plugins/bootstrap-3.3.0/js/bootstrap.min.js"></script>
<script src="${basePath}/resources/zheng-admin/plugins/bootstrap-table-1.11.0/bootstrap-table.min.js"></script>
<script src="${basePath}/resources/zheng-admin/plugins/bootstrap-table-1.11.0/bootstrap-table-export.min.js"></script>
<script src="${basePath}/resources/zheng-admin/plugins/bootstrap-table-1.11.0/tableExport.min.js"></script>
<script src="${basePath}/resources/zheng-admin/plugins/bootstrap-table-1.11.0/locale/bootstrap-table-zh-CN.min.js"></script>
<script src="${basePath}/resources/zheng-admin/plugins/waves-0.7.5/waves.min.js"></script>
<script src="${basePath}/resources/zheng-admin/plugins/jquery-confirm/jquery-confirm.min.js"></script>
<script src="${basePath}/resources/zheng-admin/plugins/select2/js/select2.min.js"></script>
<script src="${basePath}/resources/zheng-admin/plugins/zTree_v3/js/jquery.ztree.all.min.js"></script>
<script src="${basePath}/resources/zheng-admin/js/common.js"></script>
<script src="${basePath}/resources/zheng-admin/plugins/bootstrap-table-1.11.0/filter-control/bootstrap-table-filter-control.js"></script>
<script src="${basePath}/resources/zheng-admin/plugins/bootstrap-datetimepicker-master/js/bootstrap-datetimepicker.min.js"></script>
<script src="${basePath}/resources/zheng-admin/plugins/bootstrap-datetimepicker-master/js/locales/bootstrap-datetimepicker.zh-CN.js" charset="UTF-8"></script>
<script src="${basePath}/resources/zheng-admin/plugins/bootstrap-treeview-1.2.0/bootstrap-treeview.min.js" charset="UTF-8"></script>