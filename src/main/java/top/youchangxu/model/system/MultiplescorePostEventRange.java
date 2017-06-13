package top.youchangxu.model.system;

import com.baomidou.mybatisplus.annotations.TableName;

/**
 * Created by dtkj_android on 2017/6/13.
 */
@TableName("multiplescore_post_event_range")
public class MultiplescorePostEventRange {

    private Long postHigherId;
    private Long scoreEventId;
    private Long enterpriseId;

    public Long getPostHigherId() {
        return postHigherId;
    }

    public void setPostHigherId(Long postHigherId) {
        this.postHigherId = postHigherId;
    }

    public Long getScoreEventId() {
        return scoreEventId;
    }

    public void setScoreEventId(Long scoreEventId) {
        this.scoreEventId = scoreEventId;
    }

    public Long getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
    }
}
