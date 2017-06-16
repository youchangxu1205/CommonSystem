package top.youchangxu.model.system;

import com.baomidou.mybatisplus.annotations.TableId;
import com.baomidou.mybatisplus.annotations.TableName;
import org.springframework.format.annotation.DateTimeFormat;

import java.io.Serializable;
import java.util.Date;

/**
 * Created by dtkj_android on 2017/5/5.
 */
@TableName("staffing_emp")
public class StaffingEmp implements Serializable {
    @TableId
    private long empId;//员工ID
    private String empName;//员工姓名
    private String empPhone;//员工手机号
    private String username;//员工登录名
    private String empAvatarUrl;//员工头像
    private int empStatus;//员工状态
    private String otherInfo;//其他信息
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date createTime;//创建时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date entryTime;//入职时间
    @DateTimeFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private Date updateTime;//更新时间
    @DateTimeFormat(pattern = "yyyy-MM-dd")
    private Date beFormalTime;//转正时间
    private String password;//密码
    private String salt;
    private boolean isInitEasemobAccount;

    public long getEmpId() {
        return empId;
    }

    public void setEmpId(long empId) {
        this.empId = empId;
    }

    public String getEmpName() {
        return empName;
    }

    public void setEmpName(String empName) {
        this.empName = empName;
    }

    public String getEmpPhone() {
        return empPhone;
    }

    public void setEmpPhone(String empPhone) {
        this.empPhone = empPhone;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public String getEmpAvatarUrl() {
        return empAvatarUrl;
    }

    public void setEmpAvatarUrl(String empAvatarUrl) {
        this.empAvatarUrl = empAvatarUrl;
    }

    public int getEmpStatus() {
        return empStatus;
    }

    public void setEmpStatus(int empStatus) {
        this.empStatus = empStatus;
    }

    public String getOtherInfo() {
        return otherInfo;
    }

    public void setOtherInfo(String otherInfo) {
        this.otherInfo = otherInfo;
    }

    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    public Date getEntryTime() {
        return entryTime;
    }

    public void setEntryTime(Date entryTime) {
        this.entryTime = entryTime;
    }

    public Date getUpdateTime() {
        return updateTime;
    }

    public void setUpdateTime(Date updateTime) {
        this.updateTime = updateTime;
    }

    public Date getBeFormalTime() {
        return beFormalTime;
    }

    public void setBeFormalTime(Date beFormalTime) {
        this.beFormalTime = beFormalTime;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }


    public String getSalt() {
        return salt;
    }

    public void setSalt(String salt) {
        this.salt = salt;
    }


    public boolean isInitEasemobAccount() {
        return isInitEasemobAccount;
    }

    public void setInitEasemobAccount(boolean initEasemobAccount) {
        isInitEasemobAccount = initEasemobAccount;
    }

    @Override
    public String toString() {
        return "StaffingEmp{" +
                "empId=" + empId +
                ", empName='" + empName + '\'' +
                ", empPhone='" + empPhone + '\'' +
                ", empAvatarUrl='" + empAvatarUrl + '\'' +
                ", empStatus='" + empStatus + '\'' +
                ", otherInfo='" + otherInfo + '\'' +
                '}';
    }

    public String getCredentialsSalt() {
        return username + salt;
    }
}
