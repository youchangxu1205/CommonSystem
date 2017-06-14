package top.youchangxu.model.system;

import com.baomidou.mybatisplus.annotations.TableName;

import java.util.Date;

/**
 * Created by dtkj_android on 2017/6/14.
 */
@TableName("staffing_post_emp")
public class StaffingPostEmp {
    private Long postId;
    private Long empId;
    private boolean status;
    private Date createTime;
    private Date updateTime;
    private Long enterpriseId;


    public Long getPostId() {
        return postId;
    }

    public void setPostId(Long postId) {
        this.postId = postId;
    }

    public Long getEmpId() {
        return empId;
    }

    public void setEmpId(Long empId) {
        this.empId = empId;
    }

    public boolean isStatus() {
        return status;
    }

    public void setStatus(boolean status) {
        this.status = status;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Long getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
    }
}
