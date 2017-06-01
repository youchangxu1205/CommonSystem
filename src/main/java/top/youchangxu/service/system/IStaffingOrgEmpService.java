package top.youchangxu.service.system;

import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.StaffingOrgEmp;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/1.
 */
public interface IStaffingOrgEmpService extends IService<StaffingOrgEmp> {
    /**
     * 获取部门下的员工(包含下级部门的员工)
     * @param orgId
     * @return
     */
//    List<Long> selectAllEmpByOrg(Long orgId);
}
