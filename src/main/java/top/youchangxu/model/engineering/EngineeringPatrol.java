package top.youchangxu.model.engineering;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * Created by xcy on 2017/9/5.
 */
@TableName("engineering_patrol")
public class EngineeringPatrol {
    @TableId
    private Long engineeringPatrolId;
    private Long engineeringProjectId;
    private Long engineeringPatrolManId;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date engineeringPatrolDate;


    public Long getEngineeringPatrolId() {
        return engineeringPatrolId;
    }

    public void setEngineeringPatrolId(Long engineeringPatrolId) {
        this.engineeringPatrolId = engineeringPatrolId;
    }

    public Long getEngineeringProjectId() {
        return engineeringProjectId;
    }

    public void setEngineeringProjectId(Long engineeringProjectId) {
        this.engineeringProjectId = engineeringProjectId;
    }

    public Long getEngineeringPatrolManId() {
        return engineeringPatrolManId;
    }

    public void setEngineeringPatrolManId(Long engineeringPatrolManId) {
        this.engineeringPatrolManId = engineeringPatrolManId;
    }

    public Date getEngineeringPatrolDate() {
        return engineeringPatrolDate;
    }

    public void setEngineeringPatrolDate(Date engineeringPatrolDate) {
        this.engineeringPatrolDate = engineeringPatrolDate;
    }
}
