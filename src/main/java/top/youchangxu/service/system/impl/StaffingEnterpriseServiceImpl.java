package top.youchangxu.service.system.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.system.StaffingEnterpriseMapper;
import top.youchangxu.model.system.*;
import top.youchangxu.service.PasswordHelper;
import top.youchangxu.service.system.*;

import java.util.Date;
import java.util.List;

/**
 * Created by dtkj_android on 2017/5/26.
 */
@Service
public class StaffingEnterpriseServiceImpl extends ServiceImpl<StaffingEnterpriseMapper, StaffingEnterprise> implements IStaffingEnterpriseService {

    @Autowired
    private IStaffingOrgService staffingOrgService;
    @Autowired
    private IStaffingEmpService staffingEmpService;

    @Autowired
    private IStaffingEnterpriseEmpService staffingEnterpriseEmpService;

    @Autowired
    private PasswordHelper passwordHelper;
    @Autowired
    private IStaffingRoleService staffingRoleService;
    @Autowired
    private IStaffingRolePermissionService staffingRolePermissionService;
    @Autowired
    private IStaffingRoleEmpService staffingRoleEmpService;
    @Autowired
    private IStaffingOrgEmpService staffingOrgEmpService;


    @Override
    public boolean saveEnterprise(StaffingEnterprise staffingEnterprise) {
        boolean insert = insert(staffingEnterprise);
        if (insert) {
            StaffingOrg staffingOrg = new StaffingOrg(staffingEnterprise.getEnterpriseName(),
                    0L,
                    1,
                    staffingEnterprise.getEnterpriseId());

            staffingOrgService.insert(staffingOrg);
            staffingOrg.setOrgPath(staffingOrg.getOrgId() + "");
            staffingOrgService.updateById(staffingOrg);
            //新增员工
            StaffingEmp staffingEmp = new StaffingEmp();
            staffingEmp.setUsername(staffingEnterprise.getEnterpriseCode() + "system");
            staffingEmp.setEmpName("系统管理员");
            staffingEmp.setPassword("123456");
            staffingEmp.setEmpPhone(staffingEnterprise.getEnterpriseCode() + "system");
            staffingEmp.setEntryTime(new Date());
            staffingEmp.setBeFormalTime(new Date());
            staffingEmp.setEmpStatus(1);
            passwordHelper.encryptPassword(staffingEmp);
            staffingEmpService.insert(staffingEmp);
            //员工加入企业
            StaffingEnterpriseEmp staffingEnterpriseEmp = new StaffingEnterpriseEmp(staffingEnterprise.getEnterpriseId(), staffingEmp.getEmpId());
            staffingEnterpriseEmpService.insert(staffingEnterpriseEmp);

            //新增角色
            StaffingRole staffingRole = new StaffingRole();
            staffingRole.setRoleName("系统管理员");
            staffingRole.setEnterpriseId(staffingEnterprise.getEnterpriseId());
            staffingRoleService.insert(staffingRole);

            //获取通用系统管理员 enterprieId为-1
            StaffingRole commonSysRole = staffingRoleService
                    .selectOne(
                            new EntityWrapper<StaffingRole>()
                                    .eq("enterpriseId", -1)
                                    .eq("roleName", "系统管理员"));
            //获取管理员的权限复制到系统管理员
            List<StaffingRolePermission> rolePermissions = staffingRolePermissionService
                    .selectList(new EntityWrapper<StaffingRolePermission>()
                            .eq("roleId", commonSysRole.getRoleId()));
            //复制权限
            for (StaffingRolePermission staffingRolePermission :
                    rolePermissions) {
                staffingRolePermission.setRoleId(staffingRole.getRoleId());
            }
            //插入权限
            staffingRolePermissionService.insertBatch(rolePermissions);

            //给员工分配角色
            StaffingRoleEmp staffingRoleEmp = new StaffingRoleEmp();
            staffingRoleEmp.setRoleId(staffingRole.getRoleId());
            staffingRoleEmp.setEmpId(staffingEmp.getEmpId());
            staffingRoleEmp.setEnterpriseId(staffingEnterprise.getEnterpriseId());
            staffingRoleEmpService.insert(staffingRoleEmp);
            //新增员工至顶级部门
            staffingOrgEmpService.insert(new StaffingOrgEmp(staffingOrg.getOrgId(), staffingEmp.getEmpId(), staffingEnterprise.getEnterpriseId()));

        }
        return insert;
    }
}
