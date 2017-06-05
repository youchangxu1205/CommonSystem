package top.youchangxu.service.system.impl;

import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.system.StaffingLogMapper;
import top.youchangxu.model.system.StaffingLog;
import top.youchangxu.service.system.IStaffingLogServicce;

/**
 * Created by dtkj_android on 2017/6/5.
 */
@Service
public class StaffingLogServiceImpl extends ServiceImpl<StaffingLogMapper,StaffingLog> implements IStaffingLogServicce {
}
