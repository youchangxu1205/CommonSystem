package top.youchangxu.model.system;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.util.Date;

/**
 * Created by dtkj_android on 2017/6/14.
 */
@TableName("multiplescore_scorebill")
public class MultiplescoreScoreBill {
    @TableId
    private Long scoreBillId;
    private String scoreBillNo;
    private Long drawerId;
    private String scoreBillDesc;
    private int scoreBillStatus;
    private Long enterpriseId;
    private boolean isEnable;
    private Date createTime;
    private Date updateTime;

    public Long getScoreBillId() {
        return scoreBillId;
    }

    public void setScoreBillId(Long scoreBillId) {
        this.scoreBillId = scoreBillId;
    }

    public String getScoreBillNo() {
        return scoreBillNo;
    }

    public void setScoreBillNo(String scoreBillNo) {
        this.scoreBillNo = scoreBillNo;
    }

    public Long getDrawerId() {
        return drawerId;
    }

    public void setDrawerId(Long drawerId) {
        this.drawerId = drawerId;
    }

    public String getScoreBillDesc() {
        return scoreBillDesc;
    }

    public void setScoreBillDesc(String scoreBillDesc) {
        this.scoreBillDesc = scoreBillDesc;
    }

    public int getScoreBillStatus() {
        return scoreBillStatus;
    }

    public void setScoreBillStatus(int scoreBillStatus) {
        this.scoreBillStatus = scoreBillStatus;
    }

    public Long getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
    }

    public boolean isEnable() {
        return isEnable;
    }

    public void setEnable(boolean enable) {
        isEnable = enable;
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
