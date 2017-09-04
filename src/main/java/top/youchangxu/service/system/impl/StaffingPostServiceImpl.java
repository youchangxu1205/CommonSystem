package top.youchangxu.service.system.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.system.StaffingPostMapper;
import top.youchangxu.model.system.StaffingPost;
import top.youchangxu.model.vo.PostOrgVO;
import top.youchangxu.service.system.IStaffingPostService;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/12.
 */
@Service("staffingPostService")
public class StaffingPostServiceImpl extends ServiceImpl<StaffingPostMapper,StaffingPost> implements IStaffingPostService {


    @Override
    public List<PostOrgVO> selectPostOrgList(Long enterpriseId) {
        return baseMapper.selectPostOrgList(enterpriseId);
    }
}
