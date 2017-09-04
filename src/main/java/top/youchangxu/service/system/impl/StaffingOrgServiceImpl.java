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
@Service("staffingOrgService")
public class StaffingOrgServiceImpl extends ServiceImpl<StaffingOrgMapper, StaffingOrg> implements IStaffingOrgService {

    @Override
    public JSONArray getOrgTree(Long enterpriseId) {
        JSONArray orgs = new JSONArray();

        StaffingOrg staffingOrg = new StaffingOrg();
        staffingOrg.setpOrgId(0L);
        staffingOrg.setEnterpriseId(enterpriseId);
        staffingOrg = baseMapper.selectOne(staffingOrg);
        JSONObject topOrg = new JSONObject();
        topOrg.put("id", staffingOrg.getOrgId());
        topOrg.put("name", staffingOrg.getOrgName());
        topOrg.put("open", true);
        JSONArray childArray = getChildOrgTree(staffingOrg.getOrgId(),enterpriseId);
        topOrg.put("children", childArray);
        orgs.add(topOrg);
        return orgs;
    }

    @Override
    public JSONArray getOrgBootstrapTree(Long enterpriseId) {
        JSONArray orgs = new JSONArray();
        StaffingOrg staffingOrg = new StaffingOrg();
        staffingOrg.setpOrgId(0L);
        staffingOrg.setEnterpriseId(enterpriseId);
        staffingOrg = baseMapper.selectOne(staffingOrg);
        JSONObject topOrg = new JSONObject();
        topOrg.put("text", staffingOrg.getOrgName());
        topOrg.put("id",staffingOrg.getOrgId());
        JSONArray childArray = getChildBootstrapOrgTree(staffingOrg.getOrgId(),enterpriseId);
        topOrg.put("nodes", childArray);
        orgs.add(topOrg);
        return orgs;
    }

    public JSONArray getChildBootstrapOrgTree(Long orgId,Long enterpriseId) {
        EntityWrapper<StaffingOrg> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq("pOrgId",orgId)
        .eq("enterpriseId",enterpriseId);

        List<StaffingOrg> childOrgs = baseMapper.selectList(entityWrapper);
        JSONArray childArray = new JSONArray();
        if (childOrgs.size() > 0) {
            for (StaffingOrg childOrg :
                    childOrgs) {
                JSONObject node = new JSONObject();
                node.put("id",childOrg.getOrgId());
                node.put("text", childOrg.getOrgName());
                JSONArray childArray1 = getChildBootstrapOrgTree(childOrg.getOrgId(),enterpriseId);
                node.put("nodes", childArray1);
                childArray.add(node);
            }
        }
        return childArray;
    }


    public JSONArray getChildOrgTree(Long orgId, Long enterpriseId) {
        EntityWrapper<StaffingOrg> entityWrapper = new EntityWrapper<>();
        entityWrapper.eq("pOrgId",orgId);
        entityWrapper.eq("enterpriseId",enterpriseId);
        List<StaffingOrg> childOrgs = baseMapper.selectList(entityWrapper);
        JSONArray childArray = new JSONArray();
        if (childOrgs.size() > 0) {
            for (StaffingOrg childOrg :
                    childOrgs) {
                JSONObject node = new JSONObject();
                node.put("id", childOrg.getOrgId());
                node.put("name", childOrg.getOrgName());
                node.put("open", true);
                JSONArray childArray1 = getChildOrgTree(childOrg.getOrgId(), enterpriseId);
                node.put("children", childArray1);
                childArray.add(node);
            }
        }
        return childArray;
    }

}
