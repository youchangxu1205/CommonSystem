package top.youchangxu.core.shiro.realm;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.apache.commons.lang.StringUtils;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import top.youchangxu.core.shiro.EnterpriseToken;
import top.youchangxu.model.system.StaffingEmp;
import top.youchangxu.model.system.StaffingPermission;
import top.youchangxu.model.system.StaffingRole;
import top.youchangxu.model.vo.EnterpriseEmpVO;
import top.youchangxu.service.system.IStaffingEmpService;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by dtkj_android on 2017/5/26.
 */
public class UserRealm extends AuthorizingRealm {

    @Autowired
    private IStaffingEmpService staffingEmpService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        String primaryPrincipal = (String)principals.getPrimaryPrincipal();
        String[] strings = primaryPrincipal.split("#");
        String enterpriseId = strings[0];
        String empId = strings[1];
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
        List<StaffingRole> roles = staffingEmpService.findRoles(enterpriseId, empId);
        Set<String> roleStrs =new HashSet<>();
        for (StaffingRole staffingRole :
                roles) {
            if(StringUtils.isNotBlank(staffingRole.getRoleName())) {
                roleStrs.add(staffingRole.getRoleName());
            }
        }
        authorizationInfo.setRoles(roleStrs);
        Set<String> permissionStrs =new HashSet<>();
        List<StaffingPermission> permissions = staffingEmpService.findPermissions(enterpriseId, empId);
        for (StaffingPermission staffingPermission :
                permissions) {
            if(StringUtils.isNotBlank(staffingPermission.getPermissionValue())) {
                permissionStrs.add(staffingPermission.getPermissionValue());
            }
        }

        authorizationInfo.setStringPermissions(permissionStrs);


        return authorizationInfo;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        EnterpriseToken  enterpriseToken = (EnterpriseToken) token;
        String empId = (String)token.getPrincipal();
        Long enterpriseId = enterpriseToken.getEnterpriseId();

        EnterpriseEmpVO enterpriseEmpVO = enterpriseToken.getEnterpriseEmpVO();
        if(enterpriseEmpVO!=null){
            //TODO 表示用户加入的企业为多个
            empId = enterpriseEmpVO.getUsername();
            //多个企业走到这一步证明
            return new SimpleAuthenticationInfo(enterpriseEmpVO.getEnterpriseId()+"#"+empId,"",getName());

        }

        StaffingEmp staffingEmp = staffingEmpService.selectById(empId);
        if(staffingEmp == null) {
            throw new UnknownAccountException();//没找到帐号
        }

        return new SimpleAuthenticationInfo(
                enterpriseId+"#"+staffingEmp.getEmpId(), //用户名
                staffingEmp.getPassword(), //密码
                ByteSource.Util.bytes(staffingEmp.getCredentialsSalt()),//salt=username+salt
                getName()  //realm name
        );
    }
}
