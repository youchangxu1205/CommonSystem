package top.youchangxu.model.system;

import com.baomidou.mybatisplus.annotations.TableName;

/**
 * Created by dtkj_android on 2017/6/6.
 * 上下级范围表
 */
@TableName("multiplescore_emp_range")
public class MultiplescoreEmpRange {
    private Long higherId;
    private Long lowerId;
    private Long enterpriseId;

    public Long getHigherId() {
        return higherId;
    }

    public void setHigherId(Long higherId) {
        this.higherId = higherId;
    }

    public Long getLowerId() {
        return lowerId;
    }

    public void setLowerId(Long lowerId) {
        this.lowerId = lowerId;
    }

    public Long getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
    }
}
