<%@ page contentType="text/html; charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jstl/core_rt" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<%@ taglib uri="http://www.springframework.org/tags/form" prefix="form"%>
<%@taglib prefix="shiro" uri="http://shiro.apache.org/tags" %>
<c:set var="basePath" value="${pageContext.request.contextPath}"/>
<div id="permissionDialog" class="crudDialog">
    <form id="permissionForm" method="post">
        <div class="form-group">
            <ul id="ztree" class="ztree"></ul>
        </div>
        <div class="form-group text-right dialog-buttons">
            <a class="waves-effect waves-button" href="javascript:;" onclick="permissionSubmit();">保存</a>
            <a class="waves-effect waves-button" href="javascript:;" onclick="permissionDialog.close();">取消</a>
        </div>
    </form>
</div>
<script>
    var changeDatas = [];
    var setting = {
        check: {
            enable: true,
            // 勾选关联父，取消关联子
            chkboxType: { "Y" : "p", "N" : "s" }
        },
        async: {
            enable: true,
            url: '${basePath}/permission/role/' + roleId
        },
        data: {
            simpleData: {
                enable: true
            }
        },
        callback: {
            onCheck: function() {
                var zTree = $.fn.zTree.getZTreeObj("ztree")
                var changeNodes = zTree.getChangeCheckedNodes();
                changeDatas = [];
                for (var i = 0; i < changeNodes.length; i ++) {
                    var changeData = {};
                    changeData.id = changeNodes[i].id;
                    changeData.checked = changeNodes[i].checked;
                    changeDatas.push(changeData);
                }
            }
        }
    };
    function initTree() {
        $.fn.zTree.init($('#ztree'), setting);
    }

    function permissionSubmit() {
        $.ajax({
            type: 'post',
            url: '${basePath}/role/permission/' + roleId,
            data: {datas: JSON.stringify(changeDatas), roleId: roleId},
            dataType:'json',
            success: function(data) {
                if (data.success) {
                    permissionDialog.close();
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
            error: function(XMLHttpRequest, textStatus, errorThrown) {
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