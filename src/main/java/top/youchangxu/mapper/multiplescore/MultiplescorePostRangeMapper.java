package top.youchangxu.mapper.multiplescore;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.springframework.stereotype.Repository;
import top.youchangxu.model.multiplescore.MultiplescorePostRange;
import top.youchangxu.model.vo.PostRangeVO;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/12.
 */
@Repository
public interface MultiplescorePostRangeMapper extends BaseMapper<MultiplescorePostRange> {
    /**
     * 获取岗位的将扣分范围，岗位
     * @param postId
     * @return
     */
    List<PostRangeVO> selectPostRangeVOS(Long postId);

    /**
     * 获取不在某个岗位的将扣分范围内的岗位信息
     * @param postId
     * @return
     */
    List<PostRangeVO> selectPostNoRangeVOS(Long postId);
}
