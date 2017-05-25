package top.youchangxu.common.service.system;

import com.alibaba.fastjson.JSONArray;
import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.common.model.system.StaffingEmp;
import top.youchangxu.common.model.system.StaffingOrg;

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
