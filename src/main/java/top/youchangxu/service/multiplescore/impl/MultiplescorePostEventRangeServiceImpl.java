package top.youchangxu.service.multiplescore.impl;

import com.baomidou.mybatisplus.mapper.EntityWrapper;
import com.baomidou.mybatisplus.service.impl.ServiceImpl;
import org.springframework.stereotype.Service;
import top.youchangxu.mapper.multiplescore.MultiplesccorePostEventRangeMapper;
import top.youchangxu.model.system.MultiplescorePostEventRange;
import top.youchangxu.service.multiplescore.IMultiplescorePostEventRangeService;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/13.
 */
@Service("multiplescorePostEventRangeService")
public class MultiplescorePostEventRangeServiceImpl extends ServiceImpl<MultiplesccorePostEventRangeMapper, MultiplescorePostEventRange> implements IMultiplescorePostEventRangeService {
    @Override
    public boolean updateEventRanges(List<MultiplescorePostEventRange> multiplescorePostEventRanges, Long postId, Long enterpriseId) {
        baseMapper.delete(new EntityWrapper<MultiplescorePostEventRange>().eq("postHigherId", postId).eq("enterpriseId", enterpriseId));
        if (multiplescorePostEventRanges.size() != 0) {
            return insertBatch(multiplescorePostEventRanges);
        }
        return true;
    }
}
