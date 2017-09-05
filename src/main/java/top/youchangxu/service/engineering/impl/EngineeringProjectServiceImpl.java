package top.youchangxu.service.engineering.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.engineering.EngineeringProjectMapper;
import top.youchangxu.model.engineering.EngineeringProject;
import top.youchangxu.service.engineering.IEngineeringProjectService;

/**
 * Created by xcy on 2017/9/5.
 */
@Service("engineeringProjectService")
public class EngineeringProjectServiceImpl extends ServiceImpl<EngineeringProjectMapper,EngineeringProject> implements IEngineeringProjectService{
}
