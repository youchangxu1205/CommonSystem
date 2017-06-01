package top.youchangxu.service.system.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.system.StaffingRoleEmpMapper;
import top.youchangxu.model.system.StaffingRoleEmp;
import top.youchangxu.service.system.IStaffingRoleEmpService;

/**
 * Created by dtkj_android on 2017/6/1.
 */
@Service
public class StaffingRoleEmpServiceImpl extends ServiceImpl<StaffingRoleEmpMapper, StaffingRoleEmp> implements IStaffingRoleEmpService {
    @Override
    public int updateRole(String[] roleIds, Long empId) {
        int result = 0;
        // 删除旧记录
        baseMapper.delete(new EntityWrapper<StaffingRoleEmp>().eq("empId",empId));
        // 增加新记录
        if (null != roleIds) {
            for (String roleId : roleIds) {
                if (StringUtils.isBlank(roleId)) {
                    continue;
                }
                StaffingRoleEmp staffingRoleEmp = new StaffingRoleEmp();
                staffingRoleEmp.setEmpId(empId);
                staffingRoleEmp.setRoleId(NumberUtils.toLong(roleId));
                result = baseMapper.insert(staffingRoleEmp);
            }
        }
        return result;

    }
}