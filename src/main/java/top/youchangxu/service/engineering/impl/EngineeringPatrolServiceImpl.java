package top.youchangxu.service.engineering.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.engineering.EngineeringPatrolMapper;
import top.youchangxu.model.engineering.EngineeringPatrol;
import top.youchangxu.service.engineering.IEngineeringPatrolService;

/**
 * Created by xcy on 2017/9/5.
 */
@Service("engineeringPatrolService")
public class EngineeringPatrolServiceImpl extends ServiceImpl<EngineeringPatrolMapper, EngineeringPatrol> implements IEngineeringPatrolService {
}
