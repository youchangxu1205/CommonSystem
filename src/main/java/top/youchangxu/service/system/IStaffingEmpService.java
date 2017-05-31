package top.youchangxu.service.system;

import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.StaffingEmp;
import top.youchangxu.model.system.StaffingPermission;

import java.util.List;
import java.util.Set;

/**
 * Created by dtkj_android on 2017/5/25.
 */
public interface IStaffingEmpService extends IService<StaffingEmp> {
    Set<String> findRoles(String enterpriseId, String username);

    List<StaffingPermission> findPermissions(String enterpriseId, String username);
}
