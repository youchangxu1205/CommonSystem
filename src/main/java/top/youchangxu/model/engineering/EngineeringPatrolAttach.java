package top.youchangxu.model.engineering;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;

/**
 * Created by xcy on 2017/9/5.
 */
@TableName("engineering_patrol_attach")
public class EngineeringPatrolAttach {
    @TableId
    private Long engineeringPatrolAttachId;
    private Long engineeringPatrolId;
    private String engineeringPatrolAttachName;
    private String engineeringPatrolAttachPath;
    private String engineeringPatrolAttachType;


    public Long getEngineeringPatrolAttachId() {
        return engineeringPatrolAttachId;
    }

    public void setEngineeringPatrolAttachId(Long engineeringPatrolAttachId) {
        this.engineeringPatrolAttachId = engineeringPatrolAttachId;
    }

    public Long getEngineeringPatrolId() {
        return engineeringPatrolId;
    }

    public void setEngineeringPatrolId(Long engineeringPatrolId) {
        this.engineeringPatrolId = engineeringPatrolId;
    }

    public String getEngineeringPatrolAttachName() {
        return engineeringPatrolAttachName;
    }

    public void setEngineeringPatrolAttachName(String engineeringPatrolAttachName) {
        this.engineeringPatrolAttachName = engineeringPatrolAttachName;
    }

    public String getEngineeringPatrolAttachPath() {
        return engineeringPatrolAttachPath;
    }

    public void setEngineeringPatrolAttachPath(String engineeringPatrolAttachPath) {
        this.engineeringPatrolAttachPath = engineeringPatrolAttachPath;
    }

    public String getEngineeringPatrolAttachType() {
        return engineeringPatrolAttachType;
    }

    public void setEngineeringPatrolAttachType(String engineeringPatrolAttachType) {
        this.engineeringPatrolAttachType = engineeringPatrolAttachType;
    }
}
