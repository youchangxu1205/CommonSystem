package top.youchangxu.mapper.multiplescore;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.springframework.stereotype.Repository;
import top.youchangxu.model.system.MultiplescorePostRange;
import top.youchangxu.model.vo.PostRangeVO;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/12.
 */
@Repository
public interface MultiplescorePostRangeMapper extends BaseMapper<MultiplescorePostRange> {
    List<PostRangeVO> selectPostRangeVOS(Long postId);

    List<PostRangeVO> selectPostNoRangeVOS(Long postId);
}
