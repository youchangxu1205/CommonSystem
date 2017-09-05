package top.youchangxu.service.engineering.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.engineering.EngineeringPatrolAttachMapper;
import top.youchangxu.model.engineering.EngineeringPatrolAttach;
import top.youchangxu.service.engineering.IEngineeringPatrolAttachService;

/**
 * Created by xcy on 2017/9/5.
 */
@Service("engineeringPatrolAttachService")
public class EngineeringPatrolAttachServiceImpl extends ServiceImpl<EngineeringPatrolAttachMapper, EngineeringPatrolAttach> implements IEngineeringPatrolAttachService {
}
