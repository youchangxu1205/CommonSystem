package top.youchangxu.service.system.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.system.StaffingRoleMapper;
import top.youchangxu.model.system.StaffingRole;
import top.youchangxu.service.system.IStaffingRoleService;

import java.util.List;

/**
 * Created by dtkj_android on 2017/5/27.
 */
@Service
public class SafffingRoleServiceImpl extends ServiceImpl<StaffingRoleMapper, StaffingRole> implements IStaffingRoleService {
    @Override
    public List<StaffingRole> selectUserRoles(Long enterpriseId, Long empId) {
        return null;
    }
}
