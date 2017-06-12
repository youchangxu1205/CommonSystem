package top.youchangxu.model.system;

import com.baomidou.mybatisplus.annotations.TableName;

/**
 * Created by dtkj_android on 2017/6/12.
 */
@TableName("multiplescore_range")
public class MultiplescoreRange {
    private Long postHigherId;
    private Long postLowerId;
    private Long empLowerId;
    private Long enterpriseId;

    public Long getPostHigherId() {
        return postHigherId;
    }

    public void setPostHigherId(Long postHigherId) {
        this.postHigherId = postHigherId;
    }

    public Long getPostLowerId() {
        return postLowerId;
    }

    public void setPostLowerId(Long postLowerId) {
        this.postLowerId = postLowerId;
    }

    public Long getEmpLowerId() {
        return empLowerId;
    }

    public void setEmpLowerId(Long empLowerId) {
        this.empLowerId = empLowerId;
    }

    public Long getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
    }
}
