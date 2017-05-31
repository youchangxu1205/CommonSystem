package top.youchangxu.mapper.system;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import top.youchangxu.model.system.StaffingPermission;

import java.util.List;

/**
 * Created by dtkj_android on 2017/5/25.
 */
public interface StaffingPermissionMapper extends BaseMapper<StaffingPermission>{
    List<StaffingPermission> selectPermissionByRoleId(Long roleId);
}
