package top.youchangxu.model.system;

import com.baomidou.mybatisplus.annotations.TableName;

/**
 * Created by dtkj_android on 2017/6/1.
 */
@TableName("staffing_org_emp")
public class StaffingOrgEmp {

    private Long orgId;
    private Long empId;

    public StaffingOrgEmp(Long orgId, Long empId) {
        this.orgId = orgId;
        this.empId = empId;
    }

    public Long getOrgId() {
        return orgId;
    }

    public void setOrgId(Long orgId) {
        this.orgId = orgId;
    }

    public Long getEmpId() {
        return empId;
    }

    public void setEmpId(Long empId) {
        this.empId = empId;
    }
}
