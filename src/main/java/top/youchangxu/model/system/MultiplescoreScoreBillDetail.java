package top.youchangxu.model.system;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.util.Date;

/**
 * Created by dtkj_android on 2017/6/14.
 */
@TableName("multiplescore_scorebill_detail")
public class MultiplescoreScoreBillDetail {
    @TableId
    private Long scoreBillDetailId;
    private Long drawerId;
    private Long draweeId;
    private Float scoreBillScore;
    private String scoreBillDetailDesc;
    private boolean isEnable;
    private Long enterpriseId;
    private Date createTime;
    private Date updateTime;

    public Long getScoreBillDetailId() {
        return scoreBillDetailId;
    }

    public void setScoreBillDetailId(Long scoreBillDetailId) {
        this.scoreBillDetailId = scoreBillDetailId;
    }

    public Long getDrawerId() {
        return drawerId;
    }

    public void setDrawerId(Long drawerId) {
        this.drawerId = drawerId;
    }

    public Long getDraweeId() {
        return draweeId;
    }

    public void setDraweeId(Long draweeId) {
        this.draweeId = draweeId;
    }

    public Float getScoreBillScore() {
        return scoreBillScore;
    }

    public void setScoreBillScore(Float scoreBillScore) {
        this.scoreBillScore = scoreBillScore;
    }

    public String getScoreBillDetailDesc() {
        return scoreBillDetailDesc;
    }

    public void setScoreBillDetailDesc(String scoreBillDetailDesc) {
        this.scoreBillDetailDesc = scoreBillDetailDesc;
    }

    public boolean isEnable() {
        return isEnable;
    }

    public void setEnable(boolean enable) {
        isEnable = enable;
    }

    public Long getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
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
}
