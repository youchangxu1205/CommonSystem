package top.youchangxu.model.engineering;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import org.springframework.format.annotation.DateTimeFormat;

import java.util.Date;

/**
 * Created by xcy on 2017/9/5.
 */
@TableName("engineering_project")
public class EngineeringProject {
    @TableId
    private Long engineeringProjectId;
    private String engineeringProjectName;
    private String engineeringProjectAddr;
    private String engineeringProjectSteward;
    private String engineeringProjectSchedule;
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;


    public Long getEngineeringProjectId() {
        return engineeringProjectId;
    }

    public void setEngineeringProjectId(Long engineeringProjectId) {
        this.engineeringProjectId = engineeringProjectId;
    }

    public String getEngineeringProjectName() {
        return engineeringProjectName;
    }

    public void setEngineeringProjectName(String engineeringProjectName) {
        this.engineeringProjectName = engineeringProjectName;
    }

    public String getEngineeringProjectAddr() {
        return engineeringProjectAddr;
    }

    public void setEngineeringProjectAddr(String engineeringProjectAddr) {
        this.engineeringProjectAddr = engineeringProjectAddr;
    }

    public String getEngineeringProjectSteward() {
        return engineeringProjectSteward;
    }

    public void setEngineeringProjectSteward(String engineeringProjectSteward) {
        this.engineeringProjectSteward = engineeringProjectSteward;
    }

    public String getEngineeringProjectSchedule() {
        return engineeringProjectSchedule;
    }

    public void setEngineeringProjectSchedule(String engineeringProjectSchedule) {
        this.engineeringProjectSchedule = engineeringProjectSchedule;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }
}
