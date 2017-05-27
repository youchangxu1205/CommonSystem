package top.youchangxu.service.system.impl;

import com.alibaba.fastjson.JSONArray;
import com.alibaba.fastjson.JSONObject;
import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.system.StaffingOrgMapper;
import top.youchangxu.model.system.StaffingOrg;
import top.youchangxu.service.system.IStaffingOrgService;

import java.util.List;

/**
 * Created by dtkj_android on 2017/5/25.
 */
@Service
public class StaffingOrgServiceImpl extends ServiceImpl<StaffingOrgMapper, StaffingOrg> implements IStaffingOrgService {

    @Override
    public JSONArray getOrgTree(Long orgId) {
        JSONArray orgs = new JSONArray();
        StaffingOrg staffingOrg = baseMapper.selectById(orgId);
        JSONObject topOrg = new JSONObject();
        topOrg.put("id", staffingOrg.getOrgId());
        topOrg.put("name", staffingOrg.getOrgName());
        topOrg.put("open", true);
        JSONArray childArray = getChildOrgTree(orgId);
        topOrg.put("children", childArray);
        orgs.add(topOrg);
        return orgs;
    }

    public JSONArray getChildOrgTree(Long orgId) {
        EntityWrapper<StaffingOrg> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq("pOrgId",orgId);
        List<StaffingOrg> childOrgs = baseMapper.selectList(entityWrapper);
        JSONArray childArray = new JSONArray();
        if (childOrgs.size() > 0) {
            for (StaffingOrg childOrg :
                    childOrgs) {
                JSONObject node = new JSONObject();
                node.put("id", childOrg.getOrgId());
                node.put("name", childOrg.getOrgName());
                node.put("open", true);
                JSONArray childArray1 = getChildOrgTree(childOrg.getOrgId());
                node.put("children", childArray1);
                childArray.add(node);
            }
        }
        return childArray;
    }

}
