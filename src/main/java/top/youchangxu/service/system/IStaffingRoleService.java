package top.youchangxu.service.system;

import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.StaffingRole;

import java.util.List;

/**
 * Created by dtkj_android on 2017/5/27.
 */
public interface IStaffingRoleService extends IService<StaffingRole> {
    /**
     * 查询用户角色
     *
     * @param enterpriseId
     * @param empId
     * @return
     */
    List<StaffingRole> selectUserRoles(Long enterpriseId, Long empId);
}
