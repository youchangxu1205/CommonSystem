package top.youchangxu.core.shiro;

import org.apache.shiro.authc.UsernamePasswordToken;
import top.youchangxu.model.vo.EnterpriseEmpVO;

/**
 * Created by dtkj_android on 2017/5/31.
 */
public class EnterpriseToken extends UsernamePasswordToken {

    private Long enterpriseId;

    private EnterpriseEmpVO enterpriseEmpVO;

    public EnterpriseToken(Long enterpriseId, EnterpriseEmpVO enterpriseEmpVO) {
        this.enterpriseId = enterpriseId;
        this.enterpriseEmpVO = enterpriseEmpVO;
    }

    public EnterpriseToken(String username, char[] password, Long enterpriseId, EnterpriseEmpVO enterpriseEmpVO) {
        super(username, password);
        this.enterpriseId = enterpriseId;
        this.enterpriseEmpVO = enterpriseEmpVO;
    }

    public EnterpriseToken(String username, String password, Long enterpriseId, EnterpriseEmpVO enterpriseEmpVO) {
        super(username, password);
        this.enterpriseId = enterpriseId;
        this.enterpriseEmpVO = enterpriseEmpVO;
    }

    public EnterpriseToken(String username, char[] password, String host, Long enterpriseId, EnterpriseEmpVO enterpriseEmpVO) {
        super(username, password, host);
        this.enterpriseId = enterpriseId;
        this.enterpriseEmpVO = enterpriseEmpVO;
    }

    public EnterpriseToken(String username, String password, String host, Long enterpriseId, EnterpriseEmpVO enterpriseEmpVO) {
        super(username, password, host);
        this.enterpriseId = enterpriseId;
        this.enterpriseEmpVO = enterpriseEmpVO;
    }

    public EnterpriseToken(String username, char[] password, boolean rememberMe, Long enterpriseId, EnterpriseEmpVO enterpriseEmpVO) {
        super(username, password, rememberMe);
        this.enterpriseId = enterpriseId;
        this.enterpriseEmpVO = enterpriseEmpVO;
    }

    public EnterpriseToken(String username, String password, boolean rememberMe, Long enterpriseId, EnterpriseEmpVO enterpriseEmpVO) {
        super(username, password, rememberMe);
        this.enterpriseId = enterpriseId;
        this.enterpriseEmpVO = enterpriseEmpVO;
    }

    public EnterpriseToken(String username, char[] password, boolean rememberMe, String host, Long enterpriseId, EnterpriseEmpVO enterpriseEmpVO) {
        super(username, password, rememberMe, host);
        this.enterpriseId = enterpriseId;
        this.enterpriseEmpVO = enterpriseEmpVO;
    }

    public EnterpriseToken(String username, String password, boolean rememberMe, String host, Long enterpriseId, EnterpriseEmpVO enterpriseEmpVO) {
        super(username, password, rememberMe, host);
        this.enterpriseId = enterpriseId;
        this.enterpriseEmpVO = enterpriseEmpVO;
    }

    public Long getEnterpriseId() {
        return enterpriseId;
    }

    public void setEnterpriseId(Long enterpriseId) {
        this.enterpriseId = enterpriseId;
    }

    public EnterpriseEmpVO getEnterpriseEmpVO() {
        return enterpriseEmpVO;
    }

    public void setEnterpriseEmpVO(EnterpriseEmpVO enterpriseEmpVO) {
        this.enterpriseEmpVO = enterpriseEmpVO;
    }
}
