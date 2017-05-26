package top.youchangxu.service.system;

import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.StaffingOrg;

/**
 * Created by dtkj_android on 2017/5/25.
 */
public interface IStaffingOrgService extends IService<StaffingOrg> {

    /**
     * 获取部门树
     * @param orgId
     * @return
     */
    JSONArray getOrgTree(Long orgId);
}
