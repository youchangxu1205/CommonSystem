package top.youchangxu.model.system;

import com.baomidou.mybatisplus.annotations.TableName;

/**
 * Created by dtkj_android on 2017/6/12.
 */
@TableName("multiplescore_post_range")
public class MultiplescorePostRange {
    private Long postHigherId;
    private Long postLowerId;
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

    public Long getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
    }
}
