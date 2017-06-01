package top.youchangxu.service.system.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.system.StaffingRolePermissionMapper;
import top.youchangxu.model.system.StaffingRolePermission;
import top.youchangxu.service.system.IStaffingRolePermissionService;

import java.util.ArrayList;
import java.util.List;

/**
 * Created by dtkj_android on 2017/6/1.
 */
@Service
public class StaffingRolePermissionService extends ServiceImpl<StaffingRolePermissionMapper, StaffingRolePermission> implements IStaffingRolePermissionService {
    @Override
    public int updateRolePermission(JSONArray datas, Long roleId) {
        List<Integer> deleteIds = new ArrayList<>();
        for (int i = 0; i < datas.size(); i ++) {
            JSONObject json = datas.getJSONObject(i);
            if (!json.getBoolean("checked")) {
                deleteIds.add(json.getIntValue("id"));
            } else {
                // 新增权限
                StaffingRolePermission staffingRolePermission = new StaffingRolePermission();
                staffingRolePermission.setRoleId(roleId);
                staffingRolePermission.setPermissionId(json.getLongValue("id"));
                baseMapper.insert(staffingRolePermission);
            }
        }
        // 删除权限
        if (deleteIds.size() > 0) {
            EntityWrapper<StaffingRolePermission> staffingRolePermissionEntityWrapper = new EntityWrapper<>();
            staffingRolePermissionEntityWrapper.eq("roleId",roleId).in("permissionId",deleteIds);
            baseMapper.delete(staffingRolePermissionEntityWrapper);
        }
        return datas.size();
    }
}
