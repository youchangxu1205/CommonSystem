package top.youchangxu.mapper.system;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.apache.ibatis.annotations.Param;
import top.youchangxu.model.system.StaffingEmp;
import top.youchangxu.model.system.StaffingPermission;
import top.youchangxu.model.system.StaffingRole;

import java.util.List;

/**
 * Created by dtkj_android on 2017/5/25.
 */
public interface StaffingEmpMapper extends BaseMapper<StaffingEmp> {
    /**
     * 获取员工的角色
     * @param enterpriseId
     * @param empId
     * @return
     */
    List<StaffingRole> findRoles(@Param("enterpriseId") String enterpriseId, @Param("empId") String empId);

    /**
     * 获取员工的权限
     * @param enterpriseId
     * @param empId
     * @return
     */
    List<StaffingPermission> findPermissions(@Param("enterpriseId") String enterpriseId, @Param("empId") String empId);
}
