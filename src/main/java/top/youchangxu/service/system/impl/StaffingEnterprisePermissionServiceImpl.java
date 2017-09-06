package top.youchangxu.service.system.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.system.StaffingEnterprisePermissionMapper;
import top.youchangxu.model.system.StaffingEnterprisePermission;
import top.youchangxu.service.system.IStaffingEnterprisePermissionService;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by Administrator on 2017/9/5.
 */
@Service("staffingEnterprisePermissionService")
public class StaffingEnterprisePermissionServiceImpl extends ServiceImpl<StaffingEnterprisePermissionMapper, StaffingEnterprisePermission> implements IStaffingEnterprisePermissionService {
    @Override
    public int updateEnterprisePermission(JSONArray datas, Long enterpriseId) {
        List<Integer> deleteIds = new ArrayList<>();
        for (int i = 0; i < datas.size(); i++) {
            JSONObject json = datas.getJSONObject(i);
            if (!json.getBoolean("checked")) {
                deleteIds.add(json.getIntValue("id"));
            } else {
                // 新增权限
                StaffingEnterprisePermission staffingEnterprisePermission = new StaffingEnterprisePermission();
                staffingEnterprisePermission.setEnterpriseId(enterpriseId);
                staffingEnterprisePermission.setPermissionId(json.getLongValue("id"));
                baseMapper.insert(staffingEnterprisePermission);
            }
        }
        // 删除权限
        if (deleteIds.size() > 0) {
            EntityWrapper<StaffingEnterprisePermission> staffingEnterprisePermissionEntityWrapper = new EntityWrapper<>();
            staffingEnterprisePermissionEntityWrapper.eq("enterpriseId", enterpriseId).in("permissionId", deleteIds);
            baseMapper.delete(staffingEnterprisePermissionEntityWrapper);
        }
        return datas.size();
    }
}
