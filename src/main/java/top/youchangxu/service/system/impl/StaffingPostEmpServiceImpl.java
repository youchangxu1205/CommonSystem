package top.youchangxu.service.system.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.system.StaffingPostEmpMapper;
import top.youchangxu.model.system.StaffingOrgEmp;
import top.youchangxu.model.system.StaffingPost;
import top.youchangxu.model.system.StaffingPostEmp;
import top.youchangxu.service.system.IStaffingOrgEmpService;
import top.youchangxu.service.system.IStaffingPostEmpService;
import top.youchangxu.service.system.IStaffingPostService;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/14.
 */
@Service
public class StaffingPostEmpServiceImpl extends ServiceImpl<StaffingPostEmpMapper, StaffingPostEmp> implements IStaffingPostEmpService {
    @Autowired
    private IStaffingPostService staffingPostService;
    @Autowired
    private IStaffingOrgEmpService staffingOrgEmpService;

    @Override
    public int updateEmpPost(String[] postIds, Long empId, String enterpriseId) {
        int result = 0;
        // 删除旧记录
        baseMapper.delete(new EntityWrapper<StaffingPostEmp>()
                .eq("empId", empId)
                .eq("enterpriseId", enterpriseId));

        staffingOrgEmpService.delete(new EntityWrapper<StaffingOrgEmp>()
                .eq("empId", empId)
                .eq("enterpriseId", enterpriseId));


        // 增加新记录
        if (null != postIds) {
            List<Object> orgIds = staffingPostService
                    .selectObjs(new EntityWrapper<StaffingPost>()
                            .in("postId", postIds)
                            .eq("enterpriseId", enterpriseId)
                            .setSqlSelect("orgId").groupBy("orgId"));

            for(Object orgId:orgIds){
                StaffingOrgEmp staffingOrgEmp = new StaffingOrgEmp((Long)orgId,empId,NumberUtils.toLong(enterpriseId));
                staffingOrgEmpService.insert(staffingOrgEmp);
            }

            for (String postId : postIds) {
                if (StringUtils.isBlank(postId)) {
                    continue;
                }
                StaffingPostEmp staffingPostEmp = new StaffingPostEmp(NumberUtils.toLong(postId), empId, NumberUtils.toLong(enterpriseId));
                result = baseMapper.insert(staffingPostEmp);
            }
        }
        return result;
    }
}
