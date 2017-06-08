package top.youchangxu.service.system.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.system.StaffingOrgEmpMapper;
import top.youchangxu.model.system.StaffingOrgEmp;
import top.youchangxu.model.system.StaffingRoleEmp;
import top.youchangxu.service.system.IStaffingOrgEmpService;

/**
 * Created by dtkj_android on 2017/6/1.
 */
@Service
public class StaffingOrgEmpServiceImpl extends ServiceImpl<StaffingOrgEmpMapper, StaffingOrgEmp> implements IStaffingOrgEmpService {


    @Override
    public int updateEmpOrg(String[] orgIds, Long empId, String enterpriseId) {
        int result = 0;
        // 删除旧记录
        baseMapper.delete(new EntityWrapper<StaffingOrgEmp>().eq("empId",empId).eq("enterpriseId",enterpriseId));
        // 增加新记录
        if (null != orgIds) {
            for (String  orgId: orgIds) {
                if (StringUtils.isBlank(orgId)) {
                    continue;
                }
                StaffingOrgEmp staffingOrgEmp = new StaffingOrgEmp(NumberUtils.toLong(orgId),empId,NumberUtils.toLong(enterpriseId));
                result = baseMapper.insert(staffingOrgEmp);
            }
        }
        return result;
    }
}
