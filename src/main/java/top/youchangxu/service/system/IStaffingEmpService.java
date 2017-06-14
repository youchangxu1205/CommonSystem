package top.youchangxu.service.system;

import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.StaffingEmp;
import top.youchangxu.model.system.StaffingPermission;
import top.youchangxu.model.system.StaffingRole;

import java.util.List;
import java.util.Set;

/**
 * Created by dtkj_android on 2017/5/25.
 */
public interface IStaffingEmpService extends IService<StaffingEmp> {
    List<StaffingRole> findRoles(String enterpriseId, String empId);

    List<StaffingPermission> findPermissions(String enterpriseId, String empId);

    boolean saveEmp(StaffingEmp staffingEmp, Long orgId, String enterpriseId);

    int selectNoSetPostCount(String enterpriseId);

    List<StaffingEmp> selectNoSetPostEmps(String enterpriseId);
}
