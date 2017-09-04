package top.youchangxu.service.system.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.system.StaffingEnterpriseEmpMapper;
import top.youchangxu.model.system.StaffingEnterprise;
import top.youchangxu.model.system.StaffingEnterpriseEmp;
import top.youchangxu.service.system.IStaffingEnterpriseEmpService;

import java.util.List;

/**
 * Created by dtkj_android on 2017/5/31.
 */
@Service("staffingEnterpriseEmpService")
public class StaffingEnterpriseEmpServiceImpl extends ServiceImpl<StaffingEnterpriseEmpMapper, StaffingEnterpriseEmp> implements IStaffingEnterpriseEmpService {

    @Override
    public List<StaffingEnterprise> findEnterpriseByEmpId(Long empId) {
        List<StaffingEnterprise> enterprises = baseMapper.findEnterpriseByEmpId(empId);
        return enterprises;
    }
}
