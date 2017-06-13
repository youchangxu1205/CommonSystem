package top.youchangxu.service.system;

import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.MultiplescorePostEventRange;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/13.
 */
public interface IMultiplescorePostEventRangeService extends IService<MultiplescorePostEventRange> {
    boolean updateEventRanges(List<MultiplescorePostEventRange> multiplescorePostEventRanges, Long postId, Long enterpriseId);
}
