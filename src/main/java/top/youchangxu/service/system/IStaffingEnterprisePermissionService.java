package top.youchangxu.service.system;

import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.StaffingEnterprisePermission;

/**
 * Created by Administrator on 2017/9/5.
 */
public interface IStaffingEnterprisePermissionService extends IService<StaffingEnterprisePermission> {
    /**
     * 更新企业权限
     * @param datas
     * @param roleId
     * @return
     */
    int updateEnterprisePermission(JSONArray datas, Long roleId);
}
