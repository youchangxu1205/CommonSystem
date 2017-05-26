package top.youchangxu.core.shiro.realm;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import org.apache.shiro.authc.*;
import org.apache.shiro.authz.AuthorizationInfo;
import org.apache.shiro.authz.SimpleAuthorizationInfo;
import org.apache.shiro.realm.AuthorizingRealm;
import org.apache.shiro.subject.PrincipalCollection;
import org.apache.shiro.util.ByteSource;
import org.springframework.beans.factory.annotation.Autowired;
import top.youchangxu.model.system.StaffingEmp;
import top.youchangxu.service.system.IStaffingEmpService;

/**
 * Created by dtkj_android on 2017/5/26.
 */
public class UserRealm extends AuthorizingRealm {

    @Autowired
    private IStaffingEmpService staffingEmpService;

    @Override
    protected AuthorizationInfo doGetAuthorizationInfo(PrincipalCollection principals) {
        String username = (String)principals.getPrimaryPrincipal();
        SimpleAuthorizationInfo authorizationInfo = new SimpleAuthorizationInfo();
//        authorizationInfo.setRoles(userService.findRoles(username));
//        authorizationInfo.setStringPermissions(userService.findPermissions(username));
//        System.out.println(userService.findPermissions(username));
        //设置权限给用户
        return authorizationInfo;
    }

    @Override
    protected AuthenticationInfo doGetAuthenticationInfo(AuthenticationToken token) throws AuthenticationException {
        String username = (String)token.getPrincipal();
        StaffingEmp staffingEmp = staffingEmpService.selectOne(new EntityWrapper<StaffingEmp>().eq("username", username));
        if(staffingEmp == null) {
            throw new UnknownAccountException();//没找到帐号
        }
//        if(Boolean.TRUE.equals(staffingEmp.getLocked())) {
//            throw new LockedAccountException(); //帐号锁定
//        }
        return new SimpleAuthenticationInfo(
                staffingEmp.getUsername(), //用户名
                staffingEmp.getPassword(), //密码
                ByteSource.Util.bytes(staffingEmp.getCredentialsSalt()),//salt=username+salt
                getName()  //realm name
        );
    }
}
