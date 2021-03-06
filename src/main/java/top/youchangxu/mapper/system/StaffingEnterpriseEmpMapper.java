package top.youchangxu.mapper.system;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.springframework.stereotype.Repository;
import top.youchangxu.model.system.StaffingEnterprise;
import top.youchangxu.model.system.StaffingEnterpriseEmp;

import java.util.List;

/**
 * Created by dtkj_android on 2017/5/31.
 */
@Repository
public interface StaffingEnterpriseEmpMapper extends BaseMapper<StaffingEnterpriseEmp> {
    /**
     * 查找员工所加入的企业
     * @param empId
     * @return
     */
    List<StaffingEnterprise> findEnterpriseByEmpId(Long empId);
}
