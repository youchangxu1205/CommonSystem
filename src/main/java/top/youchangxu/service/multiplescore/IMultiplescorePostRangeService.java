package top.youchangxu.service.multiplescore;

import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.multiplescore.MultiplescorePostRange;
import top.youchangxu.model.vo.PostRangeVO;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/12.
 */
public interface IMultiplescorePostRangeService extends IService<MultiplescorePostRange> {
    List<PostRangeVO> selectPostRangeVOS(Long postId);

    List<PostRangeVO> selectPostNoRangeVOS(Long postId);

    boolean updateRanges(List<MultiplescorePostRange> multiplescorePostRanges, Long postId, Long enterpriseId);
}
