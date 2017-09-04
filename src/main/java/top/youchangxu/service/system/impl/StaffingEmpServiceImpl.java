package top.youchangxu.service.system.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.youchangxu.common.exception.StaffingException;
import top.youchangxu.mapper.system.StaffingEmpMapper;
import top.youchangxu.model.system.*;
import top.youchangxu.service.PasswordHelper;
import top.youchangxu.service.system.IStaffingEmpService;
import top.youchangxu.service.system.IStaffingEnterpriseEmpService;
import top.youchangxu.service.system.IStaffingOrgEmpService;

import java.util.List;

/**
 * Created by dtkj_android on 2017/5/25.
 */
@Service("staffingEmpService")
public class StaffingEmpServiceImpl extends ServiceImpl<StaffingEmpMapper, StaffingEmp> implements IStaffingEmpService {
    @Autowired
    private PasswordHelper passwordHelper;
    @Autowired
    private IStaffingEnterpriseEmpService staffingEnterpriseEmpService;
    @Autowired
    private IStaffingOrgEmpService staffingOrgEmpService;


    @Override
    public List<StaffingRole> findRoles(String enterpriseId, String username) {
        List<StaffingRole> roles = baseMapper.findRoles(enterpriseId, username);
        return roles;
    }

    @Override
    public List<StaffingPermission> findPermissions(String enterpriseId, String username) {
        List<StaffingPermission> permissions = baseMapper.findPermissions(enterpriseId, username);
        return permissions;
    }

    @Override
    public boolean saveEmp(StaffingEmp staffingEmp, Long orgId, String enterpriseId) {
        //判断账户名在企业内是否存在
        List<StaffingEnterpriseEmp> enterpriseEmps = staffingEnterpriseEmpService.selectList(
                new EntityWrapper<StaffingEnterpriseEmp>()
                        .eq("enterpriseId", enterpriseId)
                        .eq("enterpriseEmpName", staffingEmp.getUsername()));

        if (enterpriseEmps.size() > 0) {
            throw new StaffingException("昵称已存在");
        }
        //设置企业的初始密码
        staffingEmp.setPassword("123456");
        //加密数据
        passwordHelper.encryptPassword(staffingEmp);
        //判断手机号是否在员工表中存在
        List<StaffingEmp> staffingEmps = selectList(
                new EntityWrapper<StaffingEmp>()
                        .eq("empPhone", staffingEmp.getEmpPhone()));
        boolean insert;
        if (staffingEmps.size() == 0) {
            insert = insert(staffingEmp);
        } else {
            staffingEmp = staffingEmps.get(0);
            insert = true;
        }

        if (insert) {
            boolean insertEmpToEnterprise = staffingEnterpriseEmpService.insert(
                    new StaffingEnterpriseEmp(Long.parseLong(enterpriseId),
                            staffingEmp.getEmpId(),
                            0,
                            staffingEmp.getPassword(),
                            staffingEmp.getSalt(),
                            staffingEmp.getUsername()));
            if (insertEmpToEnterprise) {
                boolean insertOrgEmp = staffingOrgEmpService.insert(new StaffingOrgEmp(orgId, staffingEmp.getEmpId(), NumberUtils.toLong(enterpriseId)));
                if (insertOrgEmp) {
                    return true;
                } else {
                    throw new StaffingException("员工加入部门失败");
                }
            }
        } else {
            throw new StaffingException("员工加入员工表失败");
        }
        return insert;
    }

    @Override
    public int selectNoSetPostCount(String enterpriseId) {
        return baseMapper.selectNoSetPostCount(enterpriseId);
    }

    @Override
    public List<StaffingEmp> selectNoSetPostEmps(String enterpriseId) {
        return baseMapper.selectNoSetPostEmps(enterpriseId);
    }
}
