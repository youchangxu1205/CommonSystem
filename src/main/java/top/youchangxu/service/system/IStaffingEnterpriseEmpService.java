package top.youchangxu.service.system;

import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.StaffingEnterprise;
import top.youchangxu.model.system.StaffingEnterpriseEmp;

import java.util.List;

/**
 * Created by dtkj_android on 2017/5/31.
 */
public interface IStaffingEnterpriseEmpService extends IService<StaffingEnterpriseEmp> {

    /**
     * 根据empid获取员工加入的企业
     * @param empId
     * @return
     */
    List<StaffingEnterprise> findEnterpriseByEmpId(Long empId);
}
