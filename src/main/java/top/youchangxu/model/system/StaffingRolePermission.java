package top.youchangxu.model.system;

import com.baomidou.mybatisplus.annotations.TableName;

/**
 * Created by dtkj_android on 2017/6/1.
 */
@TableName("staffing_role_permission")
public class StaffingRolePermission {
    private Long roleId;
    private Long permissionId;



    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public Long getPermissionId() {
        return permissionId;
    }

    public void setPermissionId(Long permissionId) {
        this.permissionId = permissionId;
    }
}
