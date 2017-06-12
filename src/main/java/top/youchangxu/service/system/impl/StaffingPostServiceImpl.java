package top.youchangxu.service.system.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.system.StaffingPostMapper;
import top.youchangxu.model.system.StaffingPost;
import top.youchangxu.service.system.IStaffingPostService;

/**
 * Created by dtkj_android on 2017/6/12.
 */
@Service
public class StaffingPostServiceImpl extends ServiceImpl<StaffingPostMapper,StaffingPost> implements IStaffingPostService {
}
