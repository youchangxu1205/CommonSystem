package top.youchangxu.service.system.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.system.StaffingPermissionMapper;
import top.youchangxu.model.system.StaffingPermission;
import top.youchangxu.service.system.IStaffingPermissionService;

import java.util.List;

/**
 * Created by dtkj_android on 2017/5/25.
 */
@Service
public class StaffingPermissionServiceImpl extends ServiceImpl<StaffingPermissionMapper,StaffingPermission> implements IStaffingPermissionService {



    @Override
    public List<StaffingPermission> selectPermissionByUsername(String username) {

        return null;
    }
}
