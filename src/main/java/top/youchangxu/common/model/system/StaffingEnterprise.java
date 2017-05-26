package top.youchangxu.common.model.system;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

/**
 * Created by dtkj_android on 2017/5/26.
 * 企业表
 */
@TableName("staffing_enterprise")
public class StaffingEnterprise  {
    @TableId
    private Long enterpriseId;
    private String enterpriseName;
    private String enterpriseCode;

    public Long getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
    }

    public String getEnterpriseName() {
        return enterpriseName;
    }

    public void setEnterpriseName(String enterpriseName) {
        this.enterpriseName = enterpriseName;
    }

    public String getEnterpriseCode() {
        return enterpriseCode;
    }

    public void setEnterpriseCode(String enterpriseCode) {
        this.enterpriseCode = enterpriseCode;
    }

    @Override
    public String toString() {
        return "StaffingEnterprise{" +
                "enterpriseId=" + enterpriseId +
                ", enterpriseName='" + enterpriseName + '\'' +
                ", enterpriseCode='" + enterpriseCode + '\'' +
                '}';
    }
}
