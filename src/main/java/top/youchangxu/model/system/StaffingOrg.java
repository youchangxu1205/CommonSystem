package top.youchangxu.model.system;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by xcy on 2017/5/7.
 */
@TableName("staffing_org")
public class StaffingOrg implements Serializable {

    private static final long serialVersionUID = 1L;

    @TableId
    private Long orgId;
    private String orgName;
    private Long pOrgId;
    @DateTimeFormat(pattern="yyyy-MM-dd HH:mm:ss")
    private Date createTime;
    private Integer orgType;
    private Long enterpriseId;

    public StaffingOrg() {
    }

    public StaffingOrg(long orgId, String orgName, long pOrgId) {
        this.orgId = orgId;
        this.orgName = orgName;
        this.pOrgId = pOrgId;
    }

    public StaffingOrg(long orgId, String orgName, long pOrgId, Date createTime, int orgType,long enterpriseId) {
        this.orgId = orgId;
        this.orgName = orgName;
        this.pOrgId = pOrgId;
        this.createTime = createTime;
        this.orgType = orgType;
        this.enterpriseId = enterpriseId;
    }

    public Long getOrgId() {
        return orgId;
    }

    public void setOrgId(Long orgId) {
        this.orgId = orgId;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public long getpOrgId() {
        return pOrgId;
    }

    public void setpOrgId(Long pOrgId) {
        this.pOrgId = pOrgId;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Integer getOrgType() {
        return orgType;
    }

    public void setOrgType(Integer orgType) {
        this.orgType = orgType;
    }

    public Long getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
    }

    @Override
    public String toString() {
        return "StaffingOrg{" +
                "orgId=" + orgId +
                ", orgName='" + orgName + '\'' +
                ", pOrgId=" + pOrgId +
                ", createTime=" + createTime +
                ", orgType=" + orgType +
                ", enterpriseId=" + enterpriseId +
                '}';
    }
}
