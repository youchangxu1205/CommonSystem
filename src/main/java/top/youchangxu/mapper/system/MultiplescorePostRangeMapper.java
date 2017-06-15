package top.youchangxu.mapper.system;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import top.youchangxu.model.system.MultiplescorePostRange;
import top.youchangxu.model.vo.PostRangeVO;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/12.
 */
public interface MultiplescorePostRangeMapper extends BaseMapper<MultiplescorePostRange> {
    List<PostRangeVO> selectPostRangeVOS(Long postId);

    List<PostRangeVO> selectPostNoRangeVOS(Long postId);
}
