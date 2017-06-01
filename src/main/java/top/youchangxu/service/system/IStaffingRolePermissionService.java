package top.youchangxu.service.system;

import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.StaffingRolePermission;

/**
 * Created by dtkj_android on 2017/6/1.
 */
public interface IStaffingRolePermissionService extends IService<StaffingRolePermission> {
    int updateRolePermission(JSONArray datas, Long roleId);
}
