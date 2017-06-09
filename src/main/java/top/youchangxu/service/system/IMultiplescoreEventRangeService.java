package top.youchangxu.service.system;

import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.MultiplescoreEventRange;

/**
 * Created by dtkj_android on 2017/6/9.
 */
public interface IMultiplescoreEventRangeService extends IService<MultiplescoreEventRange> {
    int updateEventRanges(String[] eventIds, Long empId, String enterpriseId);
}
