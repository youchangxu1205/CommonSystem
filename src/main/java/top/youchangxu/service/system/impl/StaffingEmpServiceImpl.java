package top.youchangxu.service.system.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.common.utils.StringUtil;
import top.youchangxu.mapper.system.StaffingEmpMapper;
import top.youchangxu.model.system.StaffingEmp;
import top.youchangxu.model.system.StaffingPermission;
import top.youchangxu.service.system.IStaffingEmpService;

import java.util.HashSet;
import java.util.List;
import java.util.Set;

/**
 * Created by dtkj_android on 2017/5/25.
 */
@Service
public class StaffingEmpServiceImpl extends ServiceImpl<StaffingEmpMapper, StaffingEmp> implements IStaffingEmpService {
    @Override
    public Set<String> findRoles(String enterpriseId, String username) {
        List<String> roles = baseMapper.findRoles(enterpriseId, username);
        Set<String> set = new HashSet<>();

        for (String role: roles
             ) {
            if(StringUtil.isNotEmpty(role)) {
                set.add(role);
            }
        }
        return set;
    }

    @Override
    public List<StaffingPermission> findPermissions(String enterpriseId, String username) {
        List<StaffingPermission> permissions = baseMapper.findPermissions(enterpriseId, username);
        return permissions;
    }
}
