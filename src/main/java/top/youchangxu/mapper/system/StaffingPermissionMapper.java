package top.youchangxu.mapper.system;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.springframework.stereotype.Repository;
import top.youchangxu.model.system.StaffingPermission;

import java.util.List;

/**
 * Created by dtkj_android on 2017/5/25.
 */
@Repository
public interface StaffingPermissionMapper extends BaseMapper<StaffingPermission> {
    /**
     * 根据角色id查找权限
     *
     * @param roleId
     * @return
     */
    List<StaffingPermission> selectPermissionByRoleId(Long roleId);
}
