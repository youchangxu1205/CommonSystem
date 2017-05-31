package top.youchangxu.service.system;

import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.StaffingPermission;

import java.util.List;

/**
 * Created by dtkj_android on 2017/5/25.
 */
public interface IStaffingPermissionService extends IService<StaffingPermission> {
    /**
     * 根据用户名查询权限
     *
     * @param username
     * @return
     */
    List<StaffingPermission> selectPermissionByUsername(String username);

    /**
     * 根据角色id获取权限列表
     *
     * @param roleId
     * @return
     */
    JSONArray getTreeByRoleId(Long roleId);
}
