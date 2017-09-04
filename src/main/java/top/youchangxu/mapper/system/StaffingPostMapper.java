package top.youchangxu.mapper.system;

import com.baomidou.mybatisplus.mapper.BaseMapper;
import org.springframework.stereotype.Repository;
import top.youchangxu.model.system.StaffingPost;
import top.youchangxu.model.vo.PostOrgVO;
import top.youchangxu.model.vo.PostRangeVO;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/12.
 */
@Repository
public interface StaffingPostMapper extends BaseMapper<StaffingPost> {
    List<PostOrgVO> selectPostOrgList(Long enterpriseId);
}
