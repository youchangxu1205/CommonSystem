package top.youchangxu.service.system;

import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.MultiplescoreRange;
import top.youchangxu.model.vo.PostRangeVO;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/12.
 */
public interface IMultiplesoreRangeService extends IService<MultiplescoreRange> {
     List<PostRangeVO> selectPostRangeVOS(Long postId);
}
