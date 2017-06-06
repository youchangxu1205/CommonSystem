package top.youchangxu.model.system;

import com.baomidou.mybatisplus.annotations.TableName;

/**
 * Created by dtkj_android on 2017/5/31.
 */
@TableName("staffing_enterprise_emp")
public class StaffingEnterpriseEmp {
    private Long enterpriseId;
    private Long empId;
    private int status;
    private String password;
    private String salt;
    private String enterpriseEmpName;

    public StaffingEnterpriseEmp(Long enterpriseId, Long empId) {
        this.enterpriseId = enterpriseId;
        this.empId = empId;
    }

    public StaffingEnterpriseEmp(Long enterpriseId, Long empId, int status, String password, String salt, String enterpriseEmpName) {
        this.enterpriseId = enterpriseId;
        this.empId = empId;
        this.status = status;
        this.password = password;
        this.salt = salt;
        this.enterpriseEmpName = enterpriseEmpName;
    }

    public Long getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
    }

    public Long getEmpId() {
        return empId;
    }

    public void setEmpId(Long empId) {
        this.empId = empId;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }

    public String getEnterpriseEmpName() {
        return enterpriseEmpName;
    }

    public void setEnterpriseEmpName(String enterpriseEmpName) {
        this.enterpriseEmpName = enterpriseEmpName;
    }
}
