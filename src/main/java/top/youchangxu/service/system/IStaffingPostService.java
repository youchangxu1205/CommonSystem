package top.youchangxu.service.system;

import com.baomidou.mybatisplus.service.IService;
import top.youchangxu.model.system.StaffingPost;
import top.youchangxu.model.vo.PostOrgVO;
import top.youchangxu.model.vo.PostRangeVO;

import java.util.List;

/**
 * Created by dtkj_android on 2017/6/12.
 */
public interface IStaffingPostService extends IService<StaffingPost> {
    List<PostOrgVO> selectPostOrgList(Long enterpriseId);
}