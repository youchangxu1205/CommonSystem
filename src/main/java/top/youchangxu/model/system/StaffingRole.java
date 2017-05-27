package top.youchangxu.model.system;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

/**
 * Created by dtkj_android on 2017/5/27.
 */
@TableName("staffing_role")
public class StaffingRole {
    @TableId
    private Long roleId;
    private String roleName;
    private Long enterpriseId;

    public Long getRoleId() {
        return roleId;
    }

    public void setRoleId(Long roleId) {
        this.roleId = roleId;
    }

    public String getRoleName() {
        return roleName;
    }

    public void setRoleName(String roleName) {
        this.roleName = roleName;
    }

    public Long getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
    }


    @Override
    public String toString() {
        return "StaffingRole{" +
                "roleId=" + roleId +
                ", roleName='" + roleName + '\'' +
                ", enterpriseId=" + enterpriseId +
                '}';
    }
}
