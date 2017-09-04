package top.youchangxu.service.multiplescore.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.apache.commons.lang.StringUtils;
import org.apache.commons.lang.math.NumberUtils;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.multiplescore.MultiplescoreEventRangeMapper;
import top.youchangxu.model.system.MultiplescoreEventRange;
import top.youchangxu.service.multiplescore.IMultiplescoreEventRangeService;

/**
 * Created by dtkj_android on 2017/6/9.
 */
@Service("multiplescoreEventRangeService")
public class MultiplescoreEventRangeServiceImpl extends ServiceImpl<MultiplescoreEventRangeMapper, MultiplescoreEventRange> implements IMultiplescoreEventRangeService {
    @Override
    public int updateEventRanges(String[] eventIds, Long empId, String enterpriseId) {
        int result = 0;
        // 删除旧记录
        baseMapper.delete(new EntityWrapper<MultiplescoreEventRange>().eq("empId", empId).eq("enterpriseId", enterpriseId));
        // 增加新记录
        if (null != eventIds) {
            for (String eventId : eventIds) {
                if (StringUtils.isBlank(eventId)) {
                    continue;
                }
                MultiplescoreEventRange multiplescoreEventRange = new MultiplescoreEventRange();
                multiplescoreEventRange.setEmpId(empId);
                multiplescoreEventRange.setEventId(NumberUtils.toLong(eventId));
                multiplescoreEventRange.setEnterpriseId(NumberUtils.toLong(enterpriseId));
                result = baseMapper.insert(multiplescoreEventRange);
            }
        }
        return result;
    }
}
