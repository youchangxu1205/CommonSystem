package top.youchangxu.model.multiplescore;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

import java.util.Date;

/**
 * Created by dtkj_android on 2017/6/9.
 */
@TableName("multiplescore_eventcategory")
public class MultiplescoreEventCategory {
    @TableId
    private Long eventCategoryId;
    private String eventCategoryName;
    private Date createTime;
    private Date updateTime;
    private String eventCategoryDesc;
    private Long  enterpriseId;

    public Long getEventCategoryId() {
        return eventCategoryId;
    }

    public void setEventCategoryId(Long eventCategoryId) {
        this.eventCategoryId = eventCategoryId;
    }

    public String getEventCategoryName() {
        return eventCategoryName;
    }

    public void setEventCategoryName(String eventCategoryName) {
        this.eventCategoryName = eventCategoryName;
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

    public String getEventCategoryDesc() {
        return eventCategoryDesc;
    }

    public void setEventCategoryDesc(String eventCategoryDesc) {
        this.eventCategoryDesc = eventCategoryDesc;
    }

    public Long getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
    }
}
