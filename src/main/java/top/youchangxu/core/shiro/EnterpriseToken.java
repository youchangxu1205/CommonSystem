package top.youchangxu.core.shiro;

import org.apache.shiro.authc.UsernamePasswordToken;

/**
 * Created by dtkj_android on 2017/5/31.
 */
public class EnterpriseToken extends UsernamePasswordToken {

    private Long enterpriseId;

    public EnterpriseToken(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
    }

    public EnterpriseToken(String username, char[] password, Long enterpriseId) {
        super(username, password);
        this.enterpriseId = enterpriseId;
    }

    public EnterpriseToken(String username, String password, Long enterpriseId) {
        super(username, password);
        this.enterpriseId = enterpriseId;
    }

    public EnterpriseToken(String username, char[] password, String host, Long enterpriseId) {
        super(username, password, host);
        this.enterpriseId = enterpriseId;
    }

    public EnterpriseToken(String username, String password, String host, Long enterpriseId) {
        super(username, password, host);
        this.enterpriseId = enterpriseId;
    }

    public EnterpriseToken(String username, char[] password, boolean rememberMe, Long enterpriseId) {
        super(username, password, rememberMe);
        this.enterpriseId = enterpriseId;
    }

    public EnterpriseToken(String username, String password, boolean rememberMe, Long enterpriseId) {
        super(username, password, rememberMe);
        this.enterpriseId = enterpriseId;
    }

    public EnterpriseToken(String username, char[] password, boolean rememberMe, String host, Long enterpriseId) {
        super(username, password, rememberMe, host);
        this.enterpriseId = enterpriseId;
    }

    public EnterpriseToken(String username, String password, boolean rememberMe, String host, Long enterpriseId) {
        super(username, password, rememberMe, host);
        this.enterpriseId = enterpriseId;
    }

    public Long getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
    }
}
