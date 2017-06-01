package top.youchangxu.service.system;

import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.StaffingRoleEmp;

/**
 * Created by dtkj_android on 2017/6/1.
 */
public interface IStaffingRoleEmpService extends IService<StaffingRoleEmp>{
    int updateRole(String[] roleIds, Long empId);
}
