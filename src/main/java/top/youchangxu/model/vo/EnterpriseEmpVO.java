package top.youchangxu.model.vo;

/**
 * Created by dtkj_android on 2017/6/5.
 */
public class EnterpriseEmpVO {
    private Long enterpriseId;
    private String enterpriseAccount;
    private String enterpriseCode;
    private String username;//账户名 需要保持唯一
    private boolean isPwdOk;



    public Long getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
    }

    public String getEnterpriseAccount() {
        return enterpriseAccount;
    }

    public void setEnterpriseAccount(String enterpriseAccount) {
        this.enterpriseAccount = enterpriseAccount;
    }

    public String getEnterpriseCode() {
        return enterpriseCode;
    }

    public void setEnterpriseCode(String enterpriseCode) {
        this.enterpriseCode = enterpriseCode;
    }

    public String getUsername() {
        return username;
    }

    public void setUsername(String username) {
        this.username = username;
    }

    public boolean isPwdOk() {
        return isPwdOk;
    }

    public void setPwdOk(boolean pwdOk) {
        isPwdOk = pwdOk;
    }
}
