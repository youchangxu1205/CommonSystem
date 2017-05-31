package top.youchangxu.mapper.system;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import top.youchangxu.model.system.StaffingEnterprise;
import top.youchangxu.model.system.StaffingEnterpriseEmp;

import java.util.List;

/**
 * Created by dtkj_android on 2017/5/31.
 */
public interface StaffingEnterpriseEmpMapper extends BaseMapper<StaffingEnterpriseEmp> {
    List<StaffingEnterprise> findEnterpriseByEmpId(Long empId);
}
