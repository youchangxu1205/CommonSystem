package top.youchangxu.service.multiplescore.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.multiplescore.MultiplescoreEventMapper;
import top.youchangxu.model.system.MultiplescoreEvent;
import top.youchangxu.service.multiplescore.IMultiplescoreEventService;

/**
 * Created by dtkj_android on 2017/6/9.
 */
@Service
public class MultiplescoreEventServiceImpl extends ServiceImpl<MultiplescoreEventMapper, MultiplescoreEvent> implements IMultiplescoreEventService {
}
