package top.youchangxu.service.system;

import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.StaffingOrgEmp;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/1.
 */
public interface IStaffingOrgEmpService extends IService<StaffingOrgEmp> {
    int updateEmpOrg(String[] empIds, Long empId, String enterpriseId);
}
